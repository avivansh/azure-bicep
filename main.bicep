
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

@description('Name of the application insights')
param applicationInsightsName string

@description('Name of the app service plan')
param appServicePlanName string

@description('Sku of the app service plan')
@allowed(['S1', 'B1'])
param appServicePlanSku string = 'B1'

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

module applicationInsights 'modules/application-insights.bicep' = {
  name: 'deploy-${applicationInsightsName}'
  params: {
    applicationInsightsName: applicationInsightsName
    location: location
    tags: tags
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  sku: {
    name: appServicePlanSku
  }
}


output storageAccountName string = storageAccount.outputs.storageAccountName
output applicationInsightsName string = applicationInsights.outputs.applicationInsightsName
output appServicePlanName string = appServicePlan.name

