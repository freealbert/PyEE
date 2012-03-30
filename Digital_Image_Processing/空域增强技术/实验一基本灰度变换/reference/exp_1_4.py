# -*- coding:utf-8 -*-

import matplotlib.pyplot as plt
import matplotlib.cm as cm
import Image
import numpy as np

kids_0 = np.asarray(Image.open('kids.tif').convert('L'))/float(255)
(M,N) = kids_0.shape
r = np.arange(0,1+0.0001,0.0001)
s1 = r**0.6
s2 = r**0.4
s3 = r**0.3
fig = plt.figure(figsize=[12,12])
ax1 = fig.add_subplot(331)
ax1.imshow(kids_0,cmap=cm.gray)
ax1.set_title('input image')
ax1.set_xticks([])
ax1.set_yticks([])
ax2 = fig.add_subplot(332)
ax2.plot(r,s1)
ax2.set_xlabel('r')
ax2.set_ylabel('s')
ax2.set_title('s-r')
kids_1 = kids_0.copy()
for m in range(M):
    for n in range(N):
        kids_1[m,n] = kids_0[m,n]**0.6
ax3 = fig.add_subplot(333)
ax3.imshow(kids_1,cmap=cm.gray)
ax3.set_title('output image')
ax3.set_xticks([])
ax3.set_yticks([])

ax4 = fig.add_subplot(334)
ax4.imshow(kids_0,cmap=cm.gray)
ax4.set_title('input image')
ax4.set_xticks([])
ax4.set_yticks([])

ax5 = fig.add_subplot(335)
ax5.plot(r,s2)
ax5.set_xlabel('r')
ax5.set_ylabel('s')
ax5.set_title('s-r')
kids_2 = kids_0.copy()
for m in range(M):
    for n in range(N):
        kids_2[m,n] = kids_0[m,n]**0.4
ax6 = fig.add_subplot(336)
ax6.imshow(kids_2,cmap=cm.gray)
ax6.set_title('output image')
ax6.set_xticks([])
ax6.set_yticks([])

ax7 = fig.add_subplot(337)
ax7.imshow(kids_0,cmap=cm.gray)
ax7.set_title('input image')
ax7.set_xticks([])
ax7.set_yticks([])

ax8 = fig.add_subplot(338)
ax8.plot(r,s3)
ax8.set_xlabel('r')
ax8.set_ylabel('s')
ax8.set_title('s-r')
kids_3 = kids_0.copy()
for m in range(M):
    for n in range(N):
        kids_3[m,n] = kids_0[m,n]**0.3
ax9 = fig.add_subplot(339)
ax9.imshow(kids_3,cmap=cm.gray)
ax9.set_title('output image')
ax9.set_xticks([])
ax9.set_yticks([])

fig.suptitle('exp_1_4')
fig.savefig('exp_1_4.jpg')
fig.savefig('exp_1_4.eps')
