import numpy as np

def get_fft_len(x_t):
	len_x = len(x_t)
	fft_len = np.int(2**np.ceil(np.log2(len_x)))
	return fft_len