param appServiceName string
param location string
param appServicePlanId string

resource appService 'Microsoft.Web/sites@2024-04-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlanId
  }
}
