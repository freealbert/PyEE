import numpy as np
import matplotlib.pylab as pl 
import scipy.signal as signal
import dsp
L = 4
fig = pl.figure(figsize=(24,18))
# x(t) 
tao = 0.5
dt = 0.001
Ts = dt
fs = 1/Ts
t = np.arange(0,tao,dt)
x_t = np.sin(2*np.pi*50*t)+np.sin(2*np.pi*100*t)
ax1 = fig.add_subplot(3,2,1)
ax1.stem(t,x_t)
ax1.set_xlabel('t')
ax1.set_ylabel('x(t)')
ax1.set_title('x(t)')
ax1.set_xlim([0,0.05])
# x(f)
N = dsp.get_fft_len(x_t)
x_f = np.fft.fftshift(np.abs(np.fft.fft(x_t,n=N)))
f = np.linspace(-fs/2,fs/2,N)
ax2 = fig.add_subplot(3,2,2)
ax2.stem(f,x_f)
ax2.set_xlabel('f')
ax2.set_ylabel('x(f)')
ax2.set_title('x(f)')
# ax2.set_xlim([-120,120])
# x'(t)
t_intp = np.linspace(0,max(t),len(t)*L,endpoint='False')
x_intp_t = np.asarray([])
for i in range(len(x_t)):
	temp = np.asarray([x_t[i],0,0,0])
	x_intp_t = np.hstack([x_intp_t,temp])
ax3 = fig.add_subplot(3,2,3)
ax3.stem(t_intp,x_intp_t)
ax3.set_xlabel('t')
ax3.set_ylabel("x'(t)")
ax3.set_title("x'(t)")
ax3.set_xlim([0,0.05])
# x'(f)
fs_intp = 1/dt*L
N = dsp.get_fft_len(x_intp_t)
x_intp_f = np.fft.fftshift(np.abs(np.fft.fft(x_intp_t,n=N)))
# f = np.fft.fftshift(np.arange(0,N)-N/2)
f = np.linspace(-fs_intp/2,fs_intp/2,N)
ax4 = fig.add_subplot(3,2,4)
ax4.stem(f,x_intp_f)		
ax4.set_xlabel('f')
ax4.set_ylabel("x'(f)")
ax4.set_title("x'(f)")
# ax4.set_xlim([-120,120])

# ax5 filter
length = 72
# bpass = signal.remez(length,[0,0.02,0.025,0.05,0.1,0.5],[0,1,0])
bpass = signal.firwin(101,120.0/(N/2))
freq, response = signal.freqz(bpass)
y_t = signal.lfilter(bpass,1,x_intp_t)
ax5 = fig.add_subplot(3,2,5)
ax5.stem(t_intp,y_t)
ax5.set_xlim([0,0.05])
# ax6
y_f = np.fft.fftshift(np.abs(np.fft.fft(y_t,n=N)))
# f = np.fft.fftshift(np.arange(0,N)-N/2)
f = np.linspace(-fs_intp/2,fs_intp/2,N)
ax6 = fig.add_subplot(3,2,6)
ax6.stem(f,y_f)		
# ax6.set_xlabel('f')
# ax6.set_ylabel("x'(f)")
# ax6.set_title("x'(f)")








fig.savefig('up_sample_1.jpg')
