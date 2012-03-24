# -*- coding:utf-8 -*-

from scipy.signal import signal
import matplotlib.pylab as pl
import matplotlib.cm as cm
import numpy as np
import Image

def mymeanfilter(im_0):
    (M,N) = im_0.shape


