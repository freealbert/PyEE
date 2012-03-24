clc;
clear;
close all;
cd d:/
cd DIP
Picture_0 = imread('images/Picture.jpg');
subplot(2,2,1);
imshow(Picture_0);
Picture_0 = im2double(Picture_0);
subplot(2,2,2);
imhist(Picture_0);
Picture_1 = Picture_0.^0.5;
subplot(2,2,3);
imshow(Picture_1);
subplot(2,2,4);
imhist(Picture_1);

imwrite(Picture_1,'Picture_1.jpg');