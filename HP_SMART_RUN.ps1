
$CURRENT_PATH = Get-Location

$DOWNLOAD_RUNTIME =    Join-Path -Path $CURRENT_PATH.Path -ChildPath "Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe.Appx"
$DOWNLOAD_FRAMEWORK =  Join-Path -Path $CURRENT_PATH.Path -ChildPath "Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe.Appx"
$DOWNLOAD_VCLIB =      Join-Path -Path $CURRENT_PATH.Path -ChildPath "Microsoft.VCLibs.140.00_14.0.30704.0_x64__8wekyb3d8bbwe.Appx"
# $DOWNLOAD_HPCONTROL =  "C:\Windows\Temp\HP Smart\AD2F1837.HPPrinterControl_35.0.97.0_neutral__v10z8vjag6ke6.Appx"
$DOWNLOAD_HPSMART =    Join-Path -Path $CURRENT_PATH.Path -ChildPath "AD2F1837.HPPrinterControl_121.2.195.0_neutral___v10z8vjag6ke6.AppxBundle"




Function installFiles(){
    
    if (!(Test-Path -Path "C:\Program Files\WindowsApps\microsoft.net.native.framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe")){   
        add-appxpackage -path "$DOWNLOAD_FRAMEWORK" -ErrorAction Ignore}
    
    if (!(Test-Path -Path "C:\Program Files\WindowsApps\microsoft.net.native.runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe")){
        add-appxpackage -path "$DOWNLOAD_RUNTIME" -ErrorAction Ignore}

    if (!(Test-Path -Path "C:\Program Files\WindowsApps\Microsoft.VCLibs.140.00_14.0.30704.0_x64__8wekyb3d8bbwe")){
        add-appxpackage -path "$DOWNLOAD_VCLIB" -ErrorAction Ignore}

    if (!(Test-Path -Path "C:\Program Files\WindowsApps\AD2F1837.HPPrinterControl_121.2.195.0_neutral_~_v10z8vjag6ke6")){
        # add-appxpackage -path "$DOWNLOAD_HPCONTROL" -ErrorAction Ignore
        add-appxpackage -path "$DOWNLOAD_HPSMART"}

}

installFiles
