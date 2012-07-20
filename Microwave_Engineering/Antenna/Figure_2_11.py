import numpy as np
import matplotlib.cm as cm
import matplotlib.pylab as pl
from mpl_toolkits.mplot3d import Axes3D

theta = np.linspace(0,np.pi,1000)

phi = np.linspace(0,np.pi,1000)

tt,pp = np.meshgrid(theta,phi)
#r = (np.cos(tt)**2)*(np.cos(3*tt)**2)
r = (np.sin(tt)**2)*(np.sin(3*tt)**2)

x = r*np.sin(tt)*np.cos(pp)
y = r*np.sin(tt)*np.sin(pp)
z = r*np.cos(tt)

ax = pl.subplot(111,projection='3d')
ax.plot_surface(x,y,z,cmap=cm.Reds)
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('z')
pl.show()

