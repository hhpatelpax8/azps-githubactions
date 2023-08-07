#Request JIT on VM 

#Variables:
$subscriptionid = "b6bc174f-3ea1-481b-8d2a-614f2f2e464b"
$resourceGroup="testrg2"
$location="Australia Southeast"
$vmname = "testvm01"


$JitPolicyVm1 = (@{
    id="/subscriptions/$subscriptionid/resourceGroups/$resourcegroup/providers/Microsoft.Compute/virtualMachines/$vmname";
    ports=(@{
       number=3389;
       endTimeUtc="2023-08-03T17:00:00.3658798Z";
       allowedSourceAddressPrefix=@("203.173.196.137")})})


$JitPolicyArr=@($JitPolicyVm1)

Start-AzJitNetworkAccessPolicy `
-ResourceId "/subscriptions/$subscriptionid/resourceGroups/$resourcegroup/providers/Microsoft.Security/locations/$location/jitNetworkAccessPolicies/default" `
-VirtualMachine $JitPolicyArr