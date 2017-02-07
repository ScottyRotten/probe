@ECHO off

ECHO "                  _          "
ECHO "                 | |         "
ECHO "  _ __  _ __ ___ | |__   __//"
ECHO " | '_ \| '__/ _ \| '_ \ / _ \"
ECHO " | |_) | | | (_) | |_) |  __/"
ECHO " | .__/|_|  \___/|_.__/ \___|"
ECHO " | |                         "
ECHO " |_|                         "
ECHO "          ver 0.1            "


ECHO [*] Setup
set /p OUTFILE=Set Output Path ex. (C:\Users\scott\):
ECHO [+] Creating Output Directory at %OUTFILE%\probe_output
rmdir /S %OUTFILE%probe_output
mkdir %OUTFILE%probe_output
ECHO [-] Grabbing System Info.
ECHO [*] SYSTEM INFO / SERVICES / NETWORKING >> %OUTFILE%probe_output\sysinfo.txt
systeminfo >> %OUTFILE%probe_output\sysinfo.txt
ECHO [-] Grabbing Drive Info.
fsutil fsinfo drives >> %OUTFILE%probe_output\sysinfo.txt
ECHO [-] Grabbing Services. 
sc query >> %OUTFILE%probe_output\sysinfo.txt
ECHO [-] Grabbing Tasklist.
Tasklist /v >> %OUTFILE%probe_output\sysinfo.txt
ECHO [-] Grabbing Network Sessions.
nbtstat -S >> %OUTFILE%probe_output\networking.txt
ECHO [-] Grabbing TCP/IP Connections / PIDS.
netstat -ano >> %OUTFILE%probe_output\networking.txt
arp -a >> %OUTFILE%probe_output\networking.txt
route print >> %OUTFILE%probe_output\networking.txt
ECHO [-] Grabbing Users and SMB Shares.
ECHO [*] USERS AND SHARES >> %OUTFILE%probe_output\samba.txt
net users >> %OUTFILE%probe_output\samba.txt
net share >> %OUTFILE%probe_output\samba.txt
net view >> %OUTFILE%probe_output\samba.txt
net view \\127.0.0.1 >> %OUTFILE%probe_output\samba.txt
ECHO [-] Grabbing Registry Information.
ECHO [*] REGISTRY >> %OUTFILE%probe_output\registry.txt
Reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run >> %OUTFILE%probe_output\registry.txt
Reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce >> %OUTFILE%probe_output\registry.txt
Reg query HKLM\Software\Microsoft\Windows NT\CurrentVersion\winlogon >> %OUTFILE%probe_output\registry.txt
Reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run >> %OUTFILE%probe_output\registry.txt
Reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run >> %OUTFILE%probe_output\registry.txt
ECHO [-] Grabbing Scheduled Tasks.
ECHO [*] SCHEDULED TASKS >> %OUTFILE%probe_output\schtasks.txt
schtasks >> %OUTFILE%
ECHO [-] Listing Files Larger than 100MB.
ECHO [*] FILESYSTEM >> %OUTFILE%probe_output\files.txt
forfiles /S /M * /C "cmd /c if @fsize geq 104857600 ECHO @file  @path" >> %OUTFILE%probe_output\files.txt
ECHO [*] Complete
pause
