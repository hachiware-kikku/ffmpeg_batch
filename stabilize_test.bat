@echo off

@rem ###########################################################
@rem # 変数定義
@rem ###########################################################

@rem ##### 1パス解析用のオプション #################################
@REM # shakiness
@REM # どれだけ映像が振れているかの設定：既定値は 5
@REM # 値が大きいほど大きく振れている：1 から 10 まで
set SHAKINESS=10
@REM # accuracy
@REM # どれだけ振れを検出するかの精度：既定値は 15
@REM # 値が大きいほど精度が高い：1 から 15 まで
set ACCURACY=15
@REM # stepsize
@REM # 何ピクセル単位で調べるか：既定値は 6
@REM # 値が小さいほど精度が高い：1 から 32 まで
set STEPSIZE=1
@REM # mincontrast
@REM # 最小コントラスト比：既定値は 0.25
@REM # 大きな値は振れを検出しなくなる：0 から 1 までの小数点を含む値
set MICONTRAST=0
@REM set MICONTRAST=1
@REM # tripod
@REM # tripod（三脚）モード：既定値は 0
@REM # 持ち歩く時ではなく三脚を使った場合の振れを補正する：1 で有効化
set TRIPOD_1PASS=0

@REM ##### 2パス補正用のオプション #################################
@REM # smoothing
@REM # 振れを調べる先読みフレーム数：既定値は 15
@REM # 現在のフレームと、指定した値の前後フレームを参照する：0 から 1000 までの整数値
@REM # 大きな値ほどなめらかになるが、制限がある（詳細はよくわからない）
set SMOOTHING=1000
@REM # optalgo
@REM # アルゴリズムの指定：既定値は opt
@REM # 0, opt グローバル最適化
@REM # 1, gauss カメラの動きをローパス（ハイカット）でフィルタしてガウス処理を行う
@REM # 2, avg カメラの動きを平均化する
set OPTALGO=0
@REM set OPTALGO=1
@REM set OPTALGO=2
@REM # maxshift
@REM # 最大何ピクセルのフレームを対象とするか：既定値は -1：-1 から 500 までの整数値
@REM # 変更しなくても良い
@REM set MAXSHIFT=-1
@REM set MAXSHIFT=0
set MAXSHIFT=500
@REM # maxangle
@REM # ラジアン単位の最大角度：既定値は -1（制限なし）：-1 から 3.14まで
@REM # 変更しなくても良い：-1 から 500 までの整数値
set MAXANGLE=-1
@REM set MAXANGLE=0
@REM set MAXANGLE=3.14
@REM set MAXANGLE=500
@REM # crop
@REM # 補正により映像のない境界をどうするか
@REM # 0, keep（既定値） 周りの情報で埋め合わせる
@REM # 1, black 黒色で表示する
@REM # invert 揺れを反転するかどうか：既定値は 0
@REM # 変更しなくても良い
@REM set CROP=0
set CROP=1
@REM # relative
@REM # 揺れの参照フレームを相対参照するか、絶対参照するか：既定値は 1（相対参照）
@REM # 0 は絶対参照
@REM set RELATIVE=0
set RELATIVE=1
@REM # zoom
@REM # 何パーセント拡大するか：既定値は 0
@REM # 揺れが大きい場合に補正により情報がない映像が増え、それを回避するために拡大することで補正映像を表示させないようにできる。
@REM 0未満で縮小、0より大きいと拡大。0は拡大せずそのままのサイズ：-100 から 100 まで
set ZOOM=0
@REM set ZOOM=0
@REM set ZOOM=100
@REM # optzoom
@REM # 上の zoom を使うと最適な拡大範囲に調整する：既定値は 1
@REM # 0 使わない
@REM # 1 固定ズーム。激しく揺れていると枠が見えることもある
@REM # 2 可変ズーム。枠が見えなくなる。この下の zoomspeed を参照
@REM set OPTZOOM=0
set OPTZOOM=0
@REM set OPTZOOM=2
@REM # zoomspeed
@REM # 最大何パーセント、ズーム（拡大）するか：既定値は 0.25
@REM # 大きい値ほどより拡大される：0 から 5 まで
set ZOOMSPEED=0
@REM # interpol
@REM # 補完処理のアルゴリズム
@REM # 0, no 処理を行わない
@REM # 1, linear 横方向の linear 処理を行う
@REM # 2, bilinear（既定値） 縦と横の bilinear 処理を行う
@REM # 3, bicubic 縦と横の cubic 処理（bicubic）を行う（低速度）
@REM set INTERPOL=0
@REM set INTERPOL=1
@REM set INTERPOL=2
set INTERPOL=3
@REM # tripod
@REM # tripod（三脚）モード：既定値は 0
@REM # vidstabdetect で tripod を使ったときに併用する
@REM # 1 にすると relative=0:smoothing=0 になる
set TRIPOD_2PASS=0

ffmpeg.exe -i testdata.mp4 -vf vidstabdetect=shakiness=%SHAKINESS%:accuracy=%ACCURACY%:stepsize=%STEPSIZE%:mincontrast=%MICONTRAST%:tripod=%TRIPOD_1PASS% -an -f null -

ffmpeg.exe -i testdata.mp4 -vf ^
vidstabtransform=smoothing=%SMOOTHING%:optalgo=%OPTALGO%:maxshift=%MAXSHIFT%:maxangle=%MAXANGLE%:crop=%CROP%:relative=%RELATIVE%:zoom=%ZOOM%:optzoom=%OPTZOOM%:^
zoomspeed=%ZOOMSPEED%:interpol=%INTERPOL%:tripod=%TRIPOD_2PASS% ^
-y 1pass_%SHAKINESS%_%ACCURACY%_%STEPSIZE%_%MICONTRAST%_%TRIPOD_1PASS%_2pass_%SMOOTHING%_%OPTALGO%_%MAXSHIFT%_%MAXANGLE%_%CROP%_%RELATIVE%_%ZOOM%_%OPTZOOM%_%INTERPOL%_%TRIPOD_2PASS%.mp4

ffmpeg.exe -i testdata.mp4 -vf ^
vidstabtransform=smoothing=%SMOOTHING%:optalgo=%OPTALGO%:maxshift=%MAXSHIFT%:maxangle=%MAXANGLE%:crop=%CROP%:relative=%RELATIVE%:zoom=%ZOOM%:optzoom=%OPTZOOM%:^
zoomspeed=%ZOOMSPEED%:interpol=%INTERPOL%:tripod=%TRIPOD_2PASS%,unsharp ^
-y 1pass_%SHAKINESS%_%ACCURACY%_%STEPSIZE%_%MICONTRAST%_%TRIPOD_1PASS%_2pass_%SMOOTHING%_%OPTALGO%_%MAXSHIFT%_%MAXANGLE%_%CROP%_%RELATIVE%_%ZOOM%_%OPTZOOM%_%INTERPOL%_%TRIPOD_2PASS%_unsharp.mp4
