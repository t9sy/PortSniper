# PortSniper

**PortSniper** is the ultimate developer tool for resolving the dreaded "Port is already in use" error (commonly seen with Node.js, Python, or Docker).

Instead of memorizing `netstat` flags and manually hunting down Task Manager PIDs, PortSniper does it all for you in seconds.

## Features
- Enter any port number (e.g., 3000, 8080, 5000).
- Instantly identifies the Process ID (PID) and the name of the executable hoarding the port.
- Gives you a 1-click prompt to instantly terminate (kill) the offending process.

## Usage
1. Right-click `SnipePort.ps1`.
2. Select **Run with PowerShell**.
3. Type the occupied port number and press Enter.
4. If a process is found, type `Y` to terminate it.
