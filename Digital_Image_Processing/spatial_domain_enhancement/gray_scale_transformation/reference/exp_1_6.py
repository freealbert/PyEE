# -*- coding:utf-8 -*- 

import matplotlib.pylab as pl
import matplotlib.cm as cm
import numpy as np
import Image

def trans_line(r):
    if (r >= 0.2) and (r <= 0.4):
        s = 0.6
    else:
        s = r
    return s

rice_0 = np.asarray(Image.open('rice.png').convert('L'))/float(255)
fig = pl.figure()
ax1 = fig.add_subplot(221)
ax1.imshow(rice_0,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax1.set_title('input image')

r = np.arange(0,1+0.0001,0.0001)
s = np.asarray([trans_line(x) for x in r])
ax3 = fig.add_subplot(2,2,(3,4))
ax3.plot(r,s)
ax3.set_xlabel('r')
ax3.set_ylabel('s')
ax3.set_title('s-r')

ax2 = fig.add_subplot(222)
(M,N) = rice_0.shape
rice_1 = rice_0.copy()
for m in range(M):
    for n in range(N):
        rice_1[m,n] = trans_line(rice_0[m,n])
ax2.imshow(rice_1,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax2.set_title('output image')

fig.suptitle('exp_1_6')
fig.savefig('exp_1_6.jpg')
fig.savefig('exp_1_6.eps')

