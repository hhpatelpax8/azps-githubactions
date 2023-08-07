#Add public IP address 

$resourceGroup="testrg2"
$location="Australia Southeast"
$publicipaddress ="test-publicip"

$publicipaddress=New-AzPublicIpAddress `
-Name $publicipaddress `
-ResourceGroupName $resourceGroup `
-Location $location `
-AllocationMethod Static


