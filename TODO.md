1. Enable host-based encryption
az feature register --namespace "Microsoft.Compute" --name "EncryptionAtHost"
az feature register --namespace "Microsoft.ContainerService" --name "EnableEncryptionAtHostPreview"
az feature list -o table --query "[?contains(name, 'Microsoft.Compute/EncryptionAtHost')].{Name:name,State:properties.state}"
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/EnableEncryptionAtHostPreview')].{Name:name,State:properties.state}"
az provider register --namespace Microsoft.Compute
az provider register --namespace Microsoft.ContainerService

2. Authenticate to AKS cluster
az aks get-credentials --name aichatbot-dev-c5c9-aks --resource-group AZRG-AICHATBOT-NONPRD-AKS --admin

allsup-aichatbot-fe
allsup-aichatbot-crm
allsup-aichatbot-core