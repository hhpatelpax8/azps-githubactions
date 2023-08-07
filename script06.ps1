#Create a new VNet with Subnet 

#variables used: 

$resourcegroup = "testrg2"
$location = "Australia Southeast"
$networkname = "test-network"
$addressprefix = "10.0.0.0/16"
$subnetname = "SubnetA"
$subnetaddressprefix = "10.0.0.0/24"

#create a subnet config and set this object as a variable to be used in VNET creation
$subnet=New-AzVirtualNetworkSubnetConfig `
-Name $subnetname `
-AddressPrefix $subnetaddressprefix

#create a new VNET
New-AzVirtualNetwork `
-Name $networkname `
-ResourceGroupName $resourcegroup `
-Location $location `
-AddressPrefix $addressprefix `
-Subnet $subnet
