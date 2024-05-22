{{/*
Expand the name of the chart.
*/}}


{{- define "sitermagent.truncname" -}}
{{- if .Values.md5 }}
{{- if eq .Values.deploymentType "Deployment" }}
{{- printf "%s-conf-%s" .Chart.Name .Values.md5 | replace "_" "-" | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-conf-%s" .Chart.Name .Values.deploymentType | replace "_" "-" | trunc 63 | trimSuffix "-" | lower }}
{{- end }}
{{- else }}
{{- printf "%s-conf-%s" .Chart.Name .Values.deploymentType | replace "_" "-" | trunc 63 | trimSuffix "-" | lower }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sitermagent.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sitermagent.labels" -}}
helm.sh/chart: {{ include "sitermagent.chart" . }}
{{ include "sitermagent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sitermagent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sitermagent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sitermagent.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "sitermagent.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
