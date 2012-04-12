# -*- coding : utf-8 -*-

import matplotlib.pylab as pl
import matplotlib.cm as cm
import numpy as np
import Image
from PyDIP import *

im_0 = np.asarray(Image.open('cameraman.tif').convert('L'))/float(255)
fig = pl.figure()

# ax_0 
ax_0 = fig.add_subplot(221)
ax_0.imshow(im_0,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax_0.set_title('input image')
ax_0.set_xticks([])
ax_0.set_yticks([])

# ax_1 
im_1 = v_sobel(im_0)
ax_1 = fig.add_subplot(222)
ax_1.imshow(im_1,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax_1.set_title('my v_sobel')
ax_1.set_xticks([])
ax_1.set_yticks([])

# ax_2
ax_2 = fig.add_subplot(223)
im_2 = d_sobel(im_0)
ax_2.imshow(im_2,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax_2.set_title('my diagonal sobel')
ax_2.set_xticks([])
ax_2.set_yticks([])

# ax_3
im_3 = laplacian(im_0)
ax_3 = fig.add_subplot(224)
ax_3.imshow(im_3,cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=1))
ax_3.set_title('my laplacian')
ax_3.set_xticks([])
ax_3.set_yticks([])

fig.suptitle('exp_4_2')
fig.savefig('exp_4_2.jpg')
fig.savefig('exp_4_2.eps')

