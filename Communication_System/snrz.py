# -*- coding:utf-8 -*-

from __future__ import division
import numpy as np
import scipy.fftpack as fftpack
import matplotlib.pylab as pl

def get_fft_length(x):
    fft_length = 0
    x_length = len(x)
    for i in xrange(10000):
        if x_length <= 2**(i):
            fft_length = 2**i
            break
    return fft_length

x = '100110000101'
T_a = 1
f = 1/T_a
Omega = 2*np.pi*f
f_s = 300
T_s = T_a/f_s
t = np.arange(0,len(x),T_s)
y = np.asarray([])
for i in range(len(x)):
    if x[i] == '1':
        for j in range(f_s):
            y = np.hstack((y,np.asarray([1])))
    else:
        for j in range(f_s):
            y = np.hstack((y,np.asarray([0])))
y_max = np.max(y)
y_min = np.min(y)
N = get_fft_length(y)
z = np.abs(fftpack.fftshift(fftpack.fft(y,N)))

fig = pl.figure(figsize=(8,6))
ax_1 = fig.add_subplot(211)
ax_1.plot(t,y)
ax_1.set_ylim(y_min-0.1,y_max+0.1)
ax_1.set_xlabel('t/s')

ax_2 = fig.add_subplot(212)
pinlv = np.linspace(-f_s/2,f_s/2,len(z))
ax_2.stem(pinlv,z)
ax_2.set_ylim(bottom=0,top=1600)
ax_2.set_xlim(left=-4,right=4)
ax_2.set_xlabel('f/Hz')

fig.suptitle('SNRZ')
fig.savefig('snrz.png')
