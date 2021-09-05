@echo off

@rem ###########################################################
@rem # �ϐ���`
@rem ###########################################################

@rem ##### �f�B���N�g����` #######################################
set INPUT_DIR=G:\300_stabilize_in
set OUTPUT_DIR=G:\400_stabilize_out

@rem ##### 1�p�X��͗p�̃I�v�V���� #################################
@REM # shakiness
@REM # �ǂꂾ���f�����U��Ă��邩�̐ݒ�F����l�� 5
@REM # �l���傫���قǑ傫���U��Ă���F1 ���� 10 �܂�
set SHAKINESS=10
@REM # accuracy
@REM # �ǂꂾ���U������o���邩�̐��x�F����l�� 15
@REM # �l���傫���قǐ��x�������F1 ���� 15 �܂�
set ACCURACY=15
@REM # stepsize
@REM # ���s�N�Z���P�ʂŒ��ׂ邩�F����l�� 6
@REM # �l���������قǐ��x�������F1 ���� 32 �܂�
set STEPSIZE=1
@REM # mincontrast
@REM # �ŏ��R���g���X�g��F����l�� 0.25
@REM # �傫�Ȓl�͐U������o���Ȃ��Ȃ�F0 ���� 1 �܂ł̏����_���܂ޒl
set MICONTRAST=0
@REM set MICONTRAST=1
@REM # tripod
@REM # tripod�i�O�r�j���[�h�F����l�� 0
@REM # �����������ł͂Ȃ��O�r���g�����ꍇ�̐U���␳����F1 �ŗL����
set TRIPOD_1PASS=0

@REM ##### 2�p�X�␳�p�̃I�v�V���� #################################
@REM # smoothing
@REM # �U��𒲂ׂ��ǂ݃t���[�����F����l�� 15
@REM # ���݂̃t���[���ƁA�w�肵���l�̑O��t���[�����Q�Ƃ���F0 ���� 1000 �܂ł̐����l
@REM # �傫�Ȓl�قǂȂ߂炩�ɂȂ邪�A����������i�ڍׂ͂悭�킩��Ȃ��j
set SMOOTHING=1000
@REM # optalgo
@REM # �A���S���Y���̎w��F����l�� opt
@REM # 0, opt �O���[�o���œK��
@REM # 1, gauss �J�����̓��������[�p�X�i�n�C�J�b�g�j�Ńt�B���^���ăK�E�X�������s��
@REM # 2, avg �J�����̓����𕽋ω�����
set OPTALGO=0
@REM set OPTALGO=1
@REM set OPTALGO=2
@REM # maxshift
@REM # �ő剽�s�N�Z���̃t���[����ΏۂƂ��邩�F����l�� -1�F-1 ���� 500 �܂ł̐����l
@REM # �ύX���Ȃ��Ă��ǂ�
@REM set MAXSHIFT=-1
@REM set MAXSHIFT=0
set MAXSHIFT=500
@REM # maxangle
@REM # ���W�A���P�ʂ̍ő�p�x�F����l�� -1�i�����Ȃ��j�F-1 ���� 3.14�܂�
@REM # �ύX���Ȃ��Ă��ǂ��F-1 ���� 500 �܂ł̐����l
set MAXANGLE=-1
@REM set MAXANGLE=0
@REM set MAXANGLE=3.14
@REM set MAXANGLE=500
@REM # crop
@REM # �␳�ɂ��f���̂Ȃ����E���ǂ����邩
@REM # 0, keep�i����l�j ����̏��Ŗ��ߍ��킹��
@REM # 1, black ���F�ŕ\������
@REM # invert �h��𔽓]���邩�ǂ����F����l�� 0
@REM # �ύX���Ȃ��Ă��ǂ�
set CROP=0
@REM set CROP=1
@REM # relative
@REM # �h��̎Q�ƃt���[���𑊑ΎQ�Ƃ��邩�A��ΎQ�Ƃ��邩�F����l�� 1�i���ΎQ�Ɓj
@REM # 0 �͐�ΎQ��
@REM set RELATIVE=0
set RELATIVE=1
@REM # zoom
@REM # ���p�[�Z���g�g�傷�邩�F����l�� 0
@REM # �h�ꂪ�傫���ꍇ�ɕ␳�ɂ���񂪂Ȃ��f���������A�����������邽�߂Ɋg�傷�邱�Ƃŕ␳�f����\�������Ȃ��悤�ɂł���B
@REM 0�����ŏk���A0���傫���Ɗg��B0�͊g�傹�����̂܂܂̃T�C�Y�F-100 ���� 100 �܂�
set ZOOM=-100
@REM set ZOOM=-50
@REM set ZOOM=-75
@REM set ZOOM=0
@REM set ZOOM=100
@REM # optzoom
@REM # ��� zoom ���g���ƍœK�Ȋg��͈͂ɒ�������F����l�� 1
@REM # 0 �g��Ȃ�
@REM # 1 �Œ�Y�[���B�������h��Ă���Ƙg�������邱�Ƃ�����
@REM # 2 �σY�[���B�g�������Ȃ��Ȃ�B���̉��� zoomspeed ���Q��
@REM set OPTZOOM=0
set OPTZOOM=0
@REM set OPTZOOM=2
@REM # zoomspeed
@REM # �ő剽�p�[�Z���g�A�Y�[���i�g��j���邩�F����l�� 0.25
@REM # �傫���l�قǂ��g�傳���F0 ���� 5 �܂�
set ZOOMSPEED=0
@REM # interpol
@REM # �⊮�����̃A���S���Y��
@REM # 0, no �������s��Ȃ�
@REM # 1, linear �������� linear �������s��
@REM # 2, bilinear�i����l�j �c�Ɖ��� bilinear �������s��
@REM # 3, bicubic �c�Ɖ��� cubic �����ibicubic�j���s���i�ᑬ�x�j
@REM set INTERPOL=0
@REM set INTERPOL=1
@REM set INTERPOL=2
set INTERPOL=3
@REM # tripod
@REM # tripod�i�O�r�j���[�h�F����l�� 0
@REM # vidstabdetect �� tripod ���g�����Ƃ��ɕ��p����
@REM # 1 �ɂ���� relative=0:smoothing=0 �ɂȂ�
set TRIPOD_2PASS=0

