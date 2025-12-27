# savegameprofile.ps1 — Step-by-step guide

## Purpose
Automate copying a save folder into the game folder before launch and back out after the game exits.

## Prerequisites
- Windows PowerShell
- Script file saved on where .exe located (example: C:\Red Dead Redemption 2\)
- Correct folder and executable paths
- ExecutionPolicy that allows running the script (or use the shortcut below)

## Edit the script
Open savegameprofile.ps1 and set these variables to your environment:

```powershell
# local copy you want to use
$your_save_game = "D:\Game Save\Red Dead Redemption 2\profile"

# actual game save location
$save_game = "C:\Users\<User>\AppData\Roaming\<GameFolder>\profile"

# game launcher executable
$launcherExe = "C:\Red Dead Redemption 2\Launcher.exe"

# process name to watch (no .exe)
$gameName = "Launcher"

# optional timeouts
$startTimeoutSeconds = 360
$exitCheckInterval = 5
```

Save changes.

## Create a desktop shortcut (optional)
1. Right‑click Desktop → New → Shortcut.
2. For Target enter:
    powershell.exe -ExecutionPolicy Bypass -File "D:\Projects\Programming\PowerShell\savegameprofile.ps1"
3. Give it a name and Finish.
4. Use the shortcut to run the script with ExecutionPolicy bypass.

## Run the script
- Double‑click the shortcut, or
- In PowerShell: & 'D:\Projects\Programming\PowerShell\savegameprofile.ps1'

Run as a user with permission to read/write the save folders.

## What the script does (high level)
1. Copies files from $your_save_game → $save_game (pre-copy).
2. Starts the launcher ($launcherExe).
3. Waits up to $startTimeoutSeconds for the $gameName process to appear.
4. Polls until the $gameName process exits.
5. Copies files from $save_game → $your_save_game (post-copy).

## Troubleshooting
- Game process not detected: confirm $gameName equals the process name in Task Manager (no .exe).
- Permission errors: run PowerShell as Administrator or adjust folder permissions.
- Spaces in paths: ensure paths are quoted in the script.
- Timeout: increase $startTimeoutSeconds if the launcher takes longer.
- Debugging: temporarily add Write-Host statements or remove Set-PSDebug -Trace 1 for cleaner output.

## Safety notes
- Back up saves before first run.
- Anti-cheat or cloud-sync can conflict; use with caution.

That's it — edit the variables, create/run the shortcut, and verify behavior by launching the script.