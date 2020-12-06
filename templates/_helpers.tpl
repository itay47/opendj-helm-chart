{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "opendj.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "opendj.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- $name := $name | trunc 63 | trimSuffix "-" -}}
{{- printf "%s-%s" $name .Release.Name -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for networkpolicy.
*/}}
{{- define "networkPolicy.apiVersion" -}}
{{- if and (ge .Capabilities.KubeVersion.Minor "4") (le .Capabilities.KubeVersion.Minor "6") -}}
{{- print "extensions/v1beta1" -}}
{{- else if ge .Capabilities.KubeVersion.Minor "7" -}}
{{- print "networking.k8s.io/v1" -}}
{{- end -}}
{{- end -}}

{{- /*
chartref prints a chart name and version.
It does minimal esopendjng for use in Kubernetes labels.
Example output:
*/ -}}
{{- define "opendj.chartref" -}}
{{- replace "+" "_" .Chart.Version | printf "%s-%s" .Chart.Name -}}
{{- end -}}

{{- /*
labels.standard prints the standard labels.
The standard labels are frequently used in metadata.
*/ -}}
{{- define "opendj.labels.standard" -}}
app: {{ template "opendj.name" . }}
chart: {{ template "opendj.chartref" . }}
heritage: {{ .Release.Service | quote }}
release: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Return the masters replica set string for tarantool replication.
*/}}
{{- define "opendj.masterServer" -}}
{{- $fullname := include "opendj.fullname" . -}}
{{- $releaseNamespace := .Release.Namespace -}}
{{- if $fullname -}}
{{- printf "\"%s-0.%s.%s.svc.cluster.local\"" $fullname $fullname $releaseNamespace -}}
{{- else -}}}}
{{- printf "\"\"" -}}
{{- end -}}
{{- end -}}