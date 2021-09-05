@echo off

@rem ###########################################################
@rem # �ϐ���`
@rem ###########################################################
set INPUT_DIR=G:\000_speedup_in
set OUTPUT_DIR=G:\100_speedup_out


@rem ###########################################################
@rem # �����̊J�n
@rem ###########################################################
:MAIN

@REM ���xUP�̑Ώۃt�@�C��
FOR /R %INPUT_DIR% %%i IN (*.mp4) do call :SPEEDUP "%%i"


echo WAIT 500 sec
timeout /t 500
goto :MAIN


@rem ###########################################################
@rem # ���x��3�{�ɂ���
@rem ###########################################################
:SPEEDUP
set INPUT_FILE=%~1
set FILE_NAME=%~nx1
echo INPUT_FILE: %INPUT_FILE%
echo FILE_NAME: %FILE_NAME%
ffmpeg.exe -i "%INPUT_FILE%" -vf setpts=PTS/3.0 -af atempo=3.0 -y "%FILE_NAME%"
IF      ERRORLEVEL 1 MOVE /Y "%INPUT_FILE%" "%OUTPUT_DIR%"
IF NOT  ERRORLEVEL 1 MOVE /Y "%FILE_NAME%" "%OUTPUT_DIR%"
IF EXIST "%INPUT_FILE%" DEL /F "%INPUT_FILE%"
GOTO :EOF

