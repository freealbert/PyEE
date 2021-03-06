clc;
clear;
close all;
N = 1000;
dt = 0.001;
t = 0:dt:1;
fs = 1000;
%% figure 1 ,  调制信号 
f0 = 10;
mt_t = cos(2*pi*f0*t);
subplot(2,1,1);
plot(t,mt_t);
xlabel('时间/t');
ylabel('幅度/v');
title('调制信号时域波形');
% frequence domain
mt_f = fftshift(abs(fft(mt_t)));
mt_f_list = [0:N]*fs/N-fs/2;
subplot(2,1,2);
stem(mt_f_list,mt_f);
axis([-15,15,0,600]);
xlabel('频率/Hz');
ylabel('幅度/v')
title('调制信号频谱');

%% figure 2 , 载波
figure;
fc = 50;
carrier_t = cos(2*pi*fc*t);
subplot(2,1,1);
plot(t,carrier_t);
xlabel('时间/t');
ylabel('幅度/v');
title('载波时域波形');
% frequence domain
carrier_f = fftshift(abs(fft(carrier_t)));
carrier_f_list = [0:N]*fs/N-fs/2;
subplot(2,1,2);
stem(carrier_f_list,carrier_f);
axis([-60,60,0,600]);
xlabel('频率/Hz');
ylabel('幅度/v')
title('载波频谱');

%% figure 3 , 已调信号
figure;
st_t = mt_t.*carrier_t;
subplot(2,1,1);
plot(t,st_t);
xlabel('时间/t');
ylabel('幅度/v');
title('已调信号时域波形');
% frequence domain
st_f = fftshift(abs(fft(st_t)));
st_f_list = [0:N]*fs/N-fs/2;
subplot(2,1,2);
stem(st_f_list,st_f);
axis([-70,70,0,600]);
xlabel('频率/Hz');
ylabel('幅度/v')
title('已调信号频谱');

%% figure 4 ,接收端接收到的带5dB AWGN的信号
figure;
sr_t = awgn(st_t,5,'measured','dB');
subplot(2,1,1);
plot(t,sr_t);
xlabel('时间/t');
ylabel('幅度/v');
title('带5dB AWGN信号时域波形');
% frequence domain
sr_f = fftshift(abs(fft(sr_t)));
sr_f_list = [0:N]*fs/N-fs/2;
subplot(2,1,2);
stem(sr_f_list,sr_f);
axis([-70,70,0,600]);
xlabel('频率/Hz');
ylabel('幅度/v');
title('带5dB AWGN的信号频谱');

%% figure 5 , 经过带通滤波器后的信号
figure;
Wp = [40 60]/(fs/2);
Ws = [30 75]/(fs/2);
Rp = 3; % 通带内衰减
Rs = 40; % 阻带内衰减
[N_But,Wn] = buttord(Wp,Ws,Rp,Rs,'s');
[B,A] = butter(N_But,Wn,'bandpass');
sr_bp_t = filtfilt(B,A,sr_t);
subplot(2,1,1);
plot(t,sr_bp_t);
xlabel('时间/t');
ylabel('幅度/v');
title('通过带通滤波器后信号的时域波形');
sr_bp_f = fftshift(abs(fft(sr_bp_t)));
sr_bp_f_list = [0:N]*fs/N -fs/2;
subplot(2,1,2);
stem(sr_bp_f_list,sr_bp_f);
axis([-70,70,0,600]);
xlabel('频率/Hz');
ylabel('幅度/v');
title('通过带通滤波器后信号的频谱');

%% figure 6 , 与本地载波相乘后的信号
figure;
temp_t = sr_bp_t.*carrier_t;
subplot(2,1,1);
plot(t,temp_t);
xlabel('时间/t');
ylabel('幅度/v');
title('与本地载波相乘后信号的时域波形');
% frequence domain
temp_f = fftshift(abs(fft(temp_t)));
temp_f_list = [0:N]*fs/N-fs/2;
subplot(2,1,2);
stem(temp_f_list,temp_f);
axis([-120,120,0,600]);
xlabel('频率/Hz');
ylabel('幅度/v')
title('与本地载波相乘后信号的频谱');

%% figure 7 , 经过低通滤波器后的波形
figure;
Wp = 10/(fs/2);
Ws = 20/(fs/2);
Rp = 3;
Rs = 40;
[N_But,Wn] = buttord(Wp,Ws,Rp,Rs,'s');
[B,A] = butter(N_But,Wn,'low');
mr_t = filtfilt(B,A,temp_t);
subplot(2,1,1);
plot(t,mr_t);
xlabel('时间/t');
ylabel('幅度/v');
title('解调信号的时域波形');
mr_f = fftshift(abs(fft(mr_t)));
mr_f_list = [0:N]*fs/N -fs/2;
subplot(2,1,2);
stem(mr_f_list,mr_f);
axis([-15,15,0,600]);
xlabel('频率/Hz');
ylabel('幅度/v');
title('解调信号的频谱');