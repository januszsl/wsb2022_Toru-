@description('Specifies the name of the Azure Storage account.')
param storageAccountName string = 'storage${uniqueString(resourceGroup().id)}'

@description('Specifies the name of the File Share. File share names must be between 3 and 63 characters in length and use numbers, lower-case letters and dash (-) only.')
@minLength(3)
@maxLength(63)
param fileShareName string

@description('Specifies the location in which the Azure Storage resources should be deployed.')
param location string = resourceGroup().location

//@description('Specifies the prefix of the blob container names.')
//param containerPrefix string = 'WSB'
var namesarray = [
  'wsb1'
  'wsb-dane'
  'wsb-done'
]


resource sa 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-04-01' = {
  name: '${sa.name}/default/${fileShareName}'
  properties: {
    shareQuota: 5
  }
}



resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = [for name in namesarray: {
   name: '${sa.name}/default/${name}'
  //name: '${sa.name}/default/${containerPrefix}${i}'
}]

