clc;
clear;
close all;

cd e:/
cd DIP
cd exp_4

cameraman_0 = imread('../images/cameraman.tif');
cameraman_0 = im2double(cameraman_0);
subplot(321);
imshow(cameraman_0);
title('original image');
subplot(322);
imshow(cameraman_0);
title('original image');

h1 = fspecial('sobel');
cameraman_1 = imfilter(cameraman_0,h1);
subplot(3,2,3);
imshow(cameraman_1);
title('fspecial sobel');

h2 = fspecial('laplacian',0);
cameraman_2 = imfilter(cameraman_0,h2);
subplot(3,2,4);
imshow(cameraman_2);
title('fspecial laplacian');

dx = [-1 -2 -1;0 0 0;1 2 1];
dy = [-1 0 1;-2 0 2;-1 0 1];
h3 = sqrt(dx.^2 + dy.^2);
cameraman_3 = imfilter(cameraman_0,h3);
subplot(3,2,5);
imshow(cameraman_3);
title('soble \sqrt{d_x^2+d_y^2}');

h4 = [0 -1 0;-1 4 -1;0 -1 0];
cameraman_4 = imfilter(cameraman_0,h4);
subplot(3,2,6);
imshow(cameraman_4);
title('laplacian');
    


