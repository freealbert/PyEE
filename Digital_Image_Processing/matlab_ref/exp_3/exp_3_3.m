clc;
clear;
close all;

cd e:/
cd DIP
cd exp_3

test3_1_0 = imread('../images/test3_1.jpg');
test3_1_0 = im2double(test3_1_0);
subplot(131);
imshow(test3_1_0);
title('original image');
test3_1_1 = imnoise(test3_1_0,'gaussian',0,0.02);
subplot(132);
imshow(test3_1_1);
title('with AWGN');
test3_1_2 = nlfilter(test3_1_1,[5,5],@mean2);
subplot(133);
imshow(test3_1_2);
title('after 5\times5 mean filter');