# -*- coding:utf-8 -*- 

import matplotlib.pyplot as plt
import Image
import matplotlib.cm as cm
import numpy as np

fig = plt.figure()
circuit_0 = np.asarray(Image.open('circuit.tif').convert('L'))/float(255)
ax1 = fig.add_subplot(221)
ax1.imshow(circuit_0,cmap=cm.gray)
ax1.set_title('input image')
r = np.arange(0,1+0.0001,0.0001)
s = 1 - r
ax3 = fig.add_subplot(2,2,(3,4))
ax3.plot(r,s)
ax3.set_xlabel('r')
ax3.set_ylabel('s')
ax3.set_title('s-r')

circuit_1 = circuit_0.copy()
(M,N) = circuit_0.shape
for m in range(M):
    for n in range(N):
        circuit_1[m,n] = 1 - circuit_0[m,n]
ax2 = fig.add_subplot(222)
ax2.imshow(circuit_1,cmap=cm.gray)
ax2.set_title('output image')
fig.suptitle('exp_1_5')
fig.savefig('exp_1_5.jpg')
