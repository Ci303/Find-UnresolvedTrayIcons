# Find-UnresolvedTrayIcons.ps1

PowerShell utility that scans Windows notification-area metadata and lists tray icon entries that point to missing executables.

## Overview

The script reads all child items under:

- `HKCU:\Control Panel\NotifyIconSettings`

For each entry it:

- Reads the stored `ExecutablePath`
- Expands environment variables
- Replaces common Windows known-folder GUID prefixes with concrete paths
- Extracts the executable path from command-line style values
- Excludes packaged app entries that reference `\WindowsApps\`
- Returns entries where the resolved path is on disk but does not exist

## Output

The script emits a formatted table with:

- `Key` – registry child name
- `ResolvedPath` – resolved executable path used for the check
- `RawPath` – original value from the registry

## Usage

```powershell
cd "C:\Users\noswi\Desktop\Scripts\Find-UnresolvedTrayIcons"
.\Find-UnresolvedTrayIcons.ps1
```

## Notes

- Read-only script. It does not modify the registry.
- Use this report as input for `Invoke-TrayIconCleanup.ps1` before removing anything.
- Designed for user-level tray settings (`HKCU`), not machine-wide tray entries.

## Requirements

- Windows PowerShell 5.1+ or PowerShell 7+
- Read access to your current user hive (`HKCU`) in the Registry

## Safety

No destructive operations are performed by this script. You can inspect the output and decide whether to clean the entries manually.
