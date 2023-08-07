#Create Resource Group

$resourceGroup="testrg2"
$location="Australia Southeast"

New-AzResourceGroup `
-Name $resourceGroup `
-Location $location



