% Example of Testing 4

InImage=imread('E:\BackfromUS\Teaching\2010-2011����ͼ����\����\Images\cameraman.tif');
InImage=im2double(InImage);

%����imfilter������fspecial������������
h1=fspecial('sobel');%����sobel������,Ĭ������ֱ�ݶȣ���ˮƽ��Ե
OutImage=imfilter(InImage,h1);
OutImage1=imfilter(InImage,h1');
figure,imshow(sqrt(OutImage.^2+OutImage1.^2));title('SobelImage');


%ֱ�Ӳ���Sobel����
hx=[1,0,-1;2,0,-2;1,0,-1];
hy=[-1,-2,-1;0,0,0;1,2,1];
OutImage=imfilter(InImage,hx);
OutImage1=imfilter(InImage,hy);
figure,imshow(sqrt(OutImage.^2+OutImage1.^2));title('SobelImage');