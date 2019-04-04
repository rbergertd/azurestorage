$fileShareName = "filesync"
$storageAccount = Get-AzStorageAccount -ResourceGroupName rb-azstorage-fs3 | `
              where StorageAccountName -like sa*
$storageSyncName = "storagesync"
$storageAccountTenantId = "d5c77776-8b4c-4ceb-81da-566aba9c59c5"
$syncGroupName = "syncgroup"
$cloudEndpointName = "cloudendpoint"
$resourcegroup ='rb-azstorage-fs3'
$location = 'deploymentlocation'

Install-Module Az
Install-Module Az.StorageSync
Import-Module Az
Import-Module Az.StorageSync
Connect-AzAccount

#Create File Share
$resourcegroup ='rb-azstorage-fs3'
$fileShareName = "filesync"
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourcegroup | `
              where StorageAccountName -like sa*
New-AzStorageShare -Context $storageAccount.Context -Name $fileShareName

#Create Sync Service
$resourcegroup =' rb-azstorage-fs3'
$storageSyncName = "storagesync"
New-AzStorageSyncService -ResourceGroupName $resourcegroup -Location $location -StorageSyncServiceName $storageSyncName

#Create Sync Group
$storageSyncName = "storagesync"
$syncGroupName = "syncgroup"
New-AzStorageSyncGroup -ResourceGroupName $resourcegroup -Name $syncGroupName -StorageSyncServiceName $storageSyncName

#Make a Cloud EndPoint
New-AzStorageSyncCloudEndpoint -ResourceGroupName $resourcegroup -StorageSyncServiceName $storageSyncName -SyncGroupName $syncGroupName -Name $cloudEndpointName -StorageAccountResourceId $storageAccount -AzureFileShareName $fileShareName -StorageAccountTenantId $storageAccountTenantId

New-AzStorageSyncCloudEndpoint -ResourceGroupName "myResourceGroup" -StorageSyncServiceName "myStorageSyncServiceName" -SyncGroupName "mySyncGroupName" -Name "myCloudEndpointName" -StorageAccountResourceId $storageAccountResourceId -AzureFileShareName "myAzureFileShareName" -StorageAccountTenantId "myStorageAccountTenantId"
    Get-AzTenant