@description('Location of the resource')
param location string

@description('Tags of the resource')
param tags object = {}

@description('Name of the storage account')
@minLength(3)
@maxLength(24)
param storageAccountName string

@description('Sku type of the storage account')
@allowed(['Standard_LRS', 'Standard_GRS'])
param storageAccountSku string = 'Standard_LRS'

@description('Kind of the storage account')
@allowed(['StorageV2', 'BlobStorage'])
param storageAccountKind string = 'StorageV2'

@description('Set to true to enable sftp')
param sftpEnbaled bool = false

@description('The name of the containers to create')
param containerNames array = []


resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    isSftpEnabled: sftpEnbaled
    isHnsEnabled: sftpEnbaled ? true : false
  }
}


output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id



