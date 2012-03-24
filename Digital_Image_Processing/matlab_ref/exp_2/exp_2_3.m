clc;
clear;
close all;

cd e:/
cd DIP

mountain_0 = imread('images/mountain.jpg');
subplot(3,2,1);
imshow(mountain_0);

subplot(3,2,2);
imhist(mountain_0);
r = 0:1:255;
n = [r<=5].*r*1400 + [r>5].*[r<=20].*(7000-310*r) + [r>20].*[r<=180].*(900-5*r) + [r>180].*[r<=225].*(-1440+8*r) + [r>225].*[r<=255].*(3060-12*r);
subplot(3,2,[3,4]);
plot(r,n)
mountain_2 = histeq(mountain_0,n);
subplot(3,2,5);
imshow(mountain_2);
subplot(3,2,6);
f=imhist(mountain_2);
imhist(mountain_2);
figure;
plot(f);
imwrite(mountain_2,'mountain_2.jpg');



