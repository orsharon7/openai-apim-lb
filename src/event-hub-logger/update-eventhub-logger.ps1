# Define variables
$subscriptionId = "ff594e9e-cd1b-477d-b50a-0b949a008f01"
$resourceGroupName = "rg-aoai-apim-slb"
$serviceName = "apim-h36qvnoqvrajg"
$loggerId = "eventhub-logger"
$apiVersion = "2022-08-01"
$endpointAddress = "orshaoaislb.servicebus.windows.net"
$eventHubName = "aoai-slb-events"

# Define the request body
$body = @{
    properties = @{
        loggerType = "azureEventHub"
        description = "adding a new logger with system assigned managed identity"
        credentials = @{
            endpointAddress = $endpointAddress
            identityClientId = "SystemAssigned"
            name = $eventHubName
        }
    }
} | ConvertTo-Json -Depth 4

# Define the URI with {} around variables
$uri = "https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.ApiManagement/service/${serviceName}/loggers/${loggerId}?api-version=${apiVersion}"

# Get the access token
$accessToken = az account get-access-token --query accessToken -o tsv

# Make the PUT request
$response = Invoke-RestMethod -Uri $uri -Method Put -Body $body -ContentType "application/json" -Headers @{
    Authorization = "Bearer $accessToken"
}

# Output the response
$response
