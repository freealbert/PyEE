# -*- coding:utf-8 -*-

import matplotlib.pylab as pl
import matplotlib.cm as cm
import numpy as np
import Image
from mywgn import wgn
from mymeanfilter import mymeanfilter

im_0 = np.asarray(Image.open('test3_1.jpg').convert('L'))/float(255)
fig = pl.figure()
# ax_1
ax_1 = fig.add_subplot(131)
ax_1.imshow(im_0,cmap=cm.gray)
ax_1.set_title('input image')
ax_1.set_xticks([])
ax_1.set_yticks([])
# ax_2
ax_2 = fig.add_subplot(132)
im_1 = im_0 + wgn(0,np.sqrt(0.02),im_0.shape)
ax_2.imshow(im_1,cmap=cm.gray)
ax_2.set_title('with WGN')
ax_2.set_xticks([])
ax_2.set_yticks([])
# ax_3
ax_3 = fig.add_subplot(133)
im_2 = mymeanfilter(im_1,[5,5])
ax_3.imshow(im_2,cmap=cm.gray)
ax_3.set_title('after my mean filter')
ax_3.set_xticks([])
ax_3.set_yticks([])

fig.suptitle('exp_3_3')
fig.savefig('exp_3_3.jpg')
