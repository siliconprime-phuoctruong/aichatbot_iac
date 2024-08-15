locals {
  default_tags = var.default_tags_enable ? {
    environment = var.environment
    project     = var.project
    owner       = var.owner
  } : {}

  tenant_id = coalesce(
    var.tenant_id,
    data.azurerm_client_config.current_config.tenant_id,
  )

  ## Azure Kubernetes Service
  aks_admin  = join("", [var.project, var.environment])
  aks_prefix = join("-", [var.project, var.environment])
  appgw_cidr = !var.use_brown_field_application_gateway && !var.bring_your_own_vnet ? "10.225.0.0/16" : "10.52.1.0/24"
  nodes = {
    for i in range(var.aks_nodepool_count) : "worker${i}" => {
      name                  = substr("worker${i}${random_id.id.hex}", 0, 8)
      vm_size               = var.aks_node_size
      node_count            = var.aks_node_count
      vnet_subnet_id                     = data.terraform_remote_state.shared-infras.outputs.subnet_ids["AICHATBOT-NONPRD-T1-AKS"]
      create_before_destroy = i % 2 == 0
      workload_runtime      = "OCIContainer"
    }
  }

  ## Azure Database for flexible MySQL
  mysql_server   = join("", [var.project, var.environment])
  admin_username = join("", [var.project, var.environment, "admin"])

  ## Data form shared infrastructure
  aks_azrg_name   = data.terraform_remote_state.shared-infras.outputs.azrg_name["aks"]
  aks_subnet_id   = data.terraform_remote_state.shared-infras.outputs.subnet_ids["AICHATBOT-NONPRD-T1-AKS"]
  be_subnet_id    = data.terraform_remote_state.shared-infras.outputs.subnet_ids["AICHATBOT-NONPRD-T1-BE"]
  appgw_id        = data.terraform_remote_state.shared-infras.outputs.appgw_id
  appgw_subnet_id = data.terraform_remote_state.shared-infras.outputs.subnet_ids["AICHATBOT-NONPRD-T1-APPGW"]
  #pod_subnet_id   = data.terraform_remote_state.shared-infras.outputs.subnet_ids["AICHATBOT-NONPRD-T1-POD"]
  mysql_dns_id  = data.terraform_remote_state.shared-infras.outputs.private_dns_zone_id["privatelink.mysql.database.azure.com"]

  # FEDERATED IDENTITY
  f_audience = ["api://AzureADTokenExchange"]
  f_subject  = join("",["system:serviceaccount:", var.kar_namespace, ":karpenter-sa"])

  # KARPENTER
  karpenter_template = <<EOF
replicas: 1 # for better debugging experience
controller:
  env:
    - name: FEATURE_GATES
      value: Drift=true
    - name: LEADER_ELECT # disable leader election for better debugging / troubleshooting experience
      value: "false"
    # disable HTTP/2 to reduce ARM throttling on large-scale tests;
    # with this in place write (and read) QPS can be increased too
    #- name: GODEBUG
    #  value: http2client=0

    # options
    - name: CLUSTER_NAME
      value: ${CLUSTER_NAME}
    - name: CLUSTER_ENDPOINT
      value: ${CLUSTER_ENDPOINT}
    - name: KUBELET_BOOTSTRAP_TOKEN
      value: ${BOOTSTRAP_TOKEN}
    - name: SSH_PUBLIC_KEY
      value: "${SSH_PUBLIC_KEY}"
    - name: NETWORK_PLUGIN
      value: "azure"
    - name: NETWORK_POLICY
      value: ""
    - name: VNET_SUBNET_ID
      value: ${VNET_SUBNET_ID}
    - name: NODE_IDENTITIES
      value: ${NODE_IDENTITIES}

    # Azure client settings
    - name: ARM_SUBSCRIPTION_ID
      value: ${AZURE_SUBSCRIPTION_ID}
    - name: LOCATION
      value: ${AZURE_LOCATION}
    # settings for managed workload identity
    - name: ARM_USE_CREDENTIAL_FROM_ENVIRONMENT
      value: "true"
    - name: ARM_USE_MANAGED_IDENTITY_EXTENSION
      value: "false"
    - name: ARM_USER_ASSIGNED_IDENTITY_ID
      value: ""
    - name: AZURE_NODE_RESOURCE_GROUP
      value: ${AZURE_RESOURCE_GROUP_MC}
serviceAccount:
  name: ${KARPENTER_SERVICE_ACCOUNT_NAME}
  annotations:
    azure.workload.identity/client-id: ${KARPENTER_USER_ASSIGNED_CLIENT_ID}
podLabels:
  azure.workload.identity/use: "true"
  EOF
}