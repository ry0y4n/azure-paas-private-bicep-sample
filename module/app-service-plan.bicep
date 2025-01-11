param appServicePlanName string
param location string

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'S1'
  }
}

output appServicePlanId string = appServicePlan.id
