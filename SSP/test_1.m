figure;
clc;
clear;
% close all;

[SpeechSource,Fs,nbits1] = wavread('S_01_01.wav');
datalength = Fs;
data = SpeechSource(1:datalength);

frame_len = 320;
frame_shift = 10;
num_frames = fix(length(data)/frame_shift-frame_len/frame_shift);
for n = 1:num_frames
    frame = data((n-1)*frame_shift+1:n*frame_shift+frame_len);
    energy(n) = sum(frame.^2);
end

subplot(2,1,1);
plot(energy);
title('Short time energy,  N=320, rectangular');
subplot(2,1,2);
plot(data)
title('Speech waveform');