# Find-UnresolvedTrayIcons.ps1

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?logo=powershell)
![Last Commit](https://img.shields.io/github/last-commit/Ci303/Find-UnresolvedTrayIcons?label=last%20commit)
![License](https://img.shields.io/github/license/Ci303/Find-UnresolvedTrayIcons)
![Issues](https://img.shields.io/github/issues/Ci303/Find-UnresolvedTrayIcons?label=open%20issues)

## Purpose

`Find-UnresolvedTrayIcons.ps1` scans user tray icon metadata and reports unresolved executable paths so you can identify stale notification-area entries without changing the registry.

## How it works

- Reads child entries under `HKCU:\Control Panel\NotifyIconSettings`
- Expands environment variables
- Resolves common Windows known-folder GUID prefixes
- Extracts executable paths from command-line style values
- Ignores entries under `\WindowsApps\`
- Lists entries where the resolved path has a drive-letter path but does not exist

## Output

The script outputs a table with:

- `Key` — registry child name
- `ResolvedPath` — resolved candidate executable path
- `RawPath` — original `ExecutablePath` value

## Requirements

- Windows PowerShell 5.1+ or PowerShell 7+
- Registry read access to `HKCU`

## Usage

```powershell
cd "C:\Users\noswi\Desktop\Scripts\Find-UnresolvedTrayIcons"
.\Find-UnresolvedTrayIcons.ps1
```

## Example

```powershell
# Quickly inspect unresolved tray references
.\Find-UnresolvedTrayIcons.ps1
```

## Troubleshooting

- **No output:** either there are no unresolved entries or values are not in the expected format.
- **Unexpected paths:** command-line values with non-standard quoting are normalised heuristically; check `RawPath` before acting.
- **False negatives:** some entries may remain unlisted if they point to non-drive paths or are inaccessible.

## Safety

This script is read-only and does not modify the registry.
