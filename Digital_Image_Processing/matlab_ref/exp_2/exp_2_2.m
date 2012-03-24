clc;
clear;
close all;
cd d:/
cd DIP

mountain_0 = imread('images/mountain.jpg');
subplot(2,2,1);
imshow(mountain_0);
subplot(2,2,2);
imhist(mountain_0);

mountain_1 = histeq(mountain_0);
subplot(2,2,3);
imshow(mountain_1);
subplot(2,2,4);
imhist(mountain_1);

imwrite(mountain_1,'mountain_1.jpg')