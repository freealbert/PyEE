clc;
clear;
close all;
N = 1000;
dt = 0.001;
t = 0:dt:1;
fs = 1000;
%% figure 1 ,  �����ź� 
f0 = 10;
mt_t = cos(2*pi*f0*t);
subplot(2,1,1);
plot(t,mt_t);
xlabel('ʱ��/t');
ylabel('����/v');
title('�����ź�ʱ����');
% frequence domain
mt_f = fftshift(abs(fft(mt_t)));
mt_f_list = [0:N]*fs/N-fs/2;
subplot(2,1,2);
stem(mt_f_list,mt_f);
axis([-15,15,0,600]);
xlabel('Ƶ��/Hz');
ylabel('����/v')
title('�����ź�Ƶ��');

%% figure 2 , �ز�
figure;
fc = 50;
carrier_t = cos(2*pi*fc*t);
subplot(2,1,1);
plot(t,carrier_t);
xlabel('ʱ��/t');
ylabel('����/v');
title('�ز�ʱ����');
% frequence domain
carrier_f = fftshift(abs(fft(carrier_t)));
carrier_f_list = [0:N]*fs/N-fs/2;
subplot(2,1,2);
stem(carrier_f_list,carrier_f);
axis([-60,60,0,600]);
xlabel('Ƶ��/Hz');
ylabel('����/v')
title('�ز�Ƶ��');

%% figure 3 , �ѵ��ź�
figure;
st_t = mt_t.*carrier_t;
subplot(2,1,1);
plot(t,st_t);
xlabel('ʱ��/t');
ylabel('����/v');
title('�ѵ��ź�ʱ����');
% frequence domain
st_f = fftshift(abs(fft(st_t)));
st_f_list = [0:N]*fs/N-fs/2;
subplot(2,1,2);
stem(st_f_list,st_f);
axis([-70,70,0,600]);
xlabel('Ƶ��/Hz');
ylabel('����/v')
title('�ѵ��ź�Ƶ��');

%% figure 4 ,���ն˽��յ��Ĵ�5dB AWGN���ź�
figure;
sr_t = awgn(st_t,5,'measured','dB');
subplot(2,1,1);
plot(t,sr_t);
xlabel('ʱ��/t');
ylabel('����/v');
title('��5dB AWGN�ź�ʱ����');
% frequence domain
sr_f = fftshift(abs(fft(sr_t)));
sr_f_list = [0:N]*fs/N-fs/2;
subplot(2,1,2);
stem(sr_f_list,sr_f);
axis([-70,70,0,600]);
xlabel('Ƶ��/Hz');
ylabel('����/v');
title('��5dB AWGN���ź�Ƶ��');

%% figure 5 , ������ͨ�˲�������ź�
figure;
Wp = [40 60]/(fs/2);
Ws = [30 75]/(fs/2);
Rp = 3; % ͨ����˥��
Rs = 40; % �����˥��
[N_But,Wn] = buttord(Wp,Ws,Rp,Rs,'s');
[B,A] = butter(N_But,Wn,'bandpass');
sr_bp_t = filtfilt(B,A,sr_t);
subplot(2,1,1);
plot(t,sr_bp_t);
xlabel('ʱ��/t');
ylabel('����/v');
title('ͨ����ͨ�˲������źŵ�ʱ����');
sr_bp_f = fftshift(abs(fft(sr_bp_t)));
sr_bp_f_list = [0:N]*fs/N -fs/2;
subplot(2,1,2);
stem(sr_bp_f_list,sr_bp_f);
axis([-70,70,0,600]);
xlabel('Ƶ��/Hz');
ylabel('����/v');
title('ͨ����ͨ�˲������źŵ�Ƶ��');

%% figure 6 , �뱾���ز���˺���ź�
figure;
temp_t = sr_bp_t.*carrier_t;
subplot(2,1,1);
plot(t,temp_t);
xlabel('ʱ��/t');
ylabel('����/v');
title('�뱾���ز���˺��źŵ�ʱ����');
% frequence domain
temp_f = fftshift(abs(fft(temp_t)));
temp_f_list = [0:N]*fs/N-fs/2;
subplot(2,1,2);
stem(temp_f_list,temp_f);
axis([-120,120,0,600]);
xlabel('Ƶ��/Hz');
ylabel('����/v')
title('�뱾���ز���˺��źŵ�Ƶ��');

%% figure 7 , ������ͨ�˲�����Ĳ���
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
xlabel('ʱ��/t');
ylabel('����/v');
title('����źŵ�ʱ����');
mr_f = fftshift(abs(fft(mr_t)));
mr_f_list = [0:N]*fs/N -fs/2;
subplot(2,1,2);
stem(mr_f_list,mr_f);
axis([-15,15,0,600]);
xlabel('Ƶ��/Hz');
ylabel('����/v');
title('����źŵ�Ƶ��');