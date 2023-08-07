$resourcegroup = "testrg2"
$location = "Australia Southeast"
$networkname = "test-network"
$addressprefix = "10.0.0.0/16"


$VirtualNetwork=New-AzVirtualNetwork `
-Name $networkname `
-ResourceGroupName $resourcegroup `
-Location $location `
-AddressPrefix $addressprefix


Write-Host $VirtualNetwork.Name
Write-Host $VirtualNetwork.ResourceGroupName
Write-Host $VirtualNetwork.Location
Write-Host $VirtualNetwork.AddressSpace.AddressPrefixes
Write-Host $VirtualNetwork.Subnets
