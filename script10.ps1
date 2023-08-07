#Create a VM

$resourceGroup="testrg2"
$location="Australia Southeast"
$networkinterfacename = "testnic"
$vmname = "testvm01"
$vmsize = "Standard_DS2_v2"


$credential=Get-Credential
$vmconfig=New-AzVMConfig -VMName $vmname -VMSize $vmsize

Set-AzVMOperatingSystem `
-VM $vmconfig `
-ComputerName $vmname `
-Credential $credential `
-Windows

Set-AzVMSourceImage `
-VM $vmconfig `
-PublisherName "MicrosoftWindowsServer" `
-Offer "WindowsServer" `
-Skus "2022-Datacenter" `
-Version "latest"

$networkinterface=Get-AzNetworkInterface -Name $networkinterfacename -ResourceGroupName $resourceGroup 
$vm=Add-AzVMNetworkInterface -VM $vmconfig -ID $networkinterface.Id
Set-AzVMBootDiagnostic -Disable -VM $vm

New-AzVM -ResourceGroupName $resourceGroup -Location $location -VM $vm 

