# -*- coding:utf-8 -*-

from scipy import signal
import matplotlib.pylab as pl
import matplotlib.cm as cm
import numpy as np
import Image

def mystdfilter(im_0,im_1,size):
    [R,C] = size
    # im_0为原始图像
    # im_1 为经过均值滤波后的图像
    # 图像必须为double类型，才能进行数学操作
    im_2 = im_0.copy()
    (M,N) = im_0.shape
    R = int(R)
    C = int(C)
    for m in range(R/2,M-R/2):
        for n in range(C/2,N-C/2):
            im_2[m,n] = np.sqrt(np.mean((im_1[m,n]-im_0[m-R/2:m+R/2+1,n-C/2:n+C/2+1])**2))
    return im_2





