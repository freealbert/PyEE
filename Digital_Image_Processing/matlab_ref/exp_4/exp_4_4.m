


clc;
clear;
close all;

cd e:/
cd DIP
cd exp_4

cell_0 = imread('../images/cell.jpg');
subplot(121);
imshow(cell_0);
title('original image');

cell_1 = Roberts(cell_0,6);
subplot(122);
imshow(cell_1);
title('after Roberts');
imwrite(cell_1,'cell_1.jpg');