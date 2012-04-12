# -*- coding:utf-8 -*-

from scipy import signal
import matplotlib.pylab as pl
import matplotlib.cm as cm
import numpy as np
import Image

def mymeanfilter(im_0,size):
    (R,C) = size
    im_1 = im_0.copy()
    (M,N) = im_0.shape
    R = int(R)
    C = int(C)
    for m in range(R/2,M-R/2):
        for n in range(C/2,N-C/2):
            im_1[m,n] = np.mean(im_0[m-R/2:m+R/2+1,n-C/2:n+C/2+1])
    return im_1





