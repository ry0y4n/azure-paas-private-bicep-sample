param vnetName string
param subnetName string
param location string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }

  resource privateEndpointSubnet 'subnets' existing = {
    name: subnetName
  }
}

output virtualNetworkId string = virtualNetwork.id
output subnetId string = virtualNetwork::privateEndpointSubnet.id
