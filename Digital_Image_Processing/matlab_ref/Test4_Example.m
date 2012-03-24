% Example of Testing 4

InImage=imread('E:\BackfromUS\Teaching\2010-2011数字图像处理\汪玲\Images\cameraman.tif');
InImage=im2double(InImage);

%采用imfilter函数和fspecial函数做锐化运算
h1=fspecial('sobel');%产生sobel锐化算子,默认是求垂直梯度，锐化水平边缘
OutImage=imfilter(InImage,h1);
OutImage1=imfilter(InImage,h1');
figure,imshow(sqrt(OutImage.^2+OutImage1.^2));title('SobelImage');


%直接产生Sobel算子
hx=[1,0,-1;2,0,-2;1,0,-1];
hy=[-1,-2,-1;0,0,0;1,2,1];
OutImage=imfilter(InImage,hx);
OutImage1=imfilter(InImage,hy);
figure,imshow(sqrt(OutImage.^2+OutImage1.^2));title('SobelImage');