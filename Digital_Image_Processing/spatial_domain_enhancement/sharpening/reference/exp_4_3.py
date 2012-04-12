# -*- coding:utf-8 -*-

import matplotlib.pylab as pl
import matplotlib.cm as cm
import numpy as np
import Image
from PyDIP import *

im_0 = np.asarray(Image.open('skeleton.jpg').convert('L'))/float(255)
fig = pl.figure(figsize=(10,12))

# ax_0
ax_0 = fig.add_subplot(331)
ax_0.imshow(im_0,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax_0.set_title('input image')
ax_0.set_xticks([])
ax_0.set_yticks([])

# ax_1
im_1 = d_laplacian(im_0)
ax_1 = fig.add_subplot(332)
ax_1.imshow(im_1,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax_1.set_title('my d_laplacian')
ax_1.set_xticks([])
ax_1.set_yticks([])

# ax_2
im_2 = im_0 + im_1
ax_2 = fig.add_subplot(333)
ax_2.imshow(im_2,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax_2.set_title('im_0 + im_1')
ax_2.set_xticks([])
ax_2.set_yticks([])

# ax_3
im_3 = sobel(im_0)
ax_3 = fig.add_subplot(334)
ax_3.imshow(im_3,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax_3.set_title('my sobel')
ax_3.set_xticks([])
ax_3.set_yticks([])

# ax_4
im_4 = meanfilt(im_3,[5,5])
ax_4 = fig.add_subplot(335)
ax_4.imshow(im_4,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax_4.set_title('my mean filter')
ax_4.set_xticks([])
ax_4.set_yticks([])

# ax_5
im_5 = im_3*im_4
ax_5 = fig.add_subplot(336)
ax_5.imshow(im_5,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax_5.set_title('im_3*im_4')
ax_5.set_xticks([])
ax_5.set_yticks([])

# ax_6
im_6 = im_0 + im_5
ax_6 = fig.add_subplot(337)
ax_6.imshow(im_6,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax_6.set_title('im_0 + im_5')
ax_6.set_xticks([])
ax_6.set_yticks([])

# ax_7
im_7 = imadjust(im_6,0.2)
ax_7 = fig.add_subplot(338)
ax_7.imshow(im_7,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax_7.set_title('my imadjust')
ax_7.set_xticks([])
ax_7.set_yticks([])

fig.suptitle('exp_4_3')
fig.savefig('exp_4_3.jpg')
fig.savefig('exp_4_3.eps')


