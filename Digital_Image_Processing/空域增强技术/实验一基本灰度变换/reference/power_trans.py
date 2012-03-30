# -*- coding:utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np

r = np.arange(0,1+0.0001,0.0001)
s1 = r**0.2
s2 = r**0.5
s3 = r**0.8
s4 = r
s5 = r**(1.25)
s6 = r**2
s7 = r**5

plt.plot(r,s1,'--',r,s2,r,s3,'--',r,s4,r,s5,'--',r,s6,r,s7,'--')
plt.legend(('$\gamma=0.2$','$\gamma=0.5$','$\gamma=0.8$','$\gamma=1$','$\gamma=1.25$','$\gamma=2$','$\gamma=5$'),loc='lower right')
plt.xlabel('r')
plt.ylabel('s')
plt.title('power transform')
plt.savefig('power_trans.jpg')
plt.savefig('power_trans.eps')
