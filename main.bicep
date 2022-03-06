
@description('podaj nazwe konta storage')
@minLength(3)
@maxLength(23)
param stgName string

param location string = resourceGroup().location
  name: StorageName = toLower(stgName)
  location: location
  sku: {
    name: 'Standard_LRS'
  }
}


resource storageAccount_res MIcrosoft.'Microsoft.Storage/storageAccounts@2021-08-01'
