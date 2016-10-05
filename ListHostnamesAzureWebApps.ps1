#
.Synopsys
Code base to implement all hostnames (customdomains) of all web apps in every Azure suscription.
Código base para inventariar todos los hostnames o Customnames de las webapps de todas nuestras subscripciones.
		
.Description
Run in any computer with Microsoft Azure Powershell installed.
Ejecutar en una máquina con los módulos Ms-Azure cargados.
Desde una consola Powershell ejecutar .\ListHostnamesAzureWebApps.ps1.

.Example
.\ListHostnamesAzureWebApps.ps1
#>

Add-AzureAccount
Login-AzureRmAccount
$SName = Get-AzureRMSubscription #| sort SubscriptionName
$export =@()

ForEach ($lst_SName in $SName) { 
    
    [void](Select-AzureRmSubscription -SubscriptionName $lst_SName.SubscriptionName)
    $lst_SName.SubscriptionName
    $website = Get-AzureRMWebapp #|Select-Object sitename,HostNames 
    # $website | export-csv D:\Temp\AzureWebSites_15.csv -Append
    foreach ($WSite in $website) {
            for ($i=0; $i -le (($wsite.HostNames.count)-1); $i++){
                                            $azureobj = New-Object -TypeName psobject 
                                            $azureobj | Add-Member -MemberType NoteProperty -Name Sitename -value($WSite.sitename)
                                            $azureobj | Add-Member -MemberType NoteProperty -Name Hostnames -value($wsite.HostNames[$i])
                                            $export+=$azureobj}
    }
 }
 #$export | Export-csv -Path D:\Temp\AzureWebSites.csv
 $export | D:\Temp\Export-XLSX.ps1 D:\Temp\AzureWebSites.xlsx 
   