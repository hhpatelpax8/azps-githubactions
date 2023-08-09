
#Create Resource Group

$resourceGroup="testrg2"
$location="Australia Southeast"

New-AzResourceGroup `
-Name $resourceGroup `
-Location $location

#Create a new VNet with Subnet 

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


#Add NIC
$networkinterfacename = "testnic"

$VirtualNetwork=Get-AzVirtualNetwork -Name $networkname -ResourceGroupName $resourcegroup

$subnet=Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VirtualNetwork -Name $subnetname

$networkinterface=New-AzNetworkInterface `
-Name $networkinterfacename `
-ResourceGroupName $resourcegroup `
-Location $location `
-SubnetId $subnet.Id `
-IpConfigurationName "ipconfig"


#Add public IP address 
$publicipaddress ="test-publicip"

$publicipaddress=New-AzPublicIpAddress `
-Name $publicipaddress `
-ResourceGroupName $resourceGroup `
-Location $location `
-AllocationMethod Static

#Attach Public IP Address to NIC

$ipconfig=Get-AzNetworkInterfaceIpConfig -NetworkInterface $networkinterface
$networkinterface | Set-AzNetworkInterfaceIpConfig -PublicIpAddress $publicipaddress -Name $ipconfig.Name
$networkinterface | Set-AzNetworkInterface


#Create NSG group with rules
$networksecuritygroupname = "test-nsg"

$nsgrule1=New-AzNetworkSecurityRuleConfig `
-Name "Allow-RDP" `
-Access Allow `
-Protocol Tcp `
-Direction Inbound `
-Priority 4096 `
-SourceAddressPrefix Internet `
-SourcePortRange * `
-DestinationAddressPrefix 10.0.0.0/24 `
-DestinationPortRange 3389

$nsgrule2=New-AzNetworkSecurityRuleConfig `
-Name "Allow-HTTP" `
-Access Allow `
-Protocol Tcp `
-Direction Inbound `
-Priority 4095 `
-SourceAddressPrefix Internet `
-SourcePortRange * `
-DestinationAddressPrefix 10.0.0.0/24 `
-DestinationPortRange 80

$nsg=New-AzNetworkSecurityGroup `
-Name $networksecuritygroupname `
-ResourceGroupName $resourceGroup `
-Location $location `
-SecurityRules $nsgrule1,$nsgrule2

#Attach NSG to subnet
Set-AzVirtualNetworkSubnetConfig `
-Name $subnetname `
-VirtualNetwork $VirtualNetwork `
-NetworkSecurityGroup $nsg `
-AddressPrefix $subnetaddressprefix

$VirtualNetwork | Set-AzVirtualNetwork

#Create a VM
$vmname = "testvm01"
$vmsize = "Standard_DS2_v2"

[String] [ValidateNotNullOrEmpty()] $secpasswd = "Password1234567"
[SecureString] $secpasswd = ConvertTo-SecureString -String "Password1234567" -AsPlainText -Force
[PSCredential] $adminCreds = New-Object System.Management.Automation.PSCredential ("admin", $secpasswd)



$vmconfig=New-AzVMConfig -VMName $vmname -VMSize $vmsize

Set-AzVMOperatingSystem `
-VM $vmconfig `
-ComputerName $vmname `
-Credential $adminCreds `
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