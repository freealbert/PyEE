import numpy as np
import matplotlib.cm as cm
import matplotlib.pylab as pl
from mpl_toolkits.mplot3d import Axes3D

theta = np.linspace(0,np.pi,1000)
phi = np.linspace(0,2*np.pi,1000)
f = 10*10e9
k = 2*np.pi*f/(3*10e8)
kr = 0.0000001
r = kr/k
eta = 377
I_0 = 1
l = 1

tt,pp = np.meshgrid(theta,phi)
E_r = eta*I_0*l*np.cos(tt)/(2*np.pi*k*r**3)
E_theta = eta*I_0*l*np.sin(tt)/(4*np.pi*k*r**3)
E_phi = 0
H_r = 0
H_theta = 0
H_phi = I_0*l*np.sin(tt)/(4*np.pi*r**2)

E = np.sqrt(E_theta**2 + E_r**2 + E_phi**2)
H = np.sqrt(H_theta**2 + H_r**2 + H_phi**2)

W_av = E*H/2
W_rad = W_av
U = r**2*W_rad

x = U*np.sin(tt)*np.cos(pp)
y = U*np.sin(tt)*np.sin(pp)
z = U*np.cos(tt)

ax = pl.subplot(111,projection='3d')
ax.plot_surface(x,y,z,cmap=cm.Reds)
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
#ax.set_zlim(-60000,60000)
pl.show()





