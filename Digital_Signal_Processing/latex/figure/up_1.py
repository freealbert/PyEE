import numpy as np
import matplotlib.pylab as pl 
import scipy.signal as signal
import dsp
L = 4
fig = pl.figure(figsize=(12,9))
# x(t) 
tao = 0.5
dt = 0.001
Ts = dt
fs = 1/Ts
t = np.arange(0,tao,dt)
x_t = np.sin(2*np.pi*50*t)+np.sin(2*np.pi*100*t)
ax1 = fig.add_subplot(1,2,1)
ax1.stem(t,x_t)
ax1.set_xlabel('t')
ax1.set_ylabel('x(t)')
ax1.set_title('x(t)')
ax1.set_xlim([0,0.05])
# x(f)
N = dsp.get_fft_len(x_t)
x_f = np.fft.fftshift(np.abs(np.fft.fft(x_t,n=N)))
f = np.linspace(-fs/2,fs/2,N)
ax2 = fig.add_subplot(1,2,2)
ax2.stem(f,x_f)
ax2.set_xlabel('f')
ax2.set_ylabel('x(f)')
ax2.set_title('x(f)')
fig.savefig('up_1.jpg')