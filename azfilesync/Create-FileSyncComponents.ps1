$fileShareName = "filesync"
$storageAccount = Get-AzStorageAccount -ResourceGroupName rb-azstorage-fs3 | `
              where StorageAccountName -like sa*
$storageSyncName = "storagesync"

$storageAccountTenantId = "d5c77776-8b4c-4ceb-81da-566aba9c59c5"
$storageAccountResourceId = "/subscriptions/c2ded452-9420-4776-89e6-0f31e36d961b/resourceGroups/rb-azstorage-fs3/providers/Microsoft.Storage/storageAccounts/sa3m3neuvprwuzm"
$syncGroupName = "syncgroup"
$cloudEndpointName = "cloudendpoint"
$resourcegroup ='rb-azstorage-fs3'
$location = 'centralus'

Import-Module Az
Import-Module Az.StorageSync
Connect-AzAccount

#Create File Share
New-AzStorageShare -Context $storageAccount.Context -Name $fileShareName

#Create Sync Service
New-AzStorageSyncService -ResourceGroupName $resourcegroup -Location $location -StorageSyncServiceName $storageSyncName

#Create Sync Group
New-AzStorageSyncGroup -ResourceGroupName $resourcegroup -Name $syncGroupName -StorageSyncServiceName $storageSyncName

#Make a Cloud EndPoint
New-AzStorageSyncCloudEndpoint -ResourceGroupName $resourcegroup -StorageSyncServiceName $storageSyncName -SyncGroupName $syncGroupName -Name $cloudEndpointName -StorageAccountResourceId $storageAccountResourceId -AzureFileShareName $fileShareName -StorageAccountTenantId $storageAccountTenantId


#Get TenantId, StorageAccountResourceId, Remove CloudEndpoint, etc.
Get-AzTenant
Remove-AzStorageSyncCloudEndpoint -Force -ResourceGroupName "rb-azstorage-fs3" -StorageSyncServiceName "storagesync" -SyncGroupName "syncgroup" -Name "cloudendpoint"