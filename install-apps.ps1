# ============================================================
#  Winget Silent Install Script
#  Generated: 2026-03-30
# ============================================================

# Require administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as Administrator."
    exit 1
}

# ── General Applications ──────────────────────────────────────────────────────
$apps = @(
    @{ Name = "7-Zip";                          Id = "7zip.7zip" },
    @{ Name = "Google Chrome";                  Id = "Google.Chrome" },
    @{ Name = "Mozilla Firefox";                Id = "Mozilla.Firefox" },
    @{ Name = "Notepad++";                      Id = "Notepad++.Notepad++" },
    @{ Name = "VoodooSoft DefenderUI";          Id = "VoodooSoft.DefenderUI" },
    @{ Name = "Daum PotPlayer";                 Id = "Daum.PotPlayer" },
    @{ Name = "Internet Download Manager";      Id = "Tonec.InternetDownloadManager" },
    @{ Name = "SumatraPDF";                     Id = "SumatraPDF.SumatraPDF" },
    @{ Name = "WireGuard";                      Id = "WireGuard.WireGuard" },
    @{ Name = "MB Windows Firewall Control";    Id = "BiniSoft.WindowsFirewallControl" }
)

# ── Lenovo Tools ──────────────────────────────────────────────────────────────
$lenovo = @(
    @{ Name = "Intel Driver & Support Assistant"; Id = "Intel.IntelDriverAndSupportAssistant" },
    @{ Name = "Lenovo Service Bridge";            Id = "Lenovo.ServiceBridge" },
    @{ Name = "Lenovo System Update";             Id = "Lenovo.SystemUpdate" },
    @{ Name = "Lenovo Legion Toolkit";            Id = "LenovoLegionToolkitTeam.LenovoLegionToolkit" }
)

# ── Visual C++ Redistributables (all versions, x86 + x64) ────────────────────
$vcredist = @(
    @{ Name = "Visual C++ 2005 x86";      Id = "Microsoft.VCRedist.2005.x86" },
    @{ Name = "Visual C++ 2005 x64";      Id = "Microsoft.VCRedist.2005.x64" },
    @{ Name = "Visual C++ 2008 x86";      Id = "Microsoft.VCRedist.2008.x86" },
    @{ Name = "Visual C++ 2008 x64";      Id = "Microsoft.VCRedist.2008.x64" },
    @{ Name = "Visual C++ 2010 x86";      Id = "Microsoft.VCRedist.2010.x86" },
    @{ Name = "Visual C++ 2010 x64";      Id = "Microsoft.VCRedist.2010.x64" },
    @{ Name = "Visual C++ 2012 x86";      Id = "Microsoft.VCRedist.2012.x86" },
    @{ Name = "Visual C++ 2012 x64";      Id = "Microsoft.VCRedist.2012.x64" },
    @{ Name = "Visual C++ 2013 x86";      Id = "Microsoft.VCRedist.2013.x86" },
    @{ Name = "Visual C++ 2013 x64";      Id = "Microsoft.VCRedist.2013.x64" },
    @{ Name = "Visual C++ 2015-2022 x86"; Id = "Microsoft.VCRedist.2015+.x86" },
    @{ Name = "Visual C++ 2015-2022 x64"; Id = "Microsoft.VCRedist.2015+.x64" }
)

# ── .NET Desktop Runtimes ─────────────────────────────────────────────────────
# .NET 6  - legacy app compatibility
# .NET 8  - LTS, supported until Nov 2026
# .NET 9  - STS, supported until May 2026
# .NET 10 - LTS, current
$dotnetDesktop = @(
    @{ Name = ".NET Desktop Runtime 6";  Id = "Microsoft.DotNet.DesktopRuntime.6" },
    @{ Name = ".NET Desktop Runtime 8";  Id = "Microsoft.DotNet.DesktopRuntime.8" },
    @{ Name = ".NET Desktop Runtime 9";  Id = "Microsoft.DotNet.DesktopRuntime.9" },
    @{ Name = ".NET Desktop Runtime 10"; Id = "Microsoft.DotNet.DesktopRuntime.10" }
)

# ── ASP.NET Core Runtimes ─────────────────────────────────────────────────────
$dotnetAspNet = @(
    @{ Name = "ASP.NET Core Runtime 6";  Id = "Microsoft.DotNet.AspNetCore.6" },
    @{ Name = "ASP.NET Core Runtime 8";  Id = "Microsoft.DotNet.AspNetCore.8" },
    @{ Name = "ASP.NET Core Runtime 9";  Id = "Microsoft.DotNet.AspNetCore.9" },
    @{ Name = "ASP.NET Core Runtime 10"; Id = "Microsoft.DotNet.AspNetCore.10" }
)

# ── DirectX ───────────────────────────────────────────────────────────────────
$directx = @(
    @{ Name = "DirectX End-User Runtime"; Id = "Microsoft.DirectX" }
)

# ── Helper Function ───────────────────────────────────────────────────────────
function Install-Apps {
    param (
        [string]$SectionTitle,
        [array]$AppList
    )
    Write-Host "`n==============================" -ForegroundColor Cyan
    Write-Host " $SectionTitle" -ForegroundColor Cyan
    Write-Host "==============================" -ForegroundColor Cyan

    foreach ($app in $AppList) {
        Write-Host "`n[-] Installing $($app.Name)..." -ForegroundColor Yellow
        winget install --id $app.Id --silent --accept-package-agreements --accept-source-agreements
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[+] $($app.Name) installed successfully." -ForegroundColor Green
        } else {
            Write-Host "[!] $($app.Name) may have failed or was already installed. (Exit code: $LASTEXITCODE)" -ForegroundColor Red
        }
    }
}

# ── Run Installations ─────────────────────────────────────────────────────────
Install-Apps -SectionTitle "General Applications"        -AppList $apps
Install-Apps -SectionTitle "Lenovo Tools"                -AppList $lenovo
Install-Apps -SectionTitle "Visual C++ Redistributables" -AppList $vcredist
Install-Apps -SectionTitle ".NET Desktop Runtimes"       -AppList $dotnetDesktop
Install-Apps -SectionTitle "ASP.NET Core Runtimes"       -AppList $dotnetAspNet
Install-Apps -SectionTitle "DirectX Runtime"             -AppList $directx

Write-Host "`n=== All installations complete! ===" -ForegroundColor Cyan
