# VS Code Server AMP Template Installer (PowerShell)
# This script copies the necessary files to create a VS Code Server template in AMP

param(
    [string]$AMPTemplatesPath = ""
)

Write-Host "===============================================" -ForegroundColor Blue
Write-Host "    VS Code Server AMP Template Installer    " -ForegroundColor Blue
Write-Host "===============================================" -ForegroundColor Blue
Write-Host ""

# Files to copy
$Files = @(
    "code-server.kvp",
    "code-serverconfig.json",
    "code-serverports.json",
    "code-serverupdates.json",
    "code-servermetaconfig.json"
)

# Check if files exist
Write-Host "Checking for required files..." -ForegroundColor Yellow
$MissingFiles = @()
foreach ($file in $Files) {
    if (Test-Path $file) {
        Write-Host "✓ Found $file" -ForegroundColor Green
    } else {
        $MissingFiles += $file
        Write-Host "✗ Missing $file" -ForegroundColor Red
    }
}

if ($MissingFiles.Count -gt 0) {
    Write-Host "✗ Missing files:" -ForegroundColor Red
    foreach ($file in $MissingFiles) {
        Write-Host "  ✗ $file" -ForegroundColor Red
    }
    Write-Host "Please ensure all template files are in the current directory." -ForegroundColor Red
    exit 1
}

Write-Host ""

# Validate JSON files
Write-Host "Validating JSON files..." -ForegroundColor Yellow
$JsonFiles = @(
    "code-serverconfig.json",
    "code-serverports.json", 
    "code-serverupdates.json",
    "code-servermetaconfig.json"
)

foreach ($file in $JsonFiles) {
    try {
        $json = Get-Content $file -Raw | ConvertFrom-Json
        Write-Host "✓ $file is valid JSON" -ForegroundColor Green
    } catch {
        Write-Host "✗ $file has JSON syntax errors" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""

# Get AMP templates directory
if (-not $AMPTemplatesPath) {
    Write-Host "Please enter your AMP templates directory path:" -ForegroundColor Yellow
    Write-Host "Common locations:" -ForegroundColor Blue
    Write-Host "  Windows: C:\AMP\AMPDatastore\Templates\" -ForegroundColor Blue
    Write-Host "  Linux: /opt/cubecoders/amp/AMPDatastore/Templates/" -ForegroundColor Blue
    Write-Host "  Docker: /opt/cubecoders/amp/AMPDatastore/Templates/" -ForegroundColor Blue
    Write-Host ""
    $AMPTemplatesPath = Read-Host "Templates directory path"
}

# Validate directory
if (-not (Test-Path $AMPTemplatesPath)) {
    Write-Host "✗ Directory not found: $AMPTemplatesPath" -ForegroundColor Red
    $CreateDir = Read-Host "Would you like to create it? (y/n)"
    if ($CreateDir -eq "y" -or $CreateDir -eq "Y") {
        try {
            New-Item -ItemType Directory -Path $AMPTemplatesPath -Force | Out-Null
            Write-Host "✓ Created directory: $AMPTemplatesPath" -ForegroundColor Green
        } catch {
            Write-Host "✗ Failed to create directory. Check permissions." -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "Installation cancelled." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""

# Copy files
Write-Host "Copying template files..." -ForegroundColor Yellow
foreach ($file in $Files) {
    try {
        Copy-Item $file -Destination $AMPTemplatesPath -Force
        Write-Host "✓ Copied $file" -ForegroundColor Green
    } catch {
        Write-Host "✗ Failed to copy $file" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "===============================================" -ForegroundColor Green
Write-Host "       Installation completed successfully!   " -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Blue
Write-Host "1. Restart your AMP panel if it's running"
Write-Host "2. Create a new instance in AMP"
Write-Host "3. Select 'Visual Studio Code Server' from the template list"
Write-Host "4. Configure your settings (authentication, workspace, etc.)"
Write-Host "5. Start the instance and access via web browser"
Write-Host ""
Write-Host "Default access: http://your-server-ip:8443" -ForegroundColor Blue
Write-Host "Remember to configure authentication before exposing to the internet!" -ForegroundColor Yellow
Write-Host ""