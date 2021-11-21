@echo off
if not "%1"=="" goto %1
if exist %SystemDrive%\winhlp64\winhlp32.exe goto askuninstall
if exist "%appdata%\winhlp64\winhlp32.exe" goto askuninstall
:menu
echo Install Windows Help Mod for just you or everyone?
echo If you install it just for you it will only work on your windows user account
echo Everyone will make it work for everyone that uses this computer but may require admin rights to install..
choice /C EMC /M "Press E for everyone, M for yourself or C to cancel"
if errorlevel 255 goto badchoice
if errorlevel 3 goto end
if errorlevel 2 goto myself
if errorlevel 1 goto everyone
:badchoice
echo choice.exe failed
pause
goto end
:askuninstall
choice /C UMC /M "Press U to uninstall, m for install menu or c to cancel"
if errorlevel 255 goto badchoice
if errorlevel 3 goto end
if errorlevel 2 goto menu
if errorlevel 1 goto uninstall
goto badchoice
:help
echo Usage: %0 [uninstall] [everyone] [myself]
echo Parameters:
echo [uninstall] Uninstall winhlp64 off of this computer/user account
echo [everyone]  Install winhlp64 on this computer for everyone
echo [myself]    Install winhlp64 just for the useraccount running this batch file
goto end
:uninstall
if exist "%APPDATA%\winhlp64\winhlp32.exe" reg delete HKCU\Software\Classes\.hlp /f
if exist "%APPDATA%\winhlp64\winhlp32.exe" reg delete HKCU\Software\Classes\hlpfile /f
if exist "%APPDATA%\winhlp64\winhlp32.exe" del "%APPDATA%\winhlp64\winhlp32.exe"
if exist "%SystemDrive%\winhlp64\winhlp32.exe" reg add HKCR\hlpfile\shell\open\command /t REG_SZ /d "%windir%\winhlp32.exe %%1" /f
if exist "%SystemDrive%\winhlp64\winhlp32.exe" del "%SystemDrive%\winhlp64\winhlp32.exe"
goto end
:everyone
md %SystemDrive%\winhlp64
copy winhlp32.exe %SystemDrive%\winhlp64
reg add HKCR\hlpfile\shell\open\command /t REG_SZ /d "%SystemDrive%\winhlp64\winhlp32.exe %%1" /f
goto end
:myself
md %appdata%\winhlp64
copy winhlp32.exe "%appdata%\winhlp64"
reg add hkcu\software\classes\.hlp /t REG_SZ /d "hlpfile" /f
reg add hkcu\software\classes\hlpfile\shell\open\command /t REG_SZ /d "%APPDATA%\winhlp64\winhlp32.exe %%1" /f
:end
