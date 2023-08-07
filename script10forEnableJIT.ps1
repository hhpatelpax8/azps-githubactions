#Enable JIT on VM 

#Variables:
$subscriptionid = "b6bc174f-3ea1-481b-8d2a-614f2f2e464b"
$resourceGroup="testrg2"
$location="Australia Southeast"
$vmname = "testvm01"


$JitPolicy = (@{
    id="/subscriptions/$subscriptionid/resourceGroups/$resourceGroup/providers/Microsoft.Compute/virtualMachines/$vmname";
        ports=(@{
         number=3389;
         protocol="*";
         allowedSourceAddressPrefix=@("*");
         maxRequestAccessDuration="PT3H"})})

$JitPolicyArr=@($JitPolicy)

Set-AzJitNetworkAccessPolicy `
-Kind "Basic" `
-Location $location `
-Name "default" `
-ResourceGroupName $resourceGroup `
-VirtualMachine $JitPolicyArr 