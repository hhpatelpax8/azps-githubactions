#Add Subnet to existing VNet

$resourcegroup = "testrg2"
$networkname = "test-network"
$subnetname = "SubnetA"
$subnetaddressprefix = "10.0.0.0/24"

$VirtualNetwork=Get-AzVirtualNetwork -Name $networkname -ResourceGroupName $resourcegroup

Add-AzVirtualNetworkSubnetConfig `
-Name $subnetname `
-VirtualNetwork $VirtualNetwork `
-AddressPrefix $subnetaddressprefix

$VirtualNetwork | Set-AzVirtualNetwork
