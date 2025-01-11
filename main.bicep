targetScope = 'subscription'

param resourceGroupName string
param location string
param uniquePostfix string = uniqueString(utcNow())

// Create a resource group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: resourceGroupName
  location: location
}

// Create an App Service Plan
module appServicePlan './module/app-service-plan.bicep' = {
  scope: resourceGroup
  name: 'appServicePlan'
  params: {
    appServicePlanName: 'myAppServicePlan-${uniquePostfix}'
    location: location
  }
}

// Create an App Service
module appService './module/app-service.bicep' = {
  scope: resourceGroup
  name: 'appService'
  params: {
    appServiceName: 'myAppService-${uniquePostfix}'
    location: location
    appServicePlanId: appServicePlan.outputs.appServicePlanId
  }
}

// Create a Virtual Network
module virtualNetwork './module/virtual-network.bicep' = {
  scope: resourceGroup
  name: 'virtualNetwork'
  params: {
    vnetName: 'myVnet-${uniquePostfix}'
    subnetName: 'mySubnet-${uniquePostfix}'
    location: location
  }
}
