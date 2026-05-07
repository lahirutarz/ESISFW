# 🖥️ Winget Silent Install Script

A PowerShell script that silently installs a curated set of applications, runtimes, and system tools on a fresh Windows installation using [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/) (Windows Package Manager).

---

## 📋 Requirements

- Windows 10 (version 1809 or later) or Windows 11
- winget installed (pre-installed on Windows 11; available via [App Installer](https://aka.ms/getwinget) on Windows 10)
- PowerShell running as **Administrator**

---

## 🚀 How to Run

### Option 1 — Allow scripts for your user (recommended, one-time setup)

Open PowerShell as Administrator and run:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

Then run the script:

```powershell
.\install-apps.ps1
```

### Option 2 — Bypass policy for this script only (no system changes)

```powershell
PowerShell -ExecutionPolicy Bypass -File "C:\path\to\install-apps.ps1"
```

> ⚠️ Always run as **Administrator** — the script will warn and exit if not elevated.

---

## 📦 What Gets Installed

### General Applications

| App | Winget ID |
|-----|-----------|
| 7-Zip | `7zip.7zip` |
| Google Chrome | `Google.Chrome` |
| Mozilla Firefox | `Mozilla.Firefox` |
| Notepad++ | `Notepad++.Notepad++` |
| VoodooSoft DefenderUI | `VoodooSoft.DefenderUI` |
| Daum PotPlayer | `Daum.PotPlayer` |
| Internet Download Manager | `Tonec.InternetDownloadManager` |
| SumatraPDF | `SumatraPDF.SumatraPDF` |
| WireGuard | `WireGuard.WireGuard` |
| MB Windows Firewall Control | `BiniSoft.WindowsFirewallControl` |

### Lenovo Tools

| App | Winget ID |
|-----|-----------|
| Intel Driver & Support Assistant | `Intel.IntelDriverAndSupportAssistant` |
| Lenovo Service Bridge | `Lenovo.ServiceBridge` |
| Lenovo System Update | `Lenovo.SystemUpdate` |
| Lenovo Legion Toolkit | `LenovoLegionToolkitTeam.LenovoLegionToolkit` |

### Visual C++ Redistributables

Installs all major versions (x86 and x64):

| Version |
|---------|
| Visual C++ 2005 (x86 & x64) |
| Visual C++ 2008 (x86 & x64) |
| Visual C++ 2010 (x86 & x64) |
| Visual C++ 2012 (x86 & x64) |
| Visual C++ 2013 (x86 & x64) |
| Visual C++ 2015–2022 (x86 & x64) |

### .NET Desktop Runtimes

Includes WPF and Windows Forms support:

| Version | Status |
|---------|--------|
| .NET 6 | Legacy / compatibility |
| .NET 8 | LTS — supported until Nov 2026 |
| .NET 9 | STS — supported until May 2026 |
| .NET 10 | LTS — current |

### ASP.NET Core Runtimes

| Version | Status |
|---------|--------|
| ASP.NET Core 6 | Legacy / compatibility |
| ASP.NET Core 8 | LTS — supported until Nov 2026 |
| ASP.NET Core 9 | STS — supported until May 2026 |
| ASP.NET Core 10 | LTS — current |

### DirectX

| App | Winget ID |
|-----|-----------|
| DirectX End-User Runtime | `Microsoft.DirectX` |

> **Note:** This installs the legacy DirectX redistributable (D3DX, XAudio 2.7, etc.). DirectX 12 is built into Windows and does not require a separate install.

---

## ⚙️ How It Works

- All apps are installed with `--silent`, `--accept-package-agreements`, and `--accept-source-agreements` flags — no prompts or pop-ups.
- The script installs apps in sections and prints color-coded status for each:
  - 🟡 In progress
  - 🟢 Success
  - 🔴 Failed or already installed
- If an app is already installed, winget will report a non-zero exit code — this is normal and does not indicate a problem.

---

## 📝 Notes

- **Internet Download Manager** — installs as a trial. A license key must be entered manually after installation.
- **Lenovo Legion Toolkit** — for best results, disable or uninstall Lenovo Vantage, Legion Zone, and Hotkeys before or after running the script. LLT will show a warning if conflicting software is detected.
- **Lenovo tools** — these are intended for Lenovo devices. On non-Lenovo hardware, these installs may fail or have no effect.
- **ASP.NET Core vs Desktop Runtime** — Desktop Runtime includes WPF/WinForms support (for desktop apps). ASP.NET Core Runtime is for web/server-side apps. Both are installed for maximum compatibility.

---

## ➕ Adding More Apps

To add an app, find its winget ID at [winget.run](https://winget.run) or [winstall.app](https://winstall.app), then add an entry to the appropriate array in the script:

```powershell
@{ Name = "App Name"; Id = "Publisher.AppName" }
```

---

## 🔄 Upgrading All Installed Apps

To upgrade everything winget manages (not just apps in this script), run:

```powershell
winget upgrade --all --silent --accept-package-agreements --accept-source-agreements
```
