import matplotlib.pylab as pl
import numpy as np

y = np.asarray([4*1e10,4*1e7,40000,30000,20000,20000,20000,20000,20000])
#x = np.asarray([1,2,3,4,5,6,7,8,9])
x = np.asarray([0.01,0.1,1,1.5,2,5,10,100,10000])
x_dB = 10*np.log10(x)
y_dB = 10*np.log10(y/min(y))
fig = pl.figure()
ax = fig.add_subplot(111)
ax.stem(x_dB,y_dB)
#dot_x = 10*np.log10(np.linspace(0.01,10000,0.01))
dot_y = np.asarray([0]*len(x))
ax.plot(x_dB,dot_y,'k--')
ax.set_ylim([-10,70])
ax.set_xlim([-22,42])
ax.set_xlabel('kr(dB)')
ax.set_ylabel('U(dB)')
ax.set_title('U-kr')
fig.savefig('ratio.png')


