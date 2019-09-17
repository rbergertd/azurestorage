#Set Resource Group Name and Storage Account Name
$rgName = "RB-databroker"
$saName = "netappcssrc"
#Login to Az account
Login-AzAccount
#Build Storage Connection String - your string will be the last line of the script output. Starting with 'Default' and ending with 'windows.net'. 
$sa = Get-AzStorageAccount -StorageAccountName $saName -ResourceGroupName $rgName
$saKey = (Get-AzStorageAccountKey -ResourceGroupName $rgName -Name $saName)[0].Value
'DefaultEndpointsProtocol=https;AccountName=' + $saName + ';AccountKey=' + $saKey + ';EndpointSuffix=core.windows.net' 