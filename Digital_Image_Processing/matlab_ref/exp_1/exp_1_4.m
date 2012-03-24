cd d:/
cd DIP
cd exp_1
kids_0 = imread('d:/DIP/images/kids.tif');
kids_0 = im2double(kids_0);
[M,N] = size(kids_0);

% part1
r_1 = 0:0.0001:1;
s_1 = r_1.^0.6; 
subplot(3,3,1);
imshow(kids_0);
title('source image')
subplot(3,3,2);
plot(r_1,s_1);
xlabel('r');
ylabel('s');
title('s-r r=0.6');
kids_1 = imadjust(kids_0,[0.1,1],[0.1,1].^0.6);
subplot(3,3,3);
imshow(kids_1);
title('transformed image');
imwrite(kids_1,'kids_1.jpg')

% part2
r_2 = 0:0.0001:1;
s_2 = r_2.^0.4; 
subplot(3,3,4);
imshow(kids_0);
subplot(3,3,5);
plot(r_2,s_2);
xlabel('r');
ylabel('s');
title('s-r r=0.4');
kids_2 = imadjust(kids_0,[0.1,1],[0.1,1].^0.4);
subplot(3,3,6);
imshow(kids_2);
imwrite(kids_2,'kids_2.jpg')

% part3
r_3 = 0:0.0001:1;
s_3 = r_3.^0.2; 
subplot(3,3,7);
imshow(kids_0);
subplot(3,3,8);
plot(r_3,s_3);
xlabel('r');
ylabel('s');
title('s-r r=0.2');
kids_3 = imadjust(kids_0,[0.1,1],[0.1,1].^0.2);
subplot(3,3,9);
imshow(kids_3);
imwrite(kids_3,'kids_3.jpg')
