$urlTemplate = 'SAS URL'
$urlSignature = 'SAS URL'

if (Test-Path "$env:TMP\signature.exe") {
    Remove-Item "$env:TMP\signature.exe"
}

if (Test-Path "$env:TMP\template.exe") {
    Remove-Item "$env:TMP\template.exe"
}

if (Test-Path HKCU:\Software\Ucorp) {
    [string]$regexist = Get-ItemProperty "HKCU:\Software\Ucorp" -Name 'Templates'
}
else {
    New-Item HKCU:\Software\Ucorp
}    
if (!($regexist)) {
    New-ItemProperty HKCU:\Software\Ucorp -Name 'Templates' -Value 1 -PropertyType string

    Invoke-WebRequest -Uri $urlTemplate -OutFile "$env:TMP\template.exe"
    Invoke-WebRequest -Uri $urlSignature  -OutFile "$env:TMP\signature.exe"

    Start-Sleep -Seconds 20

    if (!(Test-Path "$env:USERPROFILE\documents\UcorpOfficeTemplates")) {
        New-Item "$env:USERPROFILE\documents\UcorpOfficeTemplates" -ItemType Directory | Out-Null
    }

    if (!(Test-Path "$env:appdata\Microsoft")) {
        New-Item "$env:appdata\Microsoft" -ItemType Directory | Out-Null
    }

    if (!(Test-Path "$env:appdata\Microsoft\Signatures")) {
        New-Item "$env:appdata\Microsoft\Signatures" -ItemType Directory | Out-Null
    }

    Invoke-Expression "$env:TMP\template.exe /s" 
    Invoke-Expression "$env:TMP\signature.exe /s"

    if (!(Test-Path HKCU:\Software\Microsoft\Office)) {
        New-Item -Path HKCU:\Software\Microsoft\Office | Out-Null
    }    
    if (!(Test-Path HKCU:\Software\Microsoft\Office\16.0)) {
        New-Item -Path HKCU:\Software\Microsoft\Office\16.0 | Out-Null
    }    
    if (!(Test-Path HKCU:\Software\Microsoft\Office\16.0\PowerPoint)) {
        New-Item -Path HKCU:\Software\Microsoft\Office\16.0\PowerPoint | Out-Null
    } 
    if (!(Test-Path HKCU:\Software\Microsoft\Office\16.0\PowerPoint\Options)) {
        New-Item -Path HKCU:\Software\Microsoft\Office\16.0\PowerPoint\Options | Out-Null
    }     
    if (!(Test-Path HKCU:\Software\Microsoft\Office\16.0\Word)) {
        New-Item -Path HKCU:\Software\Microsoft\Office\16.0\Word | Out-Null
    } 
    if (!(Test-Path HKCU:\Software\Microsoft\Office\16.0\Word\Options)) {
        New-Item -Path HKCU:\Software\Microsoft\Office\16.0\Word\Options | Out-Null
    }

    [string]$Wordexist = Get-ItemProperty "HKCU:\Software\Microsoft\Office\16.0\Word\Options" -Name 'PersonalTemplates'
    [string]$PowerPointexist = Get-ItemProperty "HKCU:\Software\Microsoft\Office\16.0\PowerPoint\Options" -Name 'PersonalTemplates'

    if (!($Wordexist)) {
        New-ItemProperty 'HKCU:\Software\Microsoft\Office\16.0\Word\Options' -Name 'PersonalTemplates' -Value "$env:USERPROFILE\documents\UcorpOfficeTemplates" -PropertyType string
    }
    else {
        Set-ItemProperty 'HKCU:\Software\Microsoft\Office\16.0\Word\Options' -Name 'PersonalTemplates' -Value "$env:USERPROFILE\documents\UcorpOfficeTemplates"
    }
    if (!($PowerPointexist)) {
        New-ItemProperty 'HKCU:\Software\Microsoft\Office\16.0\PowerPoint\Options' -Name 'PersonalTemplates' -Value "$env:USERPROFILE\documents\UcorpOfficeTemplates" -PropertyType string
    }
    else {
        Set-ItemProperty 'HKCU:\Software\Microsoft\Office\16.0\PowerPoint\Options' -Name 'PersonalTemplates' -Value "$env:USERPROFILE\documents\UcorpOfficeTemplates"
    }

    if (Test-Path "$env:TMP\signature.exe") {
        Remove-Item "$env:TMP\signature.exe"
    }

    if (Test-Path "$env:TMP\template.exe") {
        Remove-Item "$env:TMP\template.exe"
    }
}