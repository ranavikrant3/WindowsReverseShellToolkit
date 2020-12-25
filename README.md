# WindowsReverseShellToolkit
### A script to spawn multiple(4) CMD reverse shells to a remote Windows system.
#### Requirements (Remote Host):
1. Windows x86/x64
2. Powershell

#### Requirements (Local Host):
1. Shell interpreter (Bash/sh etc.)
2. Netcat (nc)
3. Tmux (For binding each reverse shell to a tmux session)
4. Python2.7 (For hosting nc binaries over HTTP)

This script works by generating CMD commands to be executed on the remote Windows system. User needs to copy paste and execute the provided commands in order to spawn 4 different command prompt shells (each running inside a tmux session)
Note: Make sure you have the updated nc binaries. You can get the latest version from https://eternallybored.org/misc/netcat/
