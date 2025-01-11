param serviceName string
param serviceId string
param serviceGroupIds array
param uniquePostfix string
param location string
param subnetId string
param privateDnsZoneId string

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2024-05-01' = {
  name: '${serviceName}-pe-${uniquePostfix}'
  location: location
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: '${serviceName}-plsc-${uniquePostfix}'
        properties: {
          privateLinkServiceId: serviceId
          groupIds: serviceGroupIds
        }
      }
    ]
  }
}

resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2024-05-01' = {
  parent: privateEndpoint
  name: '${serviceName}-pdzg-${uniquePostfix}'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config'
        properties: {
          privateDnsZoneId: privateDnsZoneId
        }
      }
    ]
  }
}
