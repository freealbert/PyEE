function [frames_energy,frames,frame_num] = short_time_energy(data,frame_length,frame_shift)

[frames,frame_num] = get_frames(data,frame_length,frame_shift);
for n = 1:frame_num
    frames_energy(n) = sum(frames(n,:).^2);
end