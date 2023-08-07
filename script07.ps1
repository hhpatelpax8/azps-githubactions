#Add NIC

$resourcegroup = "testrg2"
$location = "Australia Southeast"
$networkname = "test-network"
$subnetname = "SubnetA"
$networkinterfacename = "testnic"
$networksecuritygroupname = "test-nsg"

$VirtualNetwork=Get-AzVirtualNetwork -Name $networkname -ResourceGroupName $resourcegroup

$subnet=Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VirtualNetwork -Name $subnetname

$nsg=Get-AzNetworkSecurityGroup -Name $networksecuritygroupname -ResourceGroupName $resourceGroup

New-AzNetworkInterface `
-Name $networkinterfacename `
-ResourceGroupName $resourcegroup `
-Location $location `
-SubnetId $subnet.Id `
-IpConfigurationName "ipconfig" `
-NetworkSecurityGroupId $nsg.Id
