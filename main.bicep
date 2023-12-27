
@description('location of the resources')
param location string = resourceGroup().location

@description('tags of the resources')
param tags object = {}

@description('name of the storage account')
@minLength(3)
@maxLength(24)
param storageAccountName string

@description('name of the sftp storage account')
@minLength(3)
@maxLength(24)
param sftpStorageAccountName string

@description('Sku of the storage account')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param storageAccountSku string = 'Standard_LRS'


module storageAccount 'modules/storage-account.bicep' = {
  name: 'deploy-${storageAccountName}'
  params: {
    location: location
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
    tags: tags
  }
}


module sftpStorageAccount 'modules/storage-account.bicep' = {
  name: 'deploy-${sftpStorageAccountName}'
  params: {
    location: location
    storageAccountName: sftpStorageAccountName
    storageAccountSku: storageAccountSku
    tags: tags
    sftpEnbaled: true
  }
}


output storageAccountName string = storageAccount.outputs.storageAccountName

