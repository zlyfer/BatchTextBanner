@echo off
setlocal EnableDelayedExpansion
title Banner
mode con cols=50 lines=10
set file1="charlist1.ini"
set file2="charlist2.ini"

:intro
color F
set /P atext=Text: 
if exist %atext% set /P atext=<%atext%
mode con cols=15 lines=7
set atext=%atext%.
call :scan

:block
ping -n 1 localhost >nul
ping -n 1 localhost >nul
ping -n 1 localhost >nul
cls
color %random:~0,1%
call :algorythm
call :display

:scan
set "cmd=findstr /R /N "^^" %file1% | find /C ":""
for /F %%a in ('!cmd!') do set ascanlines=%%a
echo (>data.bat
set bscanlines=0
:loop1
set /A bscanlines=%bscanlines%+1
echo set /P line%bscanlines%=>>data.bat
if not %ascanlines%==%bscanlines% goto loop1
echo )^<%file1%>>data.bat
call data.bat 2>nul
del data.bat 2>nul
exit /B

:algorythm
set btext=!atext:~0,1!
set atext=!atext:~1!
if %btext%==- (
ping -n 2 localhost >nul
goto algorythm
)
type %file2%|find /I "%btext%">data.dat
set /P ctext=<data.dat
del data.dat 2>nul
set ctext=%ctext:~1%
if %ctext%==00 set ctext=0
if %ctext%==01 set ctext=1
if %ctext%==02 set ctext=2
if %ctext%==03 set ctext=3
if %ctext%==04 set ctext=4
if %ctext%==05 set ctext=5
if %ctext%==06 set ctext=6
if %ctext%==07 set ctext=7
if %ctext%==08 set ctext=8
if %ctext%==09 set ctext=9
set /A ctext=(%ctext%*5)+(%ctext%*1)
set adispline=%ctext%
if %btext%==. (
mode con cols=50 lines=10
goto intro
)
exit /B

:display
set /A adispline=%adispline%+5
set /A bdispline=%adispline%-5
echo.
:loop2
set /A bdispline=%bdispline%+1
echo !line%bdispline%!
if not %adispline%==%bdispline% goto loop2
goto block