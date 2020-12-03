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
Get the password secret.
*/}}
{{- define "bee.secretName" -}}
{{- if .Values.beeConfig.existingSecret -}}
{{- printf "%s" .Values.beeConfig.existingSecret -}}
{{- else -}}
{{- printf "%s" (include "bee.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Get the password key to be retrieved from the secret.
*/}}
{{- define "bee.secretPasswordKey" -}}
{{- if and .Values.beeConfig.existingSecret .Values.beeConfig.existingSecretPasswordKey -}}
{{- printf "%s" .Values.beeConfig.existingSecretPasswordKey -}}
{{- else -}}
{{- printf "password" -}}
{{- end -}}
{{- end -}}

{{/*
Return Bee password.
*/}}
{{- define "bee.password" -}}
{{- if not (empty .Values.beeConfig.password) }}
    {{- .Values.beeConfig.password -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
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
Get the clef password secret.
*/}}
{{- define "bee.clefSecretName" -}}
{{- if .Values.clefSettings.existingPasswordSecret -}}
{{- printf "%s" .Values.clefSettings.existingPasswordSecret -}}
{{- else -}}
{{- printf "%s-clefpassword" (include "bee.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Get the clef password key to be retrieved from the secret.
*/}}
{{- define "bee.clefSecretPasswordKey" -}}
{{- if and .Values.clefSettings.existingPasswordSecret .Values.clefSettings.existingClefSecretPasswordKey -}}
{{- printf "%s" .Values.clefSettings.existingClefSecretPasswordKey -}}
{{- else -}}
{{- printf "password" -}}
{{- end -}}
{{- end -}}

{{/*
Return Clef password.
*/}}
{{- define "bee.clefPassword" -}}
{{- if not (empty .Values.clefSettings.password) }}
    {{- .Values.clefSettings.password -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
{{- end -}}

{{/*
Get the clefKeys secret.
*/}}
{{- define "bee.clefKeysSecretName" -}}
{{- if .Values.clefSettings.existingSecret -}}
{{- printf "%s" .Values.clefSettings.existingSecret -}}
{{- else -}}
{{- printf "%s-clef" (include "bee.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Get the clef key to be retrieved from the secret.
*/}}
{{- define "bee.clefKeysSecretKey" -}}
{{- if and .Values.clefSettings.existingSecret .Values.clefSettings.existingSecretClefKey -}}
{{- printf "%s" .Values.clefSettings.existingSecretClefKey -}}
{{- else -}}
{{- printf "clefKeys" -}}
{{- end -}}
{{- end -}}
