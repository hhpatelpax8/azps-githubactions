#Create NSG group with rules

$resourceGroup="testrg2"
$location="Australia Southeast"
$networksecuritygroupname = "test-nsg"

$nsgrule1=New-AzNetworkSecurityRuleConfig `
-Name "Allow-RDP" `
-Access Allow `
-Protocol Tcp `
-Direction Inbound `
-Priority 1000 `
-SourceAddressPrefix Internet `
-SourcePortRange * `
-DestinationAddressPrefix 10.0.0.0/24 `
-DestinationPortRange 3389

$nsgrule2=New-AzNetworkSecurityRuleConfig `
-Name "Allow-HTTP" `
-Access Allow `
-Protocol Tcp `
-Direction Inbound `
-Priority 1100 `
-SourceAddressPrefix Internet `
-SourcePortRange * `
-DestinationAddressPrefix 10.0.0.0/24 `
-DestinationPortRange 80

New-AzNetworkSecurityGroup `
-Name $networksecuritygroupname `
-ResourceGroupName $resourceGroup `
-Location $location `
-SecurityRules $nsgrule1,$nsgrule2

