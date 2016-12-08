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
set dtf=%date:~-4%_%date:~3,2%_%date:~0,2%__%time:~0,2%_%time:~3,2%_%time:~6,2%
git add .
git commit -m %dtf%

echo "Done"
set /p eg1=Press any key to continue	
