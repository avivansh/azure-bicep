@description('location of the resources')
param location string

@description('Name of the application insights')
param applicationInsightsName string

@description('tags of the resources')
param tags object = {}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  kind: 'web'
  tags: tags
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

output applicationInsightsName string = applicationInsights.name
