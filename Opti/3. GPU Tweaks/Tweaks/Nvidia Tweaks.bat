@Echo Off
Title Reg Converter v1.2 & 
color 02
cd %systemroot%\system32
call :IsAdmin

REM ;Disable Preemption
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f
REM ;Disable Write Combining
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f
REM ;Disable Preemption
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f
pause

@echo off

cd C:\Program Files\NVIDIA Corporation\NVSMI

nvidia-smi.exe -acp 0

pause

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DistributeTimers" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v "EnableRID61684" /t REG_DWORD /d "1" /f
pause


:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo Debe ser ejecutado como administrador para continuar...
 Pause & Exit
)
Cls
goto:eof
