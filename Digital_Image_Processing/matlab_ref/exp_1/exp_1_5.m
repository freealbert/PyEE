cd d:/
cd DIP
cd exp_1
circuit_0 = imread('d:/DIP/images/circuit.tif');
circuit_0 = im2double(circuit_0);
[M,N] = size(circuit_0);


subplot(1,3,1);
imshow(circuit_0);
title('source image');

r = 0:0.0001:1;
s = 1-r;
subplot(1,3,2);
plot(r,s);
xlabel('r');
ylabel('s');
title('s-r');

circuit_1 = 1 - circuit_0;
subplot(1,3,3);
imshow(circuit_1);
title('transformed image');
imwrite(circuit_1,'circuit_1.jpg');