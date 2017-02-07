@ECHO off
echo "                  _          "
echo "                 | |         "
echo "  _ __  _ __ ___ | |__   ___ "
echo " | '_ \| '__/ _ \| '_ \ / _ \"
echo " | |_) | | | (_) | |_) |  __/"
echo " | .__/|_|  \___/|_.__/ \___|"
echo " | |                         "
echo " |_|                         "
echo "          ver 0.1            "

echo [+] Setup
set /p DST=Set Output Directory (C:\stuff):
echo [+] Creating Output Directory at %DST%
rmdir /S %DST%
mkdir %DST%

echo **** SYSINFO/SERVICES/SESSIONS **** >> output.txt
systeminfo >> output.txt
sc query >> output.txt
Tasklist /v >> output.txt
Net Start >> output.txt
Net Session >> output.txt
nbtstat -S >> output.txt
netstat -na >> output.txt
echo **** shares and users **** >> output.txt
net users >> output.txt
net view >> output.txt
net view \\127.0.0.1 >> output.txt
echo **** REGISTRY **** >> output.txt
Reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run >> output.txt
Reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce >> output.txt
Reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnceEx >> output.txt
Reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run >> output.txt
Reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run >> output.txt
Reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnceEx >> output.txt
echo **** SCHEDULED TASKS/EVENTLOG **** >> output.txt
at >> output.txt
schtasks >> output.txt
echo **** FILESYSTEM/LARGEFILES **** >> output.txt
forfiles /S /M * /C "cmd /c if @fsize geq 1048576 echo @file  @path" >> output.txt
echo "Script Complete"
pause
