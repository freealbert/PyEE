# -*- coding : utf-8 -*- 

import matplotlib.pylab as pl
import matplotlib.cm as cm
import numpy as np
import Image

def trans_line(r):
    if r <= 5:
        s = 1400*r
    elif r <= 20:
        s = 7000 - 310*r
    elif r <= 180:
        s = 900 - 5*r
    elif r <= 225:
        s = -1440 + 8*r
    else:
        s = 3060 - 12*r
    return s 
            
mountain_0 = np.asarray(Image.open('mountain.jpg').convert('L'))
(M,N) = mountain_0.shape
fig = pl.figure(figsize=(12,9))
# ax1
ax1 = fig.add_subplot(321)
ax1.imshow(mountain_0,cmap=cm.gray)
ax1.set_title('input image')
ax1.set_xticks([])
# ax2
ax2 = fig.add_subplot(322)
hist_0,x_0 = np.histogram(mountain_0.flatten(),bins=256,range=(0,256))
ax2.bar(x_0[:-1],hist_0)
ax2.set_title('input histogram')
# ax3,4
r = np.arange(0,256)
s = [trans_line(x) for x in r]
ax34 = fig.add_subplot(3,2,(3,4))
ax34.plot(r,s)
ax34.set_title('s-r')
ax34.set_xlabel('r')
ax34.set_ylabel('s')
#ax5
mountain_1 = mountain_0.copy()
for m in range(M):
    for n in range(N):
        mountain_1[m,n] = trans_line(mountain_0[m,n])
ax3 = fig.add_subplot(325)
ax3.imshow(mountain_1,cmap=cm.gray)
ax3.set_title('output image')
ax3.set_xticks([])
#ax6
ax4 = fig.add_subplot(326)
hist_1,x_1 = np.histogram(mountain_1.flatten(),bins=256,range=(0,256))
ax4.bar(x_1[:-1],hist_1)
ax4.set_title('output histogram')

fig.suptitle('exp_2_3')
fig.savefig('exp_2_3.jpg')
