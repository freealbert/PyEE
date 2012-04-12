# -*- coding:utf-8 -*-

import os

def get_filenames(target_dir):
    filenames = []
    for path,subdirs,files in os.walk(target_dir):
        for filename in files:
            if filename[-4:] == '.py~':
                filenames += [path+'/'+filename]
    return filenames

if __name__ == "__main__":
    target_dir = raw_input("target_dir:")
    filenames = get_filenames(target_dir)
    for filename in filenames:
        if filename[-4:] == ".py~":
            os.remove(filename)
