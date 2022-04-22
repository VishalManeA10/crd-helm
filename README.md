<<<<<<< HEAD
**Helm Chart for tkc 1.10 release**

HELM chart that customers can use to deploy and manage TKC in Openshift and generic Kubernetes. 
Instead of having to write separate YAML files for TKC application, we can simply create a Helm chart and let Helm deploy the application to the cluster for us. Helm charts contain templates for various Kubernetes resource that combine to form an application.

**Installing the chart**

> helm install tkc tkc_1.10_IPinIP

**Updating the chart**

> helm upgrade -f tkc_1.10_IPinIP/values.yaml tkc tkc_1.10_IPinIP

**Design**

TKC HELM chart structure 
-----
-----




**Helm chart components details**

- Chart.yaml -  Metadata: Helm chart consists of metadata that is used to help describe what the application is, define constraints on the minimum required Kubernetes and/or Helm version and manage the version of your chart. All this metadata lives in the Chart.yaml file.  

- values.yaml: This is where you define all the values you want to inject into your templates. The values in values.yaml is used to expose configuration that can be set at the time of deployment. 

- templates: This directory is where we put the actual manifest you are deploying with the chart. Eg. For  TKC application deployment we need the secret, ingress controller.  

- templates/_helpers.tpl and templates/a10pod.tpl:  These files expected to contain partials. A partial, which is also called a subtemplate, is a template in a file that can be used by other templates. For example, a partial can contain utility functions. 


**Chart parameters:**

