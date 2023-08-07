#Create VNet

$resourcegroup = "testrg2"
$location = "Australia Southeast"
$networkname = "test-network"
$addressprefix = "10.0.0.0/16"

New-AzVirtualNetwork `
-Name $networkname `
-ResourceGroupName $resourcegroup `
-Location $location `
-AddressPrefix $addressprefix

