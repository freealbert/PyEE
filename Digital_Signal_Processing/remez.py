import numpy as np
import matplotlib.pylab as pl 
import scipy.signal as signal

N = 1024*4
# filter
length = 72
# bpass = signal.remez(length,[0,0.05,0.1,0.2,0.25,0.5],[0,1,0])
bpass = signal.firwin(101,120.0/(N/2))
freq, response = signal.freqz(bpass)
ampl = np.abs(response)
fig = pl.figure()
ax1 = fig.add_subplot(111)
ax1.semilogy(freq/(2*np.pi), ampl, 'b-') # freq in Hz
pl.show()

