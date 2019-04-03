$fileShareName = "filesyncv3"
$storageAccount = Get-AzStorageAccount -ResourceGroupName rb-azstorage-fs | `
              where StorageAccountName -like sa*
New-AzureStorageShare -Context $storageAccount.Context -Name $fileShareName