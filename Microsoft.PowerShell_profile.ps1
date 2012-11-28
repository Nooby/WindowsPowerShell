
$env:path = "%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\"

function Test-Folder ($path) {
    Test-Path $path -pathType container
}

function To_Env_Path ($path) {
    if ((-! $env:path.Contains($path)) -and (Test-Folder $path)) {
        $env:path += ";" + $path
    }
}

To_Env_Path "C:\android-sdk\platform-tools"
To_Env_Path "C:\android-sdk\tools"
To_Env_Path "C:\Go\bin"
$env:GOROOT = "C:\Go\"

$ui = (Get-Host).UI.RawUI
$ui.BackgroundColor = "black"
$ui.ForegroundColor = "green"

