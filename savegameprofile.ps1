$ErrorActionPreference = 'Stop'
Set-PSDebug -Trace 1

#create a dekstop shortcut from savegameprofile.ps1
#edit target section of savegameprofile.ps1(shortcut)   =  powershell.exe -ExecutionPolicy Bypass -File "C:\Red Dead Redemption 2\savegameprofile.ps1"
<# edit this to #> $your_save_game <# location #>       = "D:\Game Save\Red Dead Redemption 2\profile"
<# edit this to #> $save_game <# location #>            = "C:\Users\Trojan\AppData\Roaming\.1911\Red Dead Redemption 2\profile"
<# edit this to #> $launcherExe <# location #>          = "C:\Red Dead Redemption 2\Launcher.exe"
<# edit this to #> $gameName <##>                       = "Launcher"

$startTimeoutSeconds = 360   # max time to wait for game to start
$exitCheckInterval = 5     # seconds between exit checks
# ----------------------------

# Pre-copy
Get-ChildItem $your_save_game -Force | Copy-Item -Destination $save_game -Recurse -Force
Start-Sleep 3

# Start launcher
Start-Process $launcherExe

# -------- WAIT FOR GAME START (with timeout) --------
$startTime = Get-Date
while (-not (Get-Process -Name $gameName -ErrorAction SilentlyContinue)) {
    if ((Get-Date) - $startTime -gt (New-TimeSpan -Seconds $startTimeoutSeconds)) {
        throw "Timeout: $gameName did not start within $startTimeoutSeconds seconds."
    }
    Start-Sleep 1
}

# -------- WAIT FOR GAME EXIT --------
while (Get-Process -Name $gameName -ErrorAction SilentlyContinue) {
    Start-Sleep $exitCheckInterval
}

# Post-copy
Get-ChildItem $save_game -Force | Copy-Item -Destination $your_save_game -Recurse -Force

#Set-PSDebug -off