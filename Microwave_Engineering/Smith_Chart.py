# -*- coding:utf-8 -*-

import matplotlib.pylab as pl
import numpy as np

def plot_circle(ax,x,y,r):
    dtheta = 0.1
    theta = np.arange(0,2*np.pi+dtheta,dtheta)
    ax.plot(x+r*np.cos(theta),y+r*np.sin(theta),'k')

def get_up_y_boundary(x):
    if x>=1:
        x = 1.0
    up_y_boundary = np.sqrt(1-x**2)
    return up_y_boundary

def get_down_y_boundary(x):
    if x>=1:
        x = 1.0
    down_y_boundary = -np.sqrt(1-x**2)
    return down_y_boundary
           
if __name__ == "__main__":
    fig = pl.figure(figsize=(20,20))
    ax_1 = fig.add_subplot(111)
    ax_1.set_xlim(left=-1,right=1)
    ax_1.set_ylim(bottom=-1,top=1)
    ax_1.set_xticks([])
    ax_1.set_yticks([])
    # resistor circle
    r_L_list = np.hstack((np.arange(0,1.1,0.1),np.arange(1.2,2.2,0.2),np.asarray([3.0,4.0,5.0,10,20,50])))
    r_center_x_list = r_L_list/(1+r_L_list)
    r_center_y_list = np.asarray([0]*len(r_L_list))
    r_r_list = 1/(1+r_L_list)
    for i in range(len(r_L_list)):
        plot_circle(ax_1,r_center_x_list[i],r_center_y_list[i],r_r_list[i])

    # adtive impedence circle
    x_L_list = np.hstack((np.arange(0.1,1.1,0.1),np.arange(1.2,2.2,0.2),np.asarray([3.0,4.0,5.0,10,20,50])))
    for x_L in x_L_list:
        x_center_x = 1
        x_center_y = 1/x_L
        x_r = 1/x_L
        dtheta = -0.001
        theta = np.arange(-np.pi/2,-np.pi/2-2*np.pi+dtheta,dtheta)
        x_x = []
        x_y = []
        for i in theta:
            current_x = 1+x_r*np.cos(i)
            current_y = 1/x_L+x_r*np.sin(i)
            up_y_boundary = get_up_y_boundary(current_x)
            if current_y <= up_y_boundary:
                x_x += [current_x]
                x_y += [current_y]
            else:
                break
        ax_1.plot(x_x,x_y,'k')

    # minus impedence circle
    x_L_list = np.hstack((np.arange(0.1,1.1,0.1),np.arange(1.2,2.2,0.2),np.asarray([3.0,4.0,5.0,10,20,50])))
    for x_L in x_L_list:
        x_center_x = 1
        x_center_y = -1/x_L
        x_r = 1/x_L
        dtheta = 0.001
        theta = np.arange(np.pi/2,np.pi/2+2*np.pi+dtheta,dtheta)
        x_x = []
        x_y = []
        for i in theta:
            current_x = 1+x_r*np.cos(i)
            current_y = -1/x_L+x_r*np.sin(i)
            down_y_boundary = get_down_y_boundary(current_x)
            if current_y >= down_y_boundary:
                x_x += [current_x]
                x_y += [current_y]
            else:
                break
        ax_1.plot(x_x,x_y,'k')
    x = np.arange(-1,1+0.001,0.001)
    y = np.asarray([0]*len(x))
    ax_1.plot(x,y,'k')
    
    fig.suptitle('The Complete Smith Chart\n\nfreealbert Design')
    fig.savefig('sc.jpg')




