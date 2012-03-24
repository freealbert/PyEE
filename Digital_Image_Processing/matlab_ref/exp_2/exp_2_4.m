clc;
clear;
close all;

cd e:/
cd DIP

mountain_0 = imread('images/mountain.jpg');
mountain_3 = double(mountain_0);
[M,N] = size(mountain_0);

for m = 1:M
    for n = 1:N
        if (mountain_3(m,n) >= 0) & (mountain_3(m,n) <=30)
            mountain_3(m,n) = 110/30*mountain_3(m,n);
        else
            if mountain_3(m,n) <= 80
                mountain_3(m,n) = 110/30*(mountain_3(m,n)-30)+110;
            else
                mountain_3(m,n) = mountain_3(m,n);
            end
        end
    end
end

mountain_3 = uint8(mountain_3);
r = 0:1:255;
n = [r<=30].*r.*(11/3) + [r>30].*[r<=80].*((r-30).*(11/3)+110) + [r>80].*r

subplot(3,2,1);
imshow(mountain_0);
subplot(3,2,2);
imhist(mountain_0);
subplot(3,2,[3,4]);
plot(r,n);
subplot(3,2,5);
imshow(mountain_3);
subplot(3,2,6);
imhist(mountain_3);
f=imhist(mountain_3);
figure;
plot(f);
imwrite(mountain_3,'mountain_3.jpg');

