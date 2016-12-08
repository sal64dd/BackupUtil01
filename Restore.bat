@echo off

f:

git checkout master

echo "List of all Backups with IDs:"
git log --oneline
echo ""

echo Enter "7-Digit-ID" of the Backup to restore from the above list:
set /p ID=Enter 7-Digit-ID:

git checkout %ID%

explorer f:\usr_dir\

set /p eg1=Press any key to reset Backup to Latest State:
git reset --hard head
git checkout master

set /p eg1=Press any key to continue
