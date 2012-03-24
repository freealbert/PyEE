# -*- coding : utf-8 -*-

import myhisteq
import matplotlib.pylab as pl
import matplotlib.cm as cm
import numpy as np
import Image

mountain_0 = np.asarray(Image.open('mountain.jpg').convert('L'))
mountain_1,hist_1,hist_0,x_1,x_0 = myhisteq.myhisteq(mountain_0)
fig = pl.figure()
ax1 = fig.add_subplot(221)
ax1.imshow(mountain_0,cmap=cm.gray)
ax1.set_title('input image')

ax2 = fig.add_subplot(222)
ax2.bar(x_0[:-1],hist_0,width=0.05)
ax2.set_title('input histogram')

ax3 = fig.add_subplot(223)
ax3.imshow(mountain_1,cmap=cm.gray)
ax3.set_title('output image')

ax4 = fig.add_subplot(224)
ax4.bar(x_1[:-1],hist_1,width=0.05)
ax4.set_title('output histogram')

fig.suptitle('exp_2_2')
fig.savefig('exp_2_2.jpg')
