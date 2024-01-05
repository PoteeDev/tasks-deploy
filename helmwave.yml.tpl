project: "Example: apps per own namespace"
version: "0.30.0"

registries:
  - host: ghcr.io


repositories:
  - name: minio
    url: https://charts.min.io
  - name: oauth2-proxy 
    url: https://oauth2-proxy.github.io/manifests
  - name: zitadel
    url: https://charts.zitadel.com
  - name: cockroachdb
    url: https://charts.cockroachdb.com

# General options
.options: &options
  wait: true
  wait_for_jobs: true
  force: false
  timeout: 10m
  atomic: false
  max_history: 3
  create_namespace: true

releases:
{{- with readFile "vars.yml" | fromYaml | get "releases" }}
{{- range $v := . }}
#################################
#                               #
#      {{ $v | get "name" }}
#                               #
#################################
- name: {{ $v | get "name" }}
  chart:
    name: {{ $v | get "repo" }}/{{ $v | get "name" }}
  namespace: {{ $v | get "name" }}
  tags: [{{ $v | get "name" }}]
  {{- if $v.depends_on }}
  depends_on: {{ $v | get "depends_on" }}
  {{- end }}
  values:
    - values/{{ requiredEnv "CI_ENVIRONMENT_NAME" }}/{{ $v | get "name" }}.yml
  <<: *options

{{ end }}
{{- end }}

