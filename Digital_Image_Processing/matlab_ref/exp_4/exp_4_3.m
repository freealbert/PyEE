clc;
clear;
close all;

cd e:/
cd DIP
cd exp_4

skeleton_0 = imread('../images/skeleton.jpg');
skeleton_0 = im2double(skeleton_0);
subplot(331);
imshow(skeleton_0);
title('original image');
subplot(332);
imshow(skeleton_0);
title('original image');
subplot(333);
imshow(skeleton_0);
title('original image');
imwrite(skeleton_0,'exp_4_3_0.jpg');

h1 = [-1 -1 -1;-1 8 -1;-1 -1 -1];
skeleton_1 = imfilter(skeleton_0,h1);
subplot(334);
imshow(skeleton_1);
title('Step 1');
imwrite(skeleton_1,'exp_4_3_1.jpg');

skeleton_2 = skeleton_0 + skeleton_1;
subplot(335);
imshow(skeleton_2);
title('Step 2');
imwrite(skeleton_2,'exp_4_3_2.jpg');

h3_1 = fspecial('sobel');
skeleton_3 = imfilter(skeleton_0,h3_1);
h3_2 = fspecial('average',[5,5]);
skeleton_3 = imfilter(skeleton_3,h3_2);
subplot(336);
imshow(skeleton_3);
title('Step 3');
imwrite(skeleton_3,'exp_4_3_3.jpg');

skeleton_4 = skeleton_2.*skeleton_3;
subplot(337);
imshow(skeleton_4);
title('Step 4');
imwrite(skeleton_4,'exp_4_3_4.jpg');

skeleton_5 = skeleton_0 + skeleton_4;
subplot(3,3,8);
imshow(skeleton_5);
title('Step 5');
imwrite(skeleton_5,'exp_4_3_5.jpg');

skeleton_6 = imadjust(skeleton_5,[0,1],[0,1].*0.2);
subplot(339);
imshow(skeleton_6);
title('Step 6');
imwrite(skeleton_6,'exp_4_3_6.jpg');


