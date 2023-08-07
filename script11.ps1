#Adding a data disk
$resourceGroup="testrg2"
$vmname = "testvm01"
$diskname = "testdatadisk"

$vm1=Get-AzVm -Name $vmname -ResourceGroupName $resourceGroup

$vm1 | Add-AzVmssDataDisk -Name $diskname -DiskSizeGB 16 -CreateOption Empty -Lun 0

$vm1 | Update-AzVM

