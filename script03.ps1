$resourcegroup = "testrg2"
$networkname = "test-network"

$VirtualNetwork=Get-AzVirtualNetwork -Name $networkname -ResourceGroupName $resourcegroup

Write-Host $VirtualNetwork.Name
Write-Host $VirtualNetwork.ResourceGroupName
Write-Host $VirtualNetwork.Location
Write-Host $VirtualNetwork.AddressSpace.AddressPrefixes
Write-Host $VirtualNetwork.Subnets