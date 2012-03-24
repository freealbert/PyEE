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

[M,N] = size(test3_2_0);
test3_2_1 = test3_2_0;

for m = 2:1:M-1
    for n = 2:1:N-1
        test3_2_1(m,n) = median([test3_2_0(m-1,n-1) test3_2_0(m-1,n) test3_2_0(m-1,n+1) test3_2_0(m,n-1) test3_2_0(m,n) test3_2_0(m,n+1) test3_2_0(m+1,n-1) test3_2_0(m+1,n) test3_2_0(m+1,n+1)]);
    end
end

subplot(122);
imshow(test3_2_1);
title('my own median filter function');