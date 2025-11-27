# Install-Font.ps1
# Installs all TrueType Font (TTF) files in the current folder on Windows 11

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Error "This script must be run as Administrator"
    exit 1
}

# Get all TTF files in the current directory
$fontFiles = Get-ChildItem -Path $PSScriptRoot -Filter "*.ttf"

if ($fontFiles.Count -eq 0) {
    Write-Warning "No TTF font files found in the current directory"
    exit 0
}

Write-Host "Found $($fontFiles.Count) TTF font file(s) to install`n" -ForegroundColor Cyan

# Load required assemblies
Add-Type -AssemblyName System.Drawing

# Define the Fonts folder
$fontsFolder = [System.Environment]::GetFolderPath('Fonts')
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

# Notify Windows that fonts have changed
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class FontHelper {
    [DllImport("gdi32.dll")]
    public static extern int AddFontResource(string lpFilename);
    
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SendMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);
}
"@
    
$HWND_BROADCAST = [IntPtr]0xffff
$WM_FONTCHANGE = 0x001D

$successCount = 0
$failCount = 0

# Process each font file
foreach ($fontFile in $fontFiles) {
    try {
        $fontPath = $fontFile.FullName
        $fontName = $fontFile.Name
        $destinationPath = Join-Path $fontsFolder $fontName
        
        Write-Host "Installing: $fontName" -ForegroundColor Yellow
        
        # Copy the font file to the Fonts folder
        Copy-Item -Path $fontPath -Destination $destinationPath -Force
        
        # Get the font display name from the font file
        $fontCollection = New-Object System.Drawing.Text.PrivateFontCollection
        $fontCollection.AddFontFile($fontPath)
        $fontFamily = $fontCollection.Families[0]
        $fontDisplayName = "$($fontFamily.Name) (TrueType)"
        
        # Register the font in the registry
        Set-ItemProperty -Path $registryPath -Name $fontDisplayName -Value $fontName -Type String
        
        # Add font resource
        [FontHelper]::AddFontResource($destinationPath) | Out-Null
        
        Write-Host "  ✓ Installed successfully: $fontDisplayName" -ForegroundColor Green
        $successCount++
        
    } catch {
        Write-Host "  ✗ Failed to install: $fontName - $_" -ForegroundColor Red
        $failCount++
    }
}

# Broadcast font change notification
[FontHelper]::SendMessage($HWND_BROADCAST, $WM_FONTCHANGE, [IntPtr]::Zero, [IntPtr]::Zero) | Out-Null

Write-Host "`nInstallation complete!" -ForegroundColor Cyan
Write-Host "Success: $successCount font(s)" -ForegroundColor Green
if ($failCount -gt 0) {
    Write-Host "Failed: $failCount font(s)" -ForegroundColor Red
}
Write-Host "`nYou may need to restart applications to see the new fonts."
