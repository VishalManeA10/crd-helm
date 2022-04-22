{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "a10-connector.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create version
*/}}
{{- define "a10-connector.version" -}}
{{- printf "%s" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "a10-connector.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "a10-connector.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Expand the name of the Docker image.
*/}}
{{- define "a10-connector.image" -}}
{{- printf "%s:%s" .Values.images.a10Connector.name .Values.images.a10Connector.tag -}}
{{- end -}}

{{/*
Create image pull secrets.
*/}}
{{- define "a10-connector.pullSecrets" -}}
  {{- if .Values.imageCredentials.pullSecret -}}
    {{- print .Values.imageCredentials.pullSecret -}}
  {{- end -}}
{{- end -}}

{{/*
Default labels attached to all the k8s resources
*/}}
{{- define "a10-connector.helm-labels" }}
  chart: {{ template "a10-connector.chart" . }}
  release: {{ .Release.Name }}
  app: {{ template "a10-connector.name" .}}
{{- end}}

{{/*
Product Information Helm Annotations
*/}}
{{- define "a10-connector.helm-annotations" }}
  product-name: {{ .Values.productInfo.name }}
{{- end }}


{{/*
namespace name
*/}}
{{- define "a10-connector.namespace" }}
{{- printf "%s" .Release.Namespace }}
{{- end }}



# {{/*
# Default name for health monitor k8s resources
# */}}
# {{- define "a10-connector.helm-hm-name" }}
# name: {{ template "a10-connector.fullname" . }}-healthmonitor
# {{- end}}


# {{/*
# Default name for natpool k8s resources
# */}}
# {{- define "a10-connector.helm-np-name" }}
# poolName: {{ template "a10-connector.fullname" . }}-natpool
# {{- end}}

# {{/*
# Default name for service group k8s resources
# */}}
# {{- define "a10-connector.helm-sg-name" }}
# name: {{ template "a10-connector.fullname" . }}-servicegroup
# {{- end}}


# {{/*
# Default name for cipher template  k8s resources
# */}}
# {{- define "a10-connector.helm-ct-name" }}
# name: {{ template "a10-connector.fullname" . }}-ciphertemplate
# {{- end}}

# {{/*
# Default name for clientssl k8s resources
# */}}
# {{- define "a10-connector.helm-cssl-name" }}
# name: {{ template "a10-connector.fullname" . }}-clientssl
# {{- end}}


# {{/*
# Default name for serverssl k8s resources
# */}}
# {{- define "a10-connector.helm-sssl-name" }}
# name: {{ template "a10-connector.fullname" . }}-serverssl
# {{- end}}


# {{/*
# Default name for virtual server k8s resources
# */}}
# {{- define "a10-connector.helm-vs-name" }}
# name: {{ template "a10-connector.fullname" . }}-virtualserver
# {{- end}}