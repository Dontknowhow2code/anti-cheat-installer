# Define download URLs and file paths
$installerUrl = "https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.0.1/fabric-installer-1.0.1.exe"
$installerPath = "$env:USERPROFILE\Downloads\fabric-installer-1.0.1.exe"
$modUrl = "https://cdn.modrinth.com/data/ljWczies/versions/t8qBSQVb/InertiaAntiCheat-1.0.4.2.jar"
$modsDir = "$env:APPDATA\.minecraft\mods"
$modPath = "$modsDir\InertiaAntiCheat-1.0.4.2.jar"

# Download Fabric installer
Write-Host "Downloading Fabric installer..."
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

Write-Host "Click Install and close the app when done."

# Run the installer
Start-Process -FilePath $installerPath -Wait

# Check if mods directory exists, wait if necessary
if (-Not (Test-Path $modsDir)) {
    Write-Host "Directory not found. Please create the directory or install the necessary files."
    do {
        Write-Host "Waiting for the directory to be created..."
        Start-Sleep -Seconds 5
    } until (Test-Path $modsDir)
}

Write-Host "Directory found!"

# Download the anti-cheat mod
Write-Host "Downloading Inertia AntiCheat mod..."
Invoke-WebRequest -Uri $modUrl -OutFile $modPath

# Check if the file was successfully downloaded
if (-Not (Test-Path $modPath)) {
    do {
        Write-Host "Download failed. Would you like to try again? (Y/N)"
        $retry = Read-Host
        if ($retry -eq "Y" -or $retry -eq "y") {
            Write-Host "Retrying download..."
            Invoke-WebRequest -Uri $modUrl -OutFile $modPath
        } else {
            Write-Host "Download aborted."
            Exit
        }
    } until (Test-Path $modPath)
}

Write-Host "Success! You may close this window :3"
Pause
