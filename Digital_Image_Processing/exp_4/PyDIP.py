# -*- coding:utf-8 -*-

import matplotlib.pylab as pl
import matplotlib.cm as cm
import numpy as np
import Image
 

def histeq(image_0):
    # 原图像是uint8
    (M,N) = image_0.shape
    # 统计原图每级灰度出现的概率
    hist_0 ,x_0 = np.histogram(image_0.flatten(),bins=256,range=(0,256))
    prob_0 = hist_0/float(M*N)
    # 计算累计灰度概率s_k
    # s_1的索引号为原始的灰度值，值为应该变换成的灰度级。
    # s_1的索引号和值构成了灰度变化曲线
    # s_2将s_1整数化
    s_1 = np.asarray([0.0]*256)
    log_file.write('s_1\\')
    for i in range(256):
        for j in range(i+1):
            s_1[i] += prob_0[j] 
    s_2 = np.round(s_1*255)       
    image_1 = image_0.copy()
    flat_image_1 = image_1.flatten()
    flat_image_0 = image_0.flatten()
    for n in range(256):
        flat_image_1[np.argwhere(flat_image_0==n)] = s_2[n]
    image_1 = flat_image_1.reshape(M,N)
    hist_1,x_1 = np.histogram(image_1.flatten(),bins=256,range=(0,256))
    return(image_1,hist_1,hist_0,x_1,x_0)
    
def meanfilt(im_0,size):
    (R,C) = size
    im_1 = im_0.copy()
    (M,N) = im_0.shape
    R = int(R)
    C = int(C)
    for m in range(R/2,M-R/2):
        for n in range(C/2,N-C/2):
            im_1[m,n] = np.mean(im_0[m-R/2:m+R/2+1,n-C/2:n+C/2+1])
    return im_1
    
def stdfilt(im_0,im_1,size):
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

def wgn(mu,sigma,size):
    return np.random.normal(mu,sigma,size)

def h_sobel(im_0):
    sob = np.array([[-1,-2,-1],[0,0,0],[1,2,1]])
    (M,N) = im_0.shape
    im_1 = im_0.copy()
    for m in range(1,M-1):
        for n in range(1,N-1):
            im_1[m,n] = np.abs(-im_0[m-1,n-1]-2*im_0[m-1,n]-im_0[m-1,n+1]+im_0[m+1,n-1]+2*im_0[m+1,n]+im_0[m+1,n+1])
    return im_1

def v_sobel(im_0):
    sob = np.array([[-1,0,1],[-2,0,2],[-1,0,1]])
    (M,N) = im_0.shape
    im_1 = im_0.copy()
    for m in range(1,M-1):
        for n in range(1,N-1):
            im_1[m,n] = np.abs(-im_0[m-1,n-1]+im_0[m-1,n+1]-2*im_0[m,n-1]+2*im_0[m,n+1]-im_0[m+1,n-1]+im_0[m+1,n+1])
    return im_1

def sobel(im_0):
    sob = np.array([[-1,0,1],[-2,0,2],[-1,0,1]])
    (M,N) = im_0.shape
    im_1 = im_0.copy()
    for m in range(1,M-1):
        for n in range(1,N-1):
            im_1[m,n] = np.abs(-im_0[m-1,n-1]+im_0[m-1,n+1]-2*im_0[m,n-1]+2*im_0[m,n+1]-im_0[m+1,n-1]+im_0[m+1,n+1])
    return im_1


def laplacian(im_0):
    lap = np.array([[0,-1,0],[-1,4,-1],[0,-1,0]])
    (M,N) = im_0.shape
    im_1 = im_0.copy()
    for m in range(1,M-1):
        for n in range(1,N-1):
            im_1[m,n] = np.abs(im_0[m-1,n-1]*lap[0,0]+im_0[m-1,n]*lap[0,1]+im_0[m-1,n+1]*lap[0,2]+im_0[m,n-1]*lap[1,0]+im_0[m,n]*lap[1,1]+im_0[m,n+1]*lap[1,2]+im_0[m+1,n-1]*lap[2,0]+im_0[m+1,n]*lap[2,1]+im_0[m+1,n+1]*lap[2,2])
    return im_1

def v_laplacian(im_0):
    lap = np.array([[-1,-1,-1],[-1,8,-1],[-1,-1,-1]])
    (M,N) = im_0.shape
    im_1 = im_0.copy()
    for m in range(1,M-1):
        for n in range(1,N-1):
            im_1[m,n] = np.abs(im_0[m-1,n-1]*lap[0,0]+im_0[m-1,n]*lap[0,1]+im_0[m-1,n+1]*lap[0,2]+im_0[m,n-1]*lap[1,0]+im_0[m,n]*lap[1,1]+im_0[m,n+1]*lap[1,2]+im_0[m+1,n-1]*lap[2,0]+im_0[m+1,n]*lap[2,1]+im_0[m+1,n+1]*lap[2,2])
    return im_1

def d_laplacian(im_0):
    lap = np.array([[-1,-1,-1],[-1,8,-1],[-1,-1,-1]])
    (M,N) = im_0.shape
    im_1 = im_0.copy()
    for m in range(1,M-1):
        for n in range(1,N-1):
            im_1[m,n] = np.abs(im_0[m-1,n-1]*lap[0,0]+im_0[m-1,n]*lap[0,1]+im_0[m-1,n+1]*lap[0,2]+im_0[m,n-1]*lap[1,0]+im_0[m,n]*lap[1,1]+im_0[m,n+1]*lap[1,2]+im_0[m+1,n-1]*lap[2,0]+im_0[m+1,n]*lap[2,1]+im_0[m+1,n+1]*lap[2,2])
    return im_1

def Roberts(im_0,T,L_G=255,L_B=0):
    (M,N) = im_0.shape
    im_1 = im_0.copy()
    for m in range(M-1):
        for n in range(N-1):
            g = np.abs(im_0[m,n]-im_0[m+1,n+1]) + np.abs(im_0[m+1,n]-im_0[m,n+1])
            if g >= T:
                im_1[m,n] = L_G
            else:
                im_1[m,n] = L_B
    return im_1

def imadjust(im_0,power):
    im_1 = im_0**power
    return im_1
