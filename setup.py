# -*- coding: utf-8 -*-
from setuptools import setup

setup(
    name="ffmpeg batch",
    varsion="0.0.1",
    scripts=['bin/ffmpeg_batch.py', 'bin/ffmpeg.exe'],
    package_dir={'': 'src'}
)
