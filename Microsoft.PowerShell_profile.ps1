
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

function inetp ($ip = "8.8.8.8") { 
    if (Test-Connection -ComputerName $ip -quiet) {
        echo "Up."
    } else {
        echo "Down. Testing every 5 Seconds."
        while(1) { 
            sleep -sec 5 
            if (Test-Connection -ComputerName $ip -quiet) {
                echo "Internet is Up again."
                return
            }
        }
    }
}

function Get-WebFile
{
    param([String]$Url,[Switch]$UseProxy)

    if ($UseProxy)
    {
        $WebProxy = New-Object -Typename System.Net.WebProxy
        # Anmeldeinformation holen
        $Cred = Get-Credential
        $WebProxy.Credentials = $Cred.GetNetworkCredential()
    }  

    # WebClient-Objekt anlegen
    $WC = New-Object -TypeName System.Net.WebClient

    try
    {
        # Ist ein Proxy im Spiel?
        if ($WebProxy -ne $null)
        {
            $WC.Proxy = $WebProxy
        }
        # Datei herunterladen
        $WC.DownloadString($Url)
    }
    catch
    {
        Write-Warning "Fehler beim Download ($_)"
    }
}

