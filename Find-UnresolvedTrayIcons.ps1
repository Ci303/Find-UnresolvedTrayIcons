$trayKey = 'HKCU:\Control Panel\NotifyIconSettings'

$knownFolders = @{
    '{6D809377-6AF0-444B-8957-A3773F02200E}' = $env:ProgramFiles
    '{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}' = ${env:ProgramFiles(x86)}
    '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}' = "$env:WINDIR\System32"
    '{F38BF404-1D43-42F2-9305-67DE0B28FC23}' = $env:WINDIR
    '{F1B32785-6FBA-4FCF-9D55-7B8E7F157091}' = $env:LOCALAPPDATA
    '{3EB685DB-65F9-4CF6-A03A-E3EF65729F3D}' = $env:APPDATA
}

function Resolve-TrayPath {
    param([string]$Path)

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return $null
    }

    $resolved = [Environment]::ExpandEnvironmentVariables($Path.Trim())

    foreach ($guid in $knownFolders.Keys) {
        if ($resolved.StartsWith($guid, [System.StringComparison]::OrdinalIgnoreCase)) {
            $resolved = $resolved.Replace($guid, $knownFolders[$guid])
            break
        }
    }

    if ($resolved -match '^"([^"]+\.exe)"') {
        return $matches[1]
    }

    if ($resolved -match '^(.+?\.exe)(?:\s|$)') {
        return $matches[1]
    }

    return $resolved
}

Get-ChildItem $trayKey | ForEach-Object {
    $item = Get-ItemProperty $_.PSPath
    $rawPath = $item.ExecutablePath
    $resolvedPath = Resolve-TrayPath $rawPath

    if (
        $resolvedPath `
            -and $resolvedPath -notlike '*\WindowsApps\*' `
            -and $resolvedPath -match '^[A-Za-z]:\\' `
            -and -not (Test-Path -LiteralPath $resolvedPath)
    ) {
        [pscustomobject]@{
            Key          = $_.PSChildName
            ResolvedPath = $resolvedPath
            RawPath      = $rawPath
        }
    }
} | Sort-Object ResolvedPath | Format-Table -AutoSize