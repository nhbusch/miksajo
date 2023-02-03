@echo off
powershell -ExecutionPolicy ByPass -NoProfile -command "& '%~dpn0.ps1' -restore -build" %*
exit /b %ErrorLevel%