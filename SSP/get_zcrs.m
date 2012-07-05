function [zcrs] = get_zcrs(frames)
% [frames,frame_num] = get_frames(data,frame_length,frame_shift);
frames_size = size(frames);
frame_num = frames_size(1);
zcrs = [];
for n = 1:frame_num
    zcr = 0;
    frame = frames(n,:);
    for i = 1:length(frame)-1
        if(frame(i)*frame(i+1)<0)
            zcr = zcr + 1;
        end
    end
    zcrs = [zcrs zcr];
end