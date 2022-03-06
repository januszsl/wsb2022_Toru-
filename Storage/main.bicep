
@description('podaj nazwe konta storage')
@minLength(3)
@maxLength(23)
param stgName string

param location string = resourceGroup().location

var StorageName = toLower(stgName)

resource storageAccount_res 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: StorageName
  location: location
  sku:{
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    publicNetworkAccess: 'Disabled'
    allowSharedKeyAccess: false
    supportsHttpsTrafficOnly: false
    routingPreference: {
      routingChoice: 'InternetRouting'
    }
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}

output storageName object = storageAccount_res.properties.primaryEndpoints
