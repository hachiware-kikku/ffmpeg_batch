@echo off

ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of default=nw=1 testdata.mp4 > movie_info
for /f "tokens=2 delims==" %%i in ('type movie_info ^| findstr width=') do set WIDTH=%%i
for /f "tokens=2 delims==" %%i in ('type movie_info ^| findstr height=') do set HEIGTH=%%i
for /f %%i in ('set /a %WIDTH%/2') do set MOVE_X=%%i
for /f %%i in ('set /a %HEIGTH%/2') do set MOVE_Y=%%i

echo WIDTH=%WIDTH%
echo HEIGTH=%HEIGTH%
echo MOVE_X=%MOVE_X%
echo MOVE_Y=%MOVE_Y%

ffmpeg -i testdata.mp4 -vf pad=w=iw+%WIDTH%:h=ih+%HEIGTH%:x=%MOVE_X%:y=%MOVE_Y%:color=black -y testdata2.mp4