function [frames,frame_num] = get_frames(data,frame_length,frame_shift)
% data = data;
% frame_length = frame_length;
% frame_shift = frame_shift;
data_length = length(data)
frame_num = fix(((data_length-frame_length)/frame_shift)+1);
frames = zeros(frame_num,frame_length);
n = 1;
for i = 1:frame_num
    for j = 1:frame_length
        frames(i,j) = data(n);
        n = n + 1;
    end
    n = n - frame_length + frame_shift;
end
