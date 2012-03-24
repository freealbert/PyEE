cd d:/
cd DIP
cd exp_1
rice_0 = imread('d:/DIP/images/rice.png');
rice_0 = im2double(rice_0);
subplot(1,3,1);
imshow(rice_0);
title('source image');


r = 0:0.00001:1;
s = [r<0.2].*r + [r>=0.2].*[r<=0.4].*0.6 + [r>0.4].*r;
subplot(1,3,2);
plot(r,s);
title('s-r')
xlabel('r');
ylabel('s');


rice_1 = rice_0;
[M,N] = size(rice_1);
for m = 1:M
    for n = 1:N
        if rice_1(m,n) >= 0.2
            if rice_1(m,n) <= 0.4
                rice_1(m,n) = 0.6;
            end
        end
    end
end
subplot(1,3,3);
imshow(rice_1);
title('transformed image');
imwrite(rice_1,'rice_1.jpg');
