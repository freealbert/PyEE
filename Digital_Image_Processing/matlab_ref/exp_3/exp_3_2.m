clc;
clear;
close all;

cd e:/
cd DIP
cd exp_3

test3_1_0 = imread('../images/test3_1.jpg');
test3_1_0 = im2double(test3_1_0);

mean_filter = @(x) median(x(:));

test3_1_1 = nlfilter(test3_1_0,[5,5],mean_filter);
subplot(221)
imshow(test3_1_0);
title('before 5\times5 mean filter');
subplot(222)
imshow(test3_1_1);
title('my own 5\times5 mean filter');
imwrite(test3_1_1,'test3_1_1.jpg');
test3_1_2 = nlfilter(test3_1_0,[5,5],@mean2);
subplot(223);
imshow(test3_1_2);
title('@mean2');
test3_1_3 = nlfilter(test3_1_0,[5,5],@std2);
subplot(224);
imshow(test3_1_3)
title('@std')
