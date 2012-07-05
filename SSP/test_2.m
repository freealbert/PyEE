figure;
clc;
clear;
% close all;

[SpeechSource,Fs,nbits1] = wavread('noise_3.wav');
% [SpeechSource,Fs,nbits1] = wavread('S_01_01.wav');
datalength = length(SpeechSource);
data = SpeechSource(1:datalength);
frame_length = 320;
frame_shift = 10;

% [frames,frame_num] = get_frames(data,frame_len,frame_shift);
% for n = 1:frame_num
%     energy(n) = sum(frames(n,:).^2);
% end
[frames_energy,frames,frame_num] = short_time_energy(data,frame_length,frame_shift);
subplot(3,1,2);
plot(frames_energy);
title('Short time energy,  N=320, rectangular');
subplot(3,1,1);
plot(data)
title('Speech waveform');
xlabel('frame');
ylabel('Amplitude');

% for i = 1:frame_num
%     zcr(i)=get_zcr(frames(i,:));
% end
zcrs = get_zcrs(frames);
subplot(3,1,3);
plot(1:frame_num,zcrs);
title('zero crossing rate');
xlabel('frame');
ylabel('zero crossing rate')
% subplot(4,1,4);
% for i = 1:frame_num
%     zcr(i)=get_zcr(frames(i,:));
% end
% plot(1:frame_num,zcr);