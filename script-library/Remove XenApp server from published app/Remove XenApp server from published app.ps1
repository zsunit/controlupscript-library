﻿<#
.SYNOPSIS
   Remove selected server(s) from the list of servers on which a selected application is published.
.PARAMETER BrowserName
   Specifies the browser name of the published application. - manually entered by user
.PARAMETER ServerNames
   Specifies the names of the servers to be removed from the published application - automatically supplied by CU
#>

$ErrorActionPreference = "Stop"

If ( (Get-PSSnapin -Name Citrix.XenApp.Commands -ErrorAction SilentlyContinue) -eq $null )
{
    Try {
        Add-PsSnapin Citrix.XenApp.Commands
    } Catch {
        # capture any failure and display it in the error section, then end the script with a return
        # code of 1 so that CU sees that it was not successful.
        Write-Error "Unable to load the snapin" -ErrorAction Continue
        Write-Error $Error[1] -ErrorAction Continue
        Exit 1
    }
}

# Because this is the main function of the script it is put into a try/catch frame so that any errors will be 
# handled in a ControlUp-friendly way.

Try {
    Remove-XAApplicationServer -BrowserName $args[0] -ServerNames $args[1]
} Catch {
    # capture any failure and display it in the error section, then end the script with a return
    # code of 1 so that CU sees that it was not successful.
    Write-Error $Error[0] -ErrorAction Continue
    Exit 1
}

Write-Host "The operation completed successfully."

