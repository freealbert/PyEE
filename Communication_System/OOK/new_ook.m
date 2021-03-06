clc;
clear;
close all;

fs=4000;
fc = 1000;
Rs = 100;
N = 40;
%bit = [1 0 1 0 1 0 1 0 1 0];
bit = [1 1 0 1 0 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 0 1 0 1 0 1 0 1 1 0 0 0 1 0 0 1 0 1 0];

%% fig 1 : 产生基带信号及其功率谱
% 基带信号波形
figure;
dt = 1/Rs/N;
t = 0:dt:length(bit)/Rs-dt;
t_max = max(t)+dt;
base_signal_t = [];
for i = 1:length(bit)
    if bit(i) == 0
        bits = zeros(1,N);
    else 
        bits = ones(1,N);
    end
    base_signal_t = [base_signal_t,bits];
end
subplot(2,1,1);
plot(t,base_signal_t);
axis([0,max(t)+dt,-0.2,1.2]);
title('基带信号波形');
xlabel('t/s');
ylabel('A/v');
% 基带信号功率谱
[Pxx_t,Pxxc_t,f_t] = pmtm(base_signal_t,3.5,length(base_signal_t),fs,0.99);
hpsd_t = dspdata.psd(Pxx_t,'Fs',fs);
subplot(2,1,2);
plot(hpsd_t);
%% fig 2 : 产生OOK信号及其功率谱
figure;
t_seg = 0:dt:1/Rs-dt;
carrier_t = cos(2*pi*fc*t);
moudled_signal = [];
% 调制
for i = 1:length(bit)
    if bit(i) == 0
        bits = zeros(1,length(t_seg));
    else 
        bits = ones(1,length(t_seg));
    end
    moudled_signal = [moudled_signal,bits];
end
moudled_signal = moudled_signal.*carrier_t;
subplot(2,1,1);
plot(t,moudled_signal);
axis([0,max(t)+dt,-1.5,1.5]);
title('OOK信号波形');
xlabel('t/s');
ylabel('A/v');
% OOK信号功率谱
[Pxx_m_t,Pxxc_m_t,f_m_t] = pmtm(moudled_signal,3.5,1024,fs,0.99);
hpsd_m_t = dspdata.psd(Pxx_m_t,'Fs',fs);
subplot(2,1,2);
plot(hpsd_m_t);

%% fig 3 : 带10dB awgn的已调信号及其功率谱
% 带10dB awgn的信号波形
figure;
moudled_signal_awgn = awgn(moudled_signal,10,'measured','dB');
subplot(2,1,1);
plot(t,moudled_signal_awgn);
axis([0,t_max,-2,2]);
title('带10dB高斯白噪声的已调信号波形');
xlabel('t/s');
ylabel('A/v');
% 带10dB高斯白噪声的已调信号功率谱
[Pxx_awgn,Pxxc_awgn,f_awgn] = pmtm(moudled_signal_awgn,3.5,1024,fs,0.99);
hpsd_awgn = dspdata.psd(Pxx_awgn,'Fs',fs);
subplot(2,1,2);
plot(hpsd_awgn);

%% fig 4 : 通过带通滤波器后调制信号及其功率谱
figure;
a = [900 1100];
Wp = a/(fs/2);
b = [800 1200];
Ws = b/(fs/2);
%Ws = b/fs;
Rp = 3;
Rs = 40;
[N_But,Wn] = buttord(Wp,Ws,Rp,Rs,'s');
[B,A] = butter(N_But,Wn,'bandpass');
moudled_signal_bp = filtfilt(B,A,moudled_signal_awgn);
subplot(2,1,1);
plot(t,moudled_signal_bp);
axis([0,t_max,-2,2]);
title('通过带通滤波器后已调信号波形');
xlabel('t/s');
ylabel('A/v');
% 带10dB高斯白噪声的基带信号功率谱
[Pxx_bp,Pxxc_bp,f_bp] = pmtm(moudled_signal_bp,3.5,1024,fs,0.99);
hpsd_bp = dspdata.psd(Pxx_bp,'Fs',fs);
subplot(2,1,2);
plot(hpsd_bp);

%% figure 5 ,相干解调，与本地载波相乘后并通过低通滤波器后的波形
figure;
temp_t = 2*moudled_signal_bp.*carrier_t;
Wp = 120/(fs/2);
Ws = 200/(fs/2);
Rp = 3;
Rs = 40;
[N_But,Wn] = buttord(Wp,Ws,Rp,Rs,'s');
[B,A] = butter(N_But,Wn,'low');
base_signal_r = filtfilt(B,A,temp_t);
subplot(2,1,1);
plot(t,base_signal_r);
title('相干解调通过低通滤波器后的波形');
xlabel('t/s');
ylabel('A/v');
[Pxx_base_r,Pxxc_base_r,f_base_r] = pmtm(base_signal_r,3.5,1024,fs,0.99);
hpsd_base_r = dspdata.psd(Pxx_base_r,'Fs',fs);
subplot(2,1,2);
plot(hpsd_base_r);

%% figure 6 , 硬判决后的波形
figure;
t_judge = N/2:N:length(bit)*(N-1)+N/2;
base_judge = [];
for i = 1:length(t_judge)
    if base_signal_r(t_judge(i)) < 0.5
        bits = zeros(1,N);
    else 
        bits = ones(1,N);
    end   
    base_judge = [base_judge,bits];
end;
subplot(2,1,1);
plot(t,base_judge);
axis([0,max(t)+dt,-0.2,1.2]);
title('硬判决后信号波形');
xlabel('t/s');
ylabel('A/v');
[Pxx_j,Pxxc_j,f_j] = pmtm(base_judge,3.5,1024,fs,0.99);
hpsd_j = dspdata.psd(Pxx_j,'Fs',fs);
subplot(2,1,2);
plot(hpsd_j );

%% figure 7 , 硬判决后的波形与基带信号对比
figure;
subplot(2,1,1);
plot(t,base_signal_t);
axis([0,max(t)+dt,-0.2,1.2]);
title('基带信号波形');
xlabel('t/s');
ylabel('A/v');7
subplot(2,1,2);
plot(t,base_judge);
axis([0,max(t)+dt,-0.2,1.2]);
title('硬判决后信号波形');
xlabel('t/s');
ylabel('A/v');