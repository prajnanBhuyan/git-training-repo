@echo off
setlocal

:: Save the current branch name
for /f "delims=" %%i in ('git symbolic-ref --short HEAD') do set CURRENT_BRANCH=%%i

:: Check if the current branch was captured successfully
if "%CURRENT_BRANCH%"=="" (
    echo Failed to get the current branch. Exiting...
    exit /b 1
)

:: Stash any uncommitted changes
git stash push -m "Temp changes before switching to main"

:: Switch to 'main' branch
git switch main

:: Append the message to 'src.txt'
echo NEW CHANGES IN MAIN IN THE MEANWHILE >> src.txt

:: Commit the changes in main (optional, if you want this to be permanent)
git add src.txt
git commit -m "NEW CHANGES IN MAIN IN THE MEANWHILE"

:: Switch back to the original branch
git switch %CURRENT_BRANCH%

:: Apply the stashed changes (if any)
git stash pop

echo Successfully switched back to branch '%CURRENT_BRANCH%' and updated 'src.txt'.
endlocal
