    # Get-StartApps
    # AppID is to be added after "AppsFolder\"
$ShortcutTargetPath = "shell:AppsFolder\AD2F1837.HPPrinterControl_v10z8vjag6ke6!AD2F1837.HPPrinterControl"
$ShortcutDisplayName = "HP Smart"
$PinToStart=$true
$IconFile=$null
$ShortcutArguments=$null
$WorkingDirectory=$nul


#helper function to avoid uneccessary code
function Add-Shortcut {
    param (
        [Parameter(Mandatory)]
        [String]$ShortcutTargetPath,
        [Parameter(Mandatory)]
        [String] $DestinationPath,
        [Parameter()]
        [String] $WorkingDirectory
    )

    process{
        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut($destinationPath)
        $Shortcut.TargetPath = $ShortcutTargetPath
        $Shortcut.Arguments = $ShortcutArguments
        $Shortcut.WorkingDirectory = $WorkingDirectory

        if ($IconFile){
            $Shortcut.IconLocation = $IconFile
        }
 # Create the shortcut
        $Shortcut.Save()
        #cleanup
        [Runtime.InteropServices.Marshal]::ReleaseComObject($WshShell) | Out-Null
    }
}

#check if running as system
function Test-RunningAsSystem {
    [CmdletBinding()]
    param()
    process{
        return ($(whoami -user) -match "S-1-5-18")
    }
}

function Get-DesktopDir {
    [CmdletBinding()]
    param()
    process{
        if (Test-RunningAsSystem){
            $desktopDir = Join-Path -Path $env:PUBLIC -ChildPath "Desktop"
        }else{
            $desktopDir=$([Environment]::GetFolderPath("Desktop"))
        }
        return $desktopDir
    }
}

function Get-StartDir {
    [CmdletBinding()]
    param()
    process{
        if (Test-RunningAsSystem){
            $startMenuDir= Join-Path $env:ALLUSERSPROFILE "Microsoft\Windows\Start Menu\Programs"
        }else{
            $startMenuDir="$([Environment]::GetFolderPath("StartMenu"))\Programs"
        }
        return $startMenuDir
    }
}

# Desktop Shortcut
$destinationPath= Join-Path -Path $(Get-DesktopDir) -ChildPath "$shortcutDisplayName.lnk"
Add-Shortcut -DestinationPath $destinationPath -ShortcutTargetPath $ShortcutTargetPath -WorkingDirectory $WorkingDirectory

# Start menu entry
if ($PinToStart.IsPresent -eq $true){
    $destinationPath = Join-Path -Path $(Get-StartDir) -ChildPath "$shortcutDisplayName.lnk"
    Add-Shortcut -DestinationPath $destinationPath -ShortcutTargetPath $ShortcutTargetPath -WorkingDirectory $WorkingDirectory
}
