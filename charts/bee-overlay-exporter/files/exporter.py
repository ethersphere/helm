#!/usr/bin/env python3
"""Bee Overlay Exporter

Enriches bee metrics with a `neighborhood` label so per-neighborhood
aggregations become possible in PromQL.

Behavior:
  1. Lists pods via the in-cluster k8s API with label selector
     app.kubernetes.io/name=bee across the configured namespaces.
  2. For each bee pod, HTTP GETs pod_ip:1633/addresses to read the overlay.
  3. Emits `bee_overlay_info{pod,namespace,overlay,neighborhood_d8,
     neighborhood_d9,neighborhood_d11}` = 1.

Join example (bee_pod/bee_namespace avoid clashing with scrape-target labels):
  max by (neighborhood_d9) (
    bee_salud_neighbors * on(pod,namespace) group_left(neighborhood_d9)
    label_replace(
      label_replace(bee_overlay_info, "pod", "$1", "bee_pod", "(.*)"),
      "namespace", "$1", "bee_namespace", "(.*)"
    )
  )
"""

import logging
import os
import signal
import sys
import time

import requests
from kubernetes import client, config
from prometheus_client import Gauge, CollectorRegistry, start_http_server

logging.basicConfig(
    level=os.getenv("LOG_LEVEL", "INFO").upper(),
    format="%(asctime)s %(levelname)s %(message)s",
)
log = logging.getLogger("bee-overlay-exporter")

NAMESPACES = [n.strip() for n in os.getenv("NAMESPACES", "bee,bee-sla").split(",") if n.strip()]
LABEL_SELECTOR = os.getenv("LABEL_SELECTOR", "app.kubernetes.io/name=bee")
BEE_API_PORT = int(os.getenv("BEE_API_PORT", "1633"))
POLL_INTERVAL = int(os.getenv("POLL_INTERVAL", "300"))
METRICS_PORT = int(os.getenv("METRICS_PORT", "9102"))
REQUEST_TIMEOUT = int(os.getenv("REQUEST_TIMEOUT", "5"))
CLUSTER_LABEL = os.getenv("CLUSTER_LABEL", "")

registry = CollectorRegistry()

overlay_info = Gauge(
    "bee_overlay_info",
    "Constant 1 gauge labeled with each bee's overlay and neighborhood prefixes",
    ["bee_pod", "bee_namespace", "overlay", "neighborhood_d8", "neighborhood_d9", "neighborhood_d11"],
    registry=registry,
)

scrape_duration = Gauge(
    "bee_overlay_exporter_scrape_duration_seconds",
    "Duration of last scrape cycle",
    registry=registry,
)
scrape_pods_total = Gauge(
    "bee_overlay_exporter_pods_total",
    "Number of bee pods discovered",
    registry=registry,
)
scrape_pods_ok = Gauge(
    "bee_overlay_exporter_pods_ok",
    "Number of bee pods whose overlay was fetched successfully",
    registry=registry,
)
last_scrape_time = Gauge(
    "bee_overlay_exporter_last_scrape_timestamp",
    "Unix timestamp of last successful scrape",
    registry=registry,
)


def load_k8s():
    try:
        config.load_incluster_config()
        log.info("using in-cluster k8s config")
    except config.ConfigException:
        config.load_kube_config()
        log.info("using local kubeconfig")
    return client.CoreV1Api()


def neighborhood_prefix(overlay_hex: str, depth: int) -> str:
    """Return the first `depth` bits of overlay as a `0b`-prefixed bitstring.

    Matches swarmscan's label format for depth=8 (e.g. "0b01101000").
    """
    # overlay_hex is a 64-hex-char string; convert to a 256-bit int
    n = int(overlay_hex, 16)
    # shift right to keep only the top `depth` bits
    top = n >> (256 - depth)
    return "0b" + bin(top)[2:].zfill(depth)


def fetch_overlay(pod_ip: str) -> str | None:
    try:
        r = requests.get(
            f"http://{pod_ip}:{BEE_API_PORT}/addresses", timeout=REQUEST_TIMEOUT
        )
        r.raise_for_status()
        return r.json().get("overlay")
    except requests.RequestException as e:
        log.debug("overlay fetch failed for %s: %s", pod_ip, e)
        return None


def scrape(core: client.CoreV1Api):
    start = time.time()
    overlay_info.clear()

    total = 0
    ok = 0

    for ns in NAMESPACES:
        try:
            pods = core.list_namespaced_pod(ns, label_selector=LABEL_SELECTOR).items
        except client.ApiException as e:
            log.warning("list_namespaced_pod failed for %s: %s", ns, e)
            continue

        for pod in pods:
            total += 1
            name = pod.metadata.name
            pod_ip = pod.status.pod_ip
            phase = pod.status.phase

            if phase != "Running" or not pod_ip:
                continue

            overlay = fetch_overlay(pod_ip)
            if not overlay:
                continue

            try:
                nd8 = neighborhood_prefix(overlay, 8)
                nd9 = neighborhood_prefix(overlay, 9)
                nd11 = neighborhood_prefix(overlay, 11)
            except ValueError as e:
                log.warning("bad overlay for %s: %s (%s)", name, overlay, e)
                continue

            overlay_info.labels(
                bee_pod=name, bee_namespace=ns, overlay=overlay,
                neighborhood_d8=nd8, neighborhood_d9=nd9, neighborhood_d11=nd11,
            ).set(1)
            ok += 1

    scrape_pods_total.set(total)
    scrape_pods_ok.set(ok)
    scrape_duration.set(time.time() - start)
    last_scrape_time.set(time.time())
    log.info("scrape complete: %d/%d bees resolved in %.1fs", ok, total, time.time() - start)


def main():
    log.info(
        "bee-overlay-exporter starting port=%d namespaces=%s interval=%ds",
        METRICS_PORT, NAMESPACES, POLL_INTERVAL,
    )
    core = load_k8s()
    start_http_server(METRICS_PORT, registry=registry)

    running = True

    def on_signal(signum, _frame):
        nonlocal running
        log.info("signal %d received, shutting down", signum)
        running = False

    signal.signal(signal.SIGTERM, on_signal)
    signal.signal(signal.SIGINT, on_signal)

    scrape(core)
    while running:
        time.sleep(POLL_INTERVAL)
        if running:
            try:
                scrape(core)
            except Exception as e:
                log.exception("scrape failed: %s", e)

    sys.exit(0)


if __name__ == "__main__":
    main()
