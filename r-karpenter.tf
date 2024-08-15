#--------------------------------------------------------------------------------------------------------------------
# AZURE MANAGED IDENTITY
#--------------------------------------------------------------------------------------------------------------------
module "aks_identity" {
  source              = "./modules/identity"

  location            = var.location
  identity_name       = join("",[var.project, var.environment, "karpenter"])
  resource_group_name = local.aks_azrg_name
}

#--------------------------------------------------------------------------------------------------------------------
# FEDERATED IDENTITY
#--------------------------------------------------------------------------------------------------------------------
module "federated_ident" {
  source = "./modules/identity/federated"

  resource_group_name = local.aks_azrg_name
  parent_id           = module.aks_identity.id
  f_audience          = local.f_audience
  f_name              = join("",[var.project, var.environment, "karpenter_ID"])
  f_issuer            = module.aks.oidc_issuer_url
  subject             = local.f_subject

  depends_on = [ module.aks, module.aks_identity ]
}

#--------------------------------------------------------------------------------------------------------------------
# ROLE ASSIGNMENT
#--------------------------------------------------------------------------------------------------------------------
module "karpenter_role" {
  source = "./modules/role_assign"
  for_each = toset(var.karpenter_role)

  role             = each.key
  aks_scope        = join("", ["/subscriptions/",data.azurerm_client_config.current_config.subscription_id,"/resourceGroups/",module.aks.node_resource_group])
  aks_principal_id = module.aks_identity.principal_id

  depends_on = [ module.aks, module.aks_identity ]
}

#--------------------------------------------------------------------------------------------------------------------
# NULL RESOURCE
#--------------------------------------------------------------------------------------------------------------------
resource "null_resource" "karvalues" {

  provisioner "local-exec" {
  command = <<EOT
    curl -sO https://raw.githubusercontent.com/Azure/karpenter-provider-azure/main/hack/deploy/configure-values.sh && chmod +x configure-values.sh && bash configure-values.sh ${module.aks.aks_name} ${local.aks_azrg_name} karpenter-sa ${module.aks_identity.name}
  EOT
  environment = {
    AZURE_SUBSCRIPTION_ID = "${data.azurerm_client_config.current_config.subscription_id}"
  }
  }
    depends_on = [ module.aks, module.aks_identity ]
}

#--------------------------------------------------------------------------------------------------------------------
# KARPENTER
#--------------------------------------------------------------------------------------------------------------------
module "karpenter" {
  source = "./modules/helm-release"

  name          = join("", [var.project, var.environment, "karpenter"])
  repository    = var.kar_repo
  chart         = var.kar_chart
  namespace     = var.kar_namespace
  #version       = var.kar_version
  values        = [file("./karpenter-values.yaml")]

  depends_on = [ module.aks, module.aks_identity ]
}