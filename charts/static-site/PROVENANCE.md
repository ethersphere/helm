# Provenance

This chart is vendored verbatim from [gimlet-io/onechart](https://github.com/gimlet-io/onechart)
at tag `v0.73.0`, path `charts/static-site`.

The upstream project was archived on 2025-04-01 and its chart repository
(`https://chart.onechart.dev`) no longer resolves, so the chart is republished here
to keep existing deployments installable.

- Upstream: https://github.com/gimlet-io/onechart/tree/v0.73.0/charts/static-site
- Upstream licence: Apache-2.0 (see `LICENSE` in this directory)
- Templates are unmodified; `helm template` output is byte-for-byte identical to the
  original `static-site-0.73.0.tgz` artifact.

## Local versions

Templates and values remain upstream `v0.73.0` verbatim. The chart version is
bumped locally only when repackaging metadata changes, because `chart-testing`
requires a version bump for any modified chart.

- `0.73.0` - initial vendoring.
- `0.73.1` - declare the vendored `common` subchart as
  `repository: file://charts/common` and ship it unpacked rather than as a
  tarball. Upstream's `file://../common` assumed onechart's monorepo layout and
  broke `helm dependency update`, which failed the Release workflow for the
  whole repository. Also strips two trailing-whitespace occurrences from
  `values.yaml` that `chart-testing`'s yamllint rejects. No template changes
  and no semantic values changes; rendered output is unchanged apart from the
  `helm.sh/chart` version label. Adds the `maintainers`, `home` and `icon`
  metadata that `chart-testing` requires and that the other charts in this
  repository already carry; upstream shipped none.
