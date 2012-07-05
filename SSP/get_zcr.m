function [zcr] = get_zcr(frame)

zcr = 0;
for i = 1:length(frame)-1
    if(frame(i)*frame(i+1)<0)
        zcr = zcr + 1;
    end 
end