# -*- coding: utf-8 -*-
import os
import itertools
import subprocess
import sys

###########################################################
# 変数定義
###########################################################
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(sys.argv[0])))
os.chdir(BASE_DIR)
FFMPEG = os.path.join(BASE_DIR, "../ffmpeg.exe")
TESTDATA = os.path.join(BASE_DIR, "testdata.mp4")

##### 1パス解析用のオプション #################################
# shakiness
# どれだけ映像が振れているかの設定：既定値は 5
# 値が大きいほど大きく振れている：1 から 10 まで
SHAKINESS = (1, 10)
# accuracy
# どれだけ振れを検出するかの精度：既定値は 15
# 値が大きいほど精度が高い：1 から 15 まで
ACCURACY = (1, 15)
# stepsize
# 何ピクセル単位で調べるか：既定値は 6
# 値が小さいほど精度が高い：1 から 32 まで
STEPSIZE = (1, 32)
# mincontrast
# 最小コントラスト比：既定値は 0.25
# 大きな値は振れを検出しなくなる：0 から 1 までの小数点を含む値
MICONTRAST = (0, 1)
# tripod
# tripod（三脚）モード：既定値は 0
# 持ち歩く時ではなく三脚を使った場合の振れを補正する：1 で有効化
TRIPOD_1PASS = (0, 1)
##### 2パス補正用のオプション #################################
# smoothing
# 振れを調べる先読みフレーム数：既定値は 15
# 現在のフレームと、指定した値の前後フレームを参照する：0 から 1000 までの整数値
# 大きな値ほどなめらかになるが、制限がある（詳細はよくわからない）
SMOOTHING = (0, 1000)
# optalgo
# アルゴリズムの指定：既定値は opt
# 0, opt グローバル最適化
# 1, gauss カメラの動きをローパス（ハイカット）でフィルタしてガウス処理を行う
# 2, avg カメラの動きを平均化する
OPTALGO = (0, 1, 2)
# maxshift
# 最大何ピクセルのフレームを対象とするか：既定値は -1：-1 から 500 までの整数値
# 変更しなくても良い
MAXSHIFT = (-1, 1, 500)
# maxangle
# ラジアン単位の最大角度：既定値は -1（制限なし）：-1 から 3.14まで
# 変更しなくても良い：-1 から 500 までの整数値
MAXANGLE = (-1, 3.14, 500)
# crop
# 補正により映像のない境界をどうするか
# 0, keep（既定値） 周りの情報で埋め合わせる
# 1, black 黒色で表示する
# invert 揺れを反転するかどうか：既定値は 0
# 変更しなくても良い
CROP = (0, 1)
# relative
# 揺れの参照フレームを相対参照するか、絶対参照するか：既定値は 1（相対参照）
# 0 は絶対参照
RELATIVE = (0, 1)
# zoom
# 何パーセント拡大するか：既定値は 0
# 揺れが大きい場合に補正により情報がない映像が増え、それを回避するために拡大することで補正映像を表示させないようにできる。0未満で縮小、0より大きいと拡大。0は拡大せずそのままのサイズ：-100 から 100 まで
ZOOM = (-100, 0, 100)
# optzoom
# 上の zoom を使うと最適な拡大範囲に調整する：既定値は 1
# 0 使わない
# 1 固定ズーム。激しく揺れていると枠が見えることもある
# 2 可変ズーム。枠が見えなくなる。この下の zoomspeed を参照
OPTZOOM = (0, 1, 2)
# zoomspeed
# 最大何パーセント、ズーム（拡大）するか：既定値は 0.25
# 大きい値ほどより拡大される：0 から 5 まで
ZOOMSPEED = (0, 5)
# interpol
# 補完処理のアルゴリズム
# 0, no 処理を行わない
# 1, linear 横方向の linear 処理を行う
# 2, bilinear（既定値） 縦と横の bilinear 処理を行う
# 3, bicubic 縦と横の cubic 処理（bicubic）を行う（低速度）
INTERPOL = (0, 1, 2, 3)
# tripod
# tripod（三脚）モード：既定値は 0
# vidstabdetect で tripod を使ったときに併用する
# 1 にすると relative=0:smoothing=0 になる
TRIPOD_2PASS = (0, 1)

# 全オプションの組み合わせ
PARAMETERS = itertools.product(
    SHAKINESS, ACCURACY, STEPSIZE, MICONTRAST, TRIPOD_1PASS,
    SMOOTHING, OPTALGO, MAXSHIFT, MAXANGLE, CROP, RELATIVE, ZOOM, OPTZOOM, ZOOMSPEED, INTERPOL, TRIPOD_2PASS
)

for shakiness, accuracy, stepsize, mincontrast, tripod_1pass, smoothing, optalgo, maxshift, maxangle, crop, relative, \
    zoom, optzoom, zoomspeed, interpol, tripod_2pass in PARAMETERS:
    print("shakeness={}, accuracy={}, stepsize={}, mincontrast={}, tripod_1pass={}, smoothing={}, optalgo={}, "
          "maxshift={}, maxangle={}, crop={}, relative={}, zoom={}, optzoom={}, zoomspeed={}, interpol={}, "
          "tripod_2pass={}".format(
        shakiness, accuracy, stepsize, mincontrast, tripod_1pass, smoothing, optalgo,
        maxshift, maxangle, crop, relative, zoom, optzoom, zoomspeed, interpol, tripod_2pass))

    param_1pass = "vidstabdetect=shakiness={}:accuracy={}:stepsize={}:mincontrast={}:tripod={}".format(
        shakiness, accuracy, stepsize, mincontrast, tripod_1pass)
    subprocess.run([FFMPEG, "-i", TESTDATA, "-vf", param_1pass, "-an", "-f", "null", "-"],
                   stdout=sys.stdout, stderr=sys.stderr).check_returncode()

    param_2pass = "vidstabtransform=smoothing={}:optalgo={}:maxshift={}:maxangle={}:crop={}:relative={}:zoom={}:" \
                  "optzoom={}:zoomspeed={}:interpol={}:tripod={}".format(
        smoothing, optalgo, maxshift, maxangle, crop, relative, zoom, optzoom, zoomspeed, interpol, tripod_2pass)

    outfile_name = "1pass_{}_{}_{}_{}_{}_2pass_{}_{}_{}_{}_{}_{}_{}_{}_{}_{}_{}".format(
        shakiness, accuracy, stepsize, mincontrast, tripod_1pass, smoothing, optalgo, maxshift, maxangle, crop,
        relative, zoom, optzoom, zoomspeed, interpol, tripod_2pass)

    subprocess.run([FFMPEG, "-i", TESTDATA, "-vf", param_2pass, "-y", outfile_name + ".mp4"]
                   ).check_returncode()

    subprocess.run([FFMPEG, "-i", TESTDATA, "-vf", param_2pass + ",unsharp", "-y", outfile_name + "unsharp.mp4"]
                   ).check_returncode()

