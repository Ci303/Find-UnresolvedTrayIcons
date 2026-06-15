# Find-UnresolvedTrayIcons.ps1

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?logo=powershell)
![Last Commit](https://img.shields.io/github/last-commit/Ci303/Find-UnresolvedTrayIcons?label=last%20commit)
![License](https://img.shields.io/github/license/Ci303/Find-UnresolvedTrayIcons)
![Issues](https://img.shields.io/github/issues/Ci303/Find-UnresolvedTrayIcons?label=open%20issues)

## Purpose

Report unresolved Windows tray-icon executable references in the current user registry so stale notification-area entries can be identified safely.

## What it does

- Reads tray entry data under `HKCU:\Control Panel\NotifyIconSettings`.
- Resolves environment variables and common known-folder GUID prefixes.
- Extracts executable paths from command-line style registry values.
- Filters out known packaged app paths under `\\WindowsApps\\`.
- Outputs unresolved entries where the target executable path is missing.

## Requirements

- Windows PowerShell 5.1+ or PowerShell 7+.
- Access to the current user registry hive (`HKCU`).

## Usage

```powershell
cd "C:\Users\noswi\Desktop\Scripts\Find-UnresolvedTrayIcons"
.\Find-UnresolvedTrayIcons.ps1
```

## Output

A table is written to the console containing:

- `Key` – registry item name
- `ResolvedPath` – interpreted executable path
- `RawPath` – original registry value

## Example

```powershell
.\Find-UnresolvedTrayIcons.ps1
```

## Troubleshooting

- No rows returned: there are no unresolved entries matching current heuristics.
- A path looks incorrect: check `RawPath` and verify whether it is expected by the relevant application.
- Some tray entries are intentionally not detected if they do not resolve to drive-letter paths.

## Notes

This script is read-only and does not write to the registry.

## Support and contribution

- Issues and feature requests: [GitHub Issues](https://github.com/Ci303/Find-UnresolvedTrayIcons/issues)
- Security concerns: [SECURITY.md](./SECURITY.md)
- Contribution guidelines: [CONTRIBUTING.md](./CONTRIBUTING.md)
