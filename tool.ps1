Write-Host "PortSniper - Find and Kill Processes by Port" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

$port = Read-Host "Enter the Port number to snipe (e.g. 8080 or 3000)"

if (-not [int]::TryParse($port, [ref]$null)) {
    Write-Host "Invalid port number." -ForegroundColor Red
    Exit
}

$connections = netstat -ano | Select-String ":$port\s"
$pids = @()

if ($connections) {
    Write-Host "Active connections on Port $port :" -ForegroundColor Yellow
    foreach ($conn in $connections) {
        $line = $conn.ToString().Trim() -replace '\s+', ' '
        $parts = $line.Split(' ')
        $pid = $parts[-1]
        
        if ($pid -and $pid -ne "0" -and $pid -notin $pids) {
            $pids += $pid
            $process = Get-Process -Id $pid -ErrorAction SilentlyContinue
            if ($process) {
                Write-Host "PID: $pid | Process Name: $($process.ProcessName) | State: $($parts[3])"
            } else {
                Write-Host "PID: $pid | Process Name: [Unknown or System] | State: $($parts[3])"
            }
        }
    }
    
    if ($pids.Count -gt 0) {
        Write-Host ""
        $confirm = Read-Host "Do you want to forcefully kill these process(es)? (Y/N)"
        if ($confirm -eq 'Y') {
            foreach ($p in $pids) {
                Stop-Process -Id $p -Force -ErrorAction SilentlyContinue
                Write-Host "Killed PID $p." -ForegroundColor Green
            }
        } else {
            Write-Host "Aborted."
        }
    } else {
        Write-Host "No locatable PIDs found for this port."
    }
} else {
    Write-Host "No active processes found listening on Port $port." -ForegroundColor Green
}

Write-Host ""
Read-Host "Press Enter to exit..."
