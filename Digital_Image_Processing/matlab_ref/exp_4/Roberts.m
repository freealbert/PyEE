function [output_image] = Roberts(input_image,T)
L_G = 255;
L_B = 0;
input_image = im2uint8(input_image);
[M,N] = size(input_image);
output_image = input_image;
for m = 1:1:(M-1)
    for n = 1:1:(N-1)
        G = abs(input_image(m,n)-input_image(m+1,n+1)) + abs(input_image(m+1,n)-input_image(m,n+1));
        if G >= T
            output_image(m,n) = L_G;
        else
            output_image(m,n) = L_B;
        end
    end
end

