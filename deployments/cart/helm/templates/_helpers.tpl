{{/*
Resources of the Container
*/}}
{{- define "container.resources" -}}
{{- if .Values.containers.resources -}}
resources:
  limits:
    cpu: {{ (.Values.containers.resources.limits).cpu | default "500m" }}
    memory: {{ (.Values.containers.resources.limits).memory | default "100Mi" }}
  requests:
    cpu: {{ (.Values.containers.resources.requests).cpu | default "5m" }}
    memory: {{ (.Values.containers.resources.requests).memory | default "10Mi" }}
{{- end -}}
{{- end -}}

{{/*
container security user group
*/}}
{{- define "container.securityContext" -}}
{{- if (.Values.containers).runAs -}}
securityContext:
  runAsUser: {{ default 1001 .Values.containers.runAs.user }}
  runAsGroup: {{ default 1001 .Values.containers.runAs.group }}
{{- end -}}
{{- end -}}


{{/*
Expand the name of the chart.
*/}}
{{- define "cart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cart.fullname" -}}
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
