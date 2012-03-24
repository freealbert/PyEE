# -*- coding:utf-8 -*-

import matplotlib.pylab as pl
import matplotlib.cm as cm
import Image
import numpy as np
def trans_line(r):
    if r < 25:
        s = 4*r
    elif r < 50:
        s = 2*(r-25)+100
    else:
        s = float(105)/205*(r-50) + 150
    return s
Picture_0 = np.asarray(Image.open('Picture.jpg').convert('L'))/float(255)
fig = pl.figure(figsize=(12,9))
ax1 = fig.add_subplot(321)
ax1.imshow(Picture_0,cmap=cm.gray)
ax1.set_title('input image')
ax2 = fig.add_subplot(322)
hist_0,x_0 = np.histogram(Picture_0.flatten()*255,bins=256,range=(0,256))
ax2.bar(x_0[:-1],hist_0)
ax2.set_title('origin histogram')
r = np.arange(0,256,1)
s = np.asarray([trans_line(x) for x in r]) 
ax3 = fig.add_subplot(3,2,(3,4))
ax3.plot(r,s)
ax3.set_title('s-r')
ax3.set_xlabel('r')
ax3.set_ylabel('s')
Picturen_1 = Picture_0.copy()
(M,N) = Picture_0.shape
for m in range(M):
    for n in range(N):
        Picturen_1[m,n] = trans_line(Picture_0[m,n])
ax4 = fig.add_subplot(3,2,5)
ax4.imshow(Picturen_1,cmap=cm.gray)
ax4.set_title('output image')
hist_1,x_1 = np.histogram(Picturen_1.flatten()*255,bins=256,range=(0,256))
ax5 = fig.add_subplot(3,2,6)
ax5.bar(x_1[:-1],hist_1)
ax5.set_title('changed histogram')
fig.suptitle('exp_1_7')
fig.savefig('exp_1_7.jpg')

