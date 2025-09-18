@echo off
echo Syncing all submodules...

git submodule update --remote

echo Checking for changes...
git diff --quiet HEAD
if errorlevel 1 (
    echo Changes detected, committing...
    git add .
    git commit -m "Auto sync all submodules"
    git push origin main
    echo ✅ Synced successfully!
) else (
    echo ℹ️ No changes to sync
)

pause