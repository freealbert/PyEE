# -*- coding:utf-8 -*-

import os

#new = 'cmap=cm.gray)'
#old = 'cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=255))'

#old = 'cmap=cm.gray)'
#new = 'cmap=cm.gray,norm=pl.Normalize(vmin=0,vmax=255))'
#old = "import matplotlib.pyplot as plt"
#new = "import matplotlib.pylab as pl"
old = "plt.figure"
new = "pl.figure"
def replace_a_file(filename,old,new):
    input_file = open(filename,'r')
    lines = input_file.readlines()
    for i in range(len(lines)):
        lines[i] = lines[i].replace(old,new)
    input_file.close()
    input_file = open(filename,'r+')
    input_file.writelines(lines)
    input_file.close()

def get_filenames(target_dir):
    filenames = []
    for path,subdirs,files in os.walk(target_dir):
        for filename in files:
            if filename[-3:] == '.py':
                filenames += [path+'/'+filename]
    return filenames

if __name__ == "__main__":
    #target_dir = raw_input("Please enter target_dir:")
    target_dir = "/home/freealbert/OpenSource/PyEE/Digital_Image_Processing"
    filenames = get_filenames(target_dir)
    for filename in filenames:
        replace_a_file(filename,old,new)
        #os.system('python2 '+filename)
