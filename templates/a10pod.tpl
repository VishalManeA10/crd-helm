{{/*
  #           - --watch-namespace=$(WATCH_NAMESPACE)
  #           - --ingress-class=a10-ext # Specifies a class of ingress. A10 Kubernetes Connector will only process Ingress resources with this value in the ingress class annotation. Can be used with --use-ingress-class-only. Default 'a10'.  Ingress class annotation will typically look like this kubernetes.io/ingress.class: "a10-ext"
  #           - --use-ingress-class-only=true #If true, A10 Kubernetes Connector will only process Ingress resources that has the ingress
  #           - -v=3
Create at container part
*/}}

{{- define "a10-connector.a10pod" -}}
- name: {{ template "a10-connector.fullname" . }}
  image: {{ template "a10-connector.image" . }}
  imagePullPolicy: {{ .Values.imageCredentials.pullPolicy }}
  env:
    - name: POD_NAMESPACE
      valueFrom:
          fieldRef:
            fieldPath: metadata.namespace
    - name: CONTROLLER_URL
      value: {{ .Values.lbUrl | quote }}
    - name: ACOS_USERNAME_PASSWORD_SECRETNAME
      value: {{ template "a10-connector.fullname" . }}-secret
    - name: PARTITION 
      value: {{ .Values.partition | quote }}
    - name: LOG_LEVEL
      value: {{ .Values.log.level }}
    - name: LOG_FILENAME
      value: {{ .Values.log.filename }}
    - name: LOG_FILE_MAXAGE
      value: {{ .Values.log.file_maxage | quote }}
    - name: LOG_ROTATION_SIZE
      value: {{ .Values.log.rotation_size | quote }}
    {{- if .Values.config_overlay.enable }}
    - name: CONFIG_OVERLAY
      value: {{ .Values.config_overlay.enable | quote }}
    - name: OVERLAY_ENDPOINT_IP
      value: {{ .Values.config_overlay.overlay_endpoint_ip }}
    - name: VTEP_ENCAPSULATION
      value: {{ .Values.config_overlay.vtep_encapsulation }}
    {{ end }}
  volumeMounts:
    - name: www-persistent-storage
      mountPath: {{ .Values.log.pod_location }}
  args:
    - --ingress-class={{ .Values.args.ingressClass }}
    - --use-node-external-ip={{ .Values.args.useNodeExternalIp }}
    - --patch-to-update={{ .Values.args.PatchToUpdate }}
    - --include-master={{ .Values.args.includeMaster }}
    - --safe-acos-delete={{ .Values.args.safeDelete }} 
    - --use-ingress-class-only={{ .Values.args.useIngressClassOnly }}  
    - --include-all-nodes={{ .Values.args.includeAllNodes }}
    - -v=3 
{{- end }}