@rem ###########################################################
@rem # �����̊J�n
@rem ###########################################################
:MAIN

for /r %INPUT_DIR% %%i in (*.mp4) do  call :STABILIZE "%%i"

echo WAIT 500 sec
timeout /t 500

GOTO :MAIN


@rem ###########################################################
@rem # �X�^�r���C�Y�̊J�n
@rem ###########################################################
:STABILIZE
set INPUT_FILE=%~1
set FILE_NAME=%~nx1
echo INPUT_FILE: %INPUT_FILE%
echo FILE_NAME: %FILE_NAME%

@rem �A�i���C�Y
ffmpeg.exe -i "%INPUT_FILE%" -vf vidstabdetect=shakiness=%SHAKINESS%:accuracy=%ACCURACY%:stepsize=%STEPSIZE%:mincontrast=%MICONTRAST%:tripod=%TRIPOD_1PASS% -an -f null -
IF ERRORLEVEL 1 call :ONERROR "%INPUT_FILE%"
IF NOT EXIST "%INPUT_FILE%" GOTO :EOF

@rem �X�^�r���C�Y
ffmpeg.exe -i "%INPUT_FILE%" -vf ^
vidstabtransform=smoothing=%SMOOTHING%:optalgo=%OPTALGO%:maxshift=%MAXSHIFT%:maxangle=%MAXANGLE%:crop=%CROP%:relative=%RELATIVE%:zoom=%ZOOM%:optzoom=%OPTZOOM%:^
zoomspeed=%ZOOMSPEED%:interpol=%INTERPOL%:tripod=%TRIPOD_2PASS%,unsharp -y "%FILE_NAME%"
IF ERRORLEVEL 1 call :ONERROR
MOVE /Y "%FILE_NAME%" "%OUTPUT_DIR%"
IF EXIST "%INPUT_FILE%" DEL /F "%INPUT_FILE%"
GOTO :EOF

@rem ###########################################################
@rem # ffmpeg���s���̏���
@rem ###########################################################
:ONERROR
MOVE /Y "%~0" "%OUTPUT_DIR%"
GOTO :EOF


