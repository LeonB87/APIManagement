targetScope = 'subscription'

// General

@description('The location where to deploy the resources')
param location string = 'westeurope'

param dateTime string = utcNow('ddMMyyyyHHmm')

@description('The resourcegroup where to deploy API Management')
@minLength(3)
@maxLength(90)
param resourcegroupName string

// API Management

@description('The name of the API Management service instance')
@maxLength(50)
@minLength(3)
param apiManagementServiceName string

@description('The email address of the owner of the service')
@minLength(3)
param publisherEmail string

@description('The name of the owner of the service')
@minLength(3)
param publisherName string

resource resResourcegroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourcegroupName
  location: location
}

module resApiManagement '.modules/module.apimanagement.bicep' = {
  scope: resResourcegroup
  name: 'apiManagement${dateTime}'
  params: {
    apiManagementServiceName: apiManagementServiceName
    location: location
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}
