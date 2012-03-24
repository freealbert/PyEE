clc;
clear;
close all;

cd e:/
cd DIP
cd exp_3

test3_2_0 = imread('../images/test3_2.jpg');
test3_2_0 = im2double(test3_2_0);
subplot(121);
imshow(test3_2_0);
title('original image');
test3_2_1 = medfilt2(test3_2_0);
subplot(122);
imshow(test3_2_1);
title('after 3\times3 medfilt');
