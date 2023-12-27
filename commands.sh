
# SUBSCRIPTION_NAME="Visual Studio Enterprise Subscription"
# RESOURCE_GROUP="bicep-course-az-rg"

az deployment group create \
--subscription "Visual Studio Enterprise Subscription" \
--resource-group "bicep-course-az-rg" \
--name deployment \
--template-file main.bicep \
--parameters main.parameters.json
