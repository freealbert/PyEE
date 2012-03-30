# -*- coding:utf-8 -*-

import matplotlib.pylab as pl
import matplotlib.cm as cm
import numpy as np
import Image
from PyDIP import *

im_0 = np.asarray(Image.open('cell.jpg').convert('L'))
fig = pl.figure(figsize=(8,4))

# ax_0
ax_0 = fig.add_subplot(121)
ax_0.imshow(im_0,cmap=cm.gray)
ax_0.set_title('input image')
ax_0.set_xticks([])
ax_0.set_yticks([])

# ax_1
im_1 = Roberts(im_0,10)
ax_1 = fig.add_subplot(122)
ax_1.imshow(im_1,cmap=cm.gray)
ax_1.set_title('Roberts')
ax_1.set_xticks([])
ax_1.set_yticks([])

fig.suptitle('exp_4_4')
fig.savefig('exp_4_4.jpg')
fig.savefig('exp_4_4.eps')
