# -*- coding:utf-8 -*-

import Image
import numpy as np
import matplotlib.cm as cm
import matplotlib.pylab as plt

def trans_line(r):
    if r <= 0.5:
        s = 15.9744*r**5
    else:
        s = (r-0.5)**0.2 + 0.12
    return s
rice_0 = np.asarray(Image.open('rice.png').convert('L'))/float(255)
(M,N) = rice_0.shape
fig = plt.figure()
ax1 = fig.add_subplot(221)
ax1.imshow(rice_0,cmap=cm.gray)
ax1.set_title('input image')

rice_1 = rice_0.copy()
for m in range(M):
    for n in range(N):
        rice_1[m,n] = trans_line(rice_0[m,n])
ax2 = fig.add_subplot(222)
ax2.imshow(rice_1,cmap=cm.gray)
ax2.set_title('output image')

r = np.arange(0,1+0.001,0.001)
s = np.array([trans_line(rr) for rr in r])
ax3 = fig.add_subplot(2,2,(3,4))
ax3.plot(r,s)
ax3.set_title('s-r')
ax3.set_xlabel('r')
ax3.set_ylabel('s')
fig.suptitle('exp_1_3')
fig.savefig('exp_1_3.jpg')
fig.savefig('exp_1_3.eps')
