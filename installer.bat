@echo off
REM Download file using PowerShell (since CMD doesn't support direct download)
powershell -Command "Invoke-WebRequest -Uri 'https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.0.1/fabric-installer-1.0.1.exe' -OutFile 'C:\Users\%USERNAME%\Downloads\fabric-installer-1.0.1.exe'"

echo Click Install and close the app when done

REM Automatically run the downloaded file
start /wait C:\Users\%USERNAME%\Downloads\fabric-installer-1.0.1.exe

REM Check if the required directory exists
IF NOT EXIST "%USERPROFILE%\AppData\Roaming\.minecraft\mods" (
    echo Directory not found. Please create the directory or install the necessary files.
    
    REM Wait for the directory to be created
    :WAIT_LOOP
    IF NOT EXIST "%USERPROFILE%\AppData\Roaming\.minecraft\mods" (
        echo Waiting for the directory to be created...
        timeout /t 5 /nobreak
        goto WAIT_LOOP
    )
)

echo Directory found!

REM Installs the anticheat
powershell -Command "Invoke-WebRequest -Uri 'https://cdn.modrinth.com/data/ljWczies/versions/t8qBSQVb/InertiaAntiCheat-1.0.4.2.jar' -OutFile '%USERPROFILE%\AppData\Roaming\.minecraft\mods\InertiaAntiCheat-1.0.4.2.jar'"

echo Success! You may close this window :3
timeout /t -1 /nobreak
