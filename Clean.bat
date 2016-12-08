@echo off

f:

git checkout master 

echo This will Delete all current backups and create a New one. 
echo The changes will be permanent and files from older backups will be inaccessible.

set %indi1%=N

echo Do you want to continue?
set /p indi1=(Y/N): 
IF /I NOT %indi1%==Y (
	echo Process Terminated by User
	set /p eg1=Press any key to quit 
	exit
) 
echo REMOVING HISTORY...
rmdir /S /Q f:\.git\

echo Creating New Backup System...
git init
if NOT EXIST .gitignore (echo $RECYCLE.BIN/* > .gitignore)
git add .
git commit -m "Initial Commit"

echo "Preparing For Backup"
git checkout master
rmdir /S /Q f:\usr_dir
mkdir usr_dir

echo "Backing Up Data..."
xcopy /E /Q C:\Users F:\usr_dir\

echo "Finalizing Backup"
if NOT EXIST .gitignore echo $RECYCLE.BIN/* > .gitignore

FOR /F "skip=1 tokens=1-6" %%G IN ('WMIC Path Win32_LocalTime Get Day^,Hour^,Minute^,Month^,Second^,Year /Format:table') DO (
   IF "%%~L"=="" goto s_done
      Set _yyyy=%%L
      Set _mm=00%%J
      Set _dd=00%%G
      Set _hour=00%%H
      SET _minute=00%%I
      SET _second=00%%K
)
:s_done

:: Pad digits with leading zeros
      Set _mm=%_mm:~-2%
      Set _dd=%_dd:~-2%
      Set _hour=%_hour:~-2%
      Set _minute=%_minute:~-2%
      Set _second=%_second:~-2%

Set logtimestamp=%_yyyy%-%_mm%-%_dd%_%_hour%_%_minute%_%_second%

set dtf=%logtimestamp%

git add .
git commit -m %dtf%

echo "Done"
set /p eg1=Press any key to continue	
