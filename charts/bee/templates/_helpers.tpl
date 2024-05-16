{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "bee.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bee.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bee.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create image name combining repository and tag or digest.
Digest takes presedance over tag.
*/}}
{{- define "bee.image" -}}
{{- if .Values.image.digest -}}
{{- printf "%s@%s" .Values.image.repository .Values.image.digest -}}
{{- else -}}
{{- printf "%s:%s" .Values.image.repository .Values.image.tag -}}
{{- end -}}
{{- end -}}

{{/*
Common labels.
*/}}
{{- define "bee.labels" -}}
helm.sh/chart: {{ include "bee.chart" . }}
{{ include "bee.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bee.chartVCT" -}}
{{- printf "%s" .Chart.Name | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels for volumeClaimTemplates.
*/}}
{{- define "bee.labelsVCT" -}}
helm.sh/chart: {{ include "bee.chartVCT" . }}
{{ include "bee.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels.
*/}}
{{- define "bee.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bee.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Selector labels.
*/}}
{{- define "bee.singlePodSts" -}}
labelFilter: {{ .Values.singlePodSts.labelFilter }}
{{- end -}}

{{/*
Create the name of the service account to use.
*/}}
{{- define "bee.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "bee.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Get the password key to be retrieved from the secret.
*/}}
{{- define "bee.secretPasswordKey" -}}
{{- if and .Values.existingSecret .Values.existingSecretPasswordKey -}}
{{- printf "%s" .Values.existingSecretPasswordKey -}}
{{- else -}}
{{- printf "password" -}}
{{- end -}}
{{- end -}}

{{/*
Return Bee password.
*/}}
{{- define "bee.password" -}}
{{- if not (empty .Values.password) }}
    {{- .Values.password -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
{{- end -}}

{{/*
Define config parameters api-addr, p2p-addr
*/}}
{{- define "bee.config.api_port" -}}
{{- $full_api_addr := index .Values.beeConfig "api-addr" -}}
{{- $api_port := (split ":" $full_api_addr )._1 }}
{{- printf "%s" $api_port -}}
{{- end -}}
{{- define "bee.config.p2p_port" -}}
{{- $full_p2p_addr := index .Values.beeConfig "p2p-addr" -}}
{{- $p2p_port := (split ":" $full_p2p_addr )._1 }}
{{- printf "%s" $p2p_port -}}
{{- end -}}


{{/*
Get the libp2pKeys secret.
*/}}
{{- define "bee.libp2pKeysSecretName" -}}
{{- if .Values.libp2pSettings.existingSecret -}}
{{- printf "%s" .Values.libp2pSettings.existingSecret -}}
{{- else -}}
{{- printf "%s-libp2p" (include "bee.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Get the libp2p key to be retrieved from the secret.
*/}}
{{- define "bee.libp2pKeysSecretKey" -}}
{{- if and .Values.libp2pSettings.existingSecret .Values.libp2pSettings.existingSecretLibp2pKey -}}
{{- printf "%s" .Values.libp2pSettings.existingSecretLibp2pKey -}}
{{- else -}}
{{- printf "libp2pKeys" -}}
{{- end -}}
{{- end -}}

{{/*
Get the swarmKeys secret.
*/}}
{{- define "bee.swarmKeysSecretName" -}}
{{- if .Values.swarmSettings.existingSecret -}}
{{- printf "%s" .Values.swarmSettings.existingSecret -}}
{{- else -}}
{{- printf "%s-swarm" (include "bee.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Get the swarm key to be retrieved from the secret.
*/}}
{{- define "bee.swarmKeysSecretKey" -}}
{{- if and .Values.swarmSettings.existingSecret .Values.swarmSettings.existingSecretSwarmKey -}}
{{- printf "%s" .Values.swarmSettings.existingSecretSwarmKey -}}
{{- else -}}
{{- printf "swarmKeys" -}}
{{- end -}}
{{- end -}}

{{/*
Create gatewayProxy image name combining repository and tag or digest.
Digest takes presedance over tag.
*/}}
{{- define "gatewayProxy.image" -}}
{{- if .Values.gatewayProxy.image.digest -}}
{{- printf "%s@%s" .Values.gatewayProxy.image.repository .Values.gatewayProxy.image.digest -}}
{{- else -}}
{{- printf "%s:%s" .Values.gatewayProxy.image.repository .Values.gatewayProxy.image.tag -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper Storage Class.
*/}}
{{- define "bee.storageClass" -}}
{{- if .Values.persistence.storageClass -}}
{{- if (eq "-" .Values.persistence.storageClass) -}}
{{- printf "storageClassName: \"\"" -}}
{{- else }}
{{- printf "storageClassName: \"%s\"" .Values.persistence.storageClass -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "bee.statestoreStorageClass" -}}
{{- if and .Values.persistence.separateStatestore.storageClass .Values.persistence.separateStatestore.enabled -}}
{{- if (eq "-" .Values.persistence.separateStatestore.storageClass) -}}
{{- printf "storageClassName: \"\"" -}}
{{- else }}
{{- printf "storageClassName: \"%s\"" .Values.persistence.separateStatestore.storageClass -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "bee.localstoreStorageClass" -}}
{{- if and .Values.persistence.separateLocalstore.storageClass .Values.persistence.separateLocalstore.enabled -}}
{{- if (eq "-" .Values.persistence.separateLocalstore.storageClass) -}}
{{- printf "storageClassName: \"\"" -}}
{{- else }}
{{- printf "storageClassName: \"%s\"" .Values.persistence.separateLocalstore.storageClass -}}
{{- end -}}
{{- end -}}
{{- end -}}