| Parameter                                                                                              | Required | Description                                                                                                                                                                       |
|--------------------------------------------------------------------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| imageCredentials.pullSecret                                                                            | Optional | Pull secret used to pull from a private image registry.                                                                                                                           |
| imageCredentials.registry.url                                                                          | Optional | Docker registry url. Overrides global.registry.url                                                                                                                                |
| imageCredentials.repoPath                                                                              | Optional | Repository path                                                                                                                                                                   |
| imageCredentials.pullPolicy                                                                            | Optional | Pull policy for image.                                                                                                                                                            |
| productInfo.name                                                                                       | Required | Name of the product.                                                                                                                                                              |
| replicaCount                                                                                           | Required | Replica count for the TKC deployment                                                                                                                                              |
| ingress.serviceName                                                                                    | Required | Name of the service                                                                                                                                                               |
| ingress.servicePort                                                                                    | Required | Port used for the service                                                                                                                                                         |
| ingress.serviceSecret                                                                                  | Optional | Secret used for the service                                                                                                                                                       |
| ingress.annotations.acos.a10networks.com/health-monitors                                               | Optional | Value of this annotation is a json document that is an array of 1 or more health monitors. TKC sets up health monitor on a slb service-group only                                 |
| ingress.annotations.acos.a10networks.com/virtual-server                                                | Required | Value of this annotation is a json document that can have a maximum of two keys inside it. Supported keys are name and vip.                                                       |
| ingress.annotations.acos.a10networks.com/virtual-ports                                                 | Required | Value of this annotation is a json document that is an array of 1 or more virtual ports                                                                                           |
| ingress.annotations.<k8s-service-name>.acos.a10networks.com/service-group                              | Optional | The annotation is used to override default values while configuring slb service-group.                                                                                            |
| ingress.annotations.acos.a10networks.com/template-cipher                                               | Optional | This field is json string containing name and userTag keys                                                                                                                        |
| ingress.annotations.acos.a10networks.com/client-ssl-template                                           | Optional | This field contain configurations for server SSL template                                                                                                                         |
| ingress.annotations.<client-template-name>.acos.a10networks.com/client-template-ec-list                | Optional | Value of the annotation is the elliptic curve name.                                                                                                                               |
| ingress.annotations.<client-template-name>.acos.a10networks.com/client-template-crl-cert-list          | Optional | Value of the annotation is the Kubernetes secret name for CRL Certificate Name.                                                                                                   |
| ingress.annotations.<client-template-name>.acos.a10networks.com/client-template-server-tls-secret-list | Optional | The values that can be used to setup the client template's server TLS secret are cert and passphrase                                                                              |
| ingress.annotations.<client-template-name>.acos.a10networks.com/client-template-server-name-list       | Optional | The values that can be used to setup the client template's server name list are                                                                                                   |
| ingress.annotations.<template-cipher-name>.acos.a10networks.com/template-cipher-cfg                    | Optional | The values that can be used for template cipher configuration are cipher-suite and priority                                                                                       |
| ingress.annotations.<template-cipher-name>.acos.a10networks.com/template-cipher13-cfg                  | Optional | The values that can be used for template cipher13 configuration are cipher13-suite and priority.                                                                                  |
| ingress.annotations.<client-template-name>.acos.a10networks.com/client-template-server-name-list       | Optional | The values that can be used to setup the client template's server name list are server-name, server-tls-secret, server-chain, server-passphrase, server-name-alternate, is-regex	 |
| ingress.annotations.acos.a10networks.com/server-ssl-template                                           | Optional | This field contain configurations for server SSL template                                                                                                                         |
| ingress.annotations.<server-ssl-template-name>.acos.a10networks.com/server-cert                        | Optional | The values that can be used for Server Certificate are certName, key, passphrase                                                                                                  |
| ingress.annotations.<server-ssl-template-name>.acos.a10networks.com/server-certificate-error           | Optional | The values that can be used for Server Certificate error are error-type                                                                                                           |
| ingress.annotations.<server-ssl-template-name>.acos.a10networks.com/server-template-ec-list            | Optional | Value of the annotation is the elliptic curve name                                                                                                                                |
| ingress.annotations.<server-ssl-template-name>.acos.a10networks.com/server-ca-cert-config              | Optional | The values that can be used for server CA Cert configuration are ca-cert, server-ocsp-sg, server-ocsp-srvr                                                                        |
| ingress.annotations.<server-ssl-template-name>.acos.a10networks.com/server-template-crl-list           | Optional | Value of the annotation is the names of the server template's Certificate Revocation Lists.                                                                                       |
| images.a10Connector.name                                                                               | Required | Name of the a10-connector image                                                                                                                                                   |
| images.a10Connector.tag                                                                                | Required | Version of the a10-connector image                                                                                                                                                |
| images.a10Connector.pullPolicy                                                                         | Required | a10-connector image pull policy                                                                                                                                                   |
| service.type                                                                                           | Required | Type of service                                                                                                                                                                   |
| service.clusterIP                                                                                      | Optional | Cluster IP address of the loadbalancer service                                                                                                                                    |
| service.externalIPs                                                                                    | Optional | list of external IP addresses.                                                                                                                                                    |
| service.loadBalancerIP                                                                                 | Optional | loadbalancer IP address                                                                                                                                                           |
| service.loadBalancerSourceRanges                                                                       | Optional | loadbalancer source IP ranges                                                                                                                                                     |
| service.protocol                                                                                       | Optional | Service protocol                                                                                                                                                                  |
| service.port                                                                                           | Optional | Service port                                                                                                                                                                      |
| config_overlay.enable                                                                                  | Optional | Flag to enable IP over IP tunneling                                                                                                                                               |
| config_overlay.overlay_endpoint_ip                                                                     | Optional | Any interface from the ethernet list can be used as a data interface. The IP address of the data interface is provided with this variable for vtep configuration to proceed.      |
| config_overlay.vtep_encapsulation                                                                      | Optional | Provides a choice of different types of encapsulation techniques present in Calico and Thunder device                                                                             |
| secret.username                                                                                        | Required | username for vthunder device                                                                                                                                                      |
| secret.password                                                                                        | Required | password for vthunder device                                                                                                                                                      |
| partition                                                                                              | Required | partition used for vthunder configurations                                                                                                                                        |
| lbUrl                                                                                                  | Required | The management IP for your vthunder device                                                                                                                                        |
| args.allNodes                                                                                          | Required | Include all nodes flag                                                                                                                                                            |
| args.safeDelete                                                                                        | Required | Safe acos delete flag                                                                                                                                                             |

Uninstall HELM chart application release

> helm uninstall tkc 

Uninstall removes all kubernetes resources related to tkc application 
 
=======
# helm chart

>>>>>>> ae16c446ef8fcbd29629411ee49ace04af7f2a6e
