clc;
clear;
close all;

cd e:/
cd DIP
cd exp_3

test3_2_0 = imread('../images/test3_2.jpg');
test3_2_0 = im2double(test3_2_0);
subplot(131);
imshow(test3_2_0);
title('original image');

h1 = fspecial('average',[5,5]);
t1 = clock;
test3_2_1 = filter2(h1,test3_2_0);
t2 = clock;
subplot(132);
imshow(test3_2_1);
time = t2 - t1;
title_str = sprintf('filter2 time is %f s', time(6));
title(title_str);

t1 =clock;
test3_2_2 = nlfilter(test3_2_0,[5,5],@mean2);
t2 = clock;
subplot(133);
imshow(test3_2_2);
time = t2 - t1;
title_str = sprintf('nlfilter time is %f s', time(6));
title(title_str);