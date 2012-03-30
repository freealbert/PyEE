# -*- coding:utf-8 -*-

import matplotlib.pylab as pl
import matplotlib.cm as cm
import numpy as np
import Image
import scipy.signal as signal
import time

im_0 = np.asarray(Image.open('test3_2.jpg').convert('L'))/float(255)
fig = pl.figure(figsize=(8,4))
# ax_0
ax_0 = fig.add_subplot(121)
ax_0.imshow(im_0,cmap=cm.gray)
ax_0.set_title('input image')
ax_0.set_xticks([])
ax_0.set_yticks([])
# ax_1
ax_1 = fig.add_subplot(122)
t1 = time.clock()
im_1 = signal.medfilt2d(im_0)
t2 = time.clock()
ax_1.imshow(im_1,cmap=cm.gray)
ax_1.set_title('medfilt2d need %.3f s'%(t2-t1))
ax_1.set_xticks([])
ax_1.set_yticks([])

fig.suptitle('exp_3_5')
fig.savefig('exp_3_5.jpg')
fig.savefig('exp_3_5.eps')
