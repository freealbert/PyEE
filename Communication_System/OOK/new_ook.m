clc;
clear;
close all;

fs=4000;
fc = 1000;
Rs = 100;
N = 40;
%bit = [1 0 1 0 1 0 1 0 1 0];
bit = [1 1 0 1 0 1 0 1 0 1 1 1 0 0 1 1 0 1 1 0 0 0 1 0 1 0 1 0 1 1 0 0 0 1 0 0 1 0 1 0];

%% fig 1 : ���������źż��书����
% �����źŲ���
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
title('�����źŲ���');
xlabel('t/s');
ylabel('A/v');
% �����źŹ�����
[Pxx_t,Pxxc_t,f_t] = pmtm(base_signal_t,3.5,length(base_signal_t),fs,0.99);
hpsd_t = dspdata.psd(Pxx_t,'Fs',fs);
subplot(2,1,2);
plot(hpsd_t);
%% fig 2 : ����OOK�źż��书����
figure;
t_seg = 0:dt:1/Rs-dt;
carrier_t = cos(2*pi*fc*t);
moudled_signal = [];
% ����
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
title('OOK�źŲ���');
xlabel('t/s');
ylabel('A/v');
% OOK�źŹ�����
[Pxx_m_t,Pxxc_m_t,f_m_t] = pmtm(moudled_signal,3.5,1024,fs,0.99);
hpsd_m_t = dspdata.psd(Pxx_m_t,'Fs',fs);
subplot(2,1,2);
plot(hpsd_m_t);

%% fig 3 : ��10dB awgn���ѵ��źż��书����
% ��10dB awgn���źŲ���
figure;
moudled_signal_awgn = awgn(moudled_signal,10,'measured','dB');
subplot(2,1,1);
plot(t,moudled_signal_awgn);
axis([0,t_max,-2,2]);
title('��10dB��˹���������ѵ��źŲ���');
xlabel('t/s');
ylabel('A/v');
% ��10dB��˹���������ѵ��źŹ�����
[Pxx_awgn,Pxxc_awgn,f_awgn] = pmtm(moudled_signal_awgn,3.5,1024,fs,0.99);
hpsd_awgn = dspdata.psd(Pxx_awgn,'Fs',fs);
subplot(2,1,2);
plot(hpsd_awgn);

%% fig 4 : ͨ����ͨ�˲���������źż��书����
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
title('ͨ����ͨ�˲������ѵ��źŲ���');
xlabel('t/s');
ylabel('A/v');
% ��10dB��˹�������Ļ����źŹ�����
[Pxx_bp,Pxxc_bp,f_bp] = pmtm(moudled_signal_bp,3.5,1024,fs,0.99);
hpsd_bp = dspdata.psd(Pxx_bp,'Fs',fs);
subplot(2,1,2);
plot(hpsd_bp);

%% figure 5 ,��ɽ�����뱾���ز���˺�ͨ����ͨ�˲�����Ĳ���
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
title('��ɽ��ͨ����ͨ�˲�����Ĳ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_base_r,Pxxc_base_r,f_base_r] = pmtm(base_signal_r,3.5,1024,fs,0.99);
hpsd_base_r = dspdata.psd(Pxx_base_r,'Fs',fs);
subplot(2,1,2);
plot(hpsd_base_r);

%% figure 6 , Ӳ�о���Ĳ���
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
title('Ӳ�о����źŲ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_j,Pxxc_j,f_j] = pmtm(base_judge,3.5,1024,fs,0.99);
hpsd_j = dspdata.psd(Pxx_j,'Fs',fs);
subplot(2,1,2);
plot(hpsd_j );

%% figure 7 , Ӳ�о���Ĳ���������źŶԱ�
figure;
subplot(2,1,1);
plot(t,base_signal_t);
axis([0,max(t)+dt,-0.2,1.2]);
title('�����źŲ���');
xlabel('t/s');
ylabel('A/v');7
subplot(2,1,2);
plot(t,base_judge);
axis([0,max(t)+dt,-0.2,1.2]);
title('Ӳ�о����źŲ���');
xlabel('t/s');
ylabel('A/v');