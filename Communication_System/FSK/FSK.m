clc;
clear;
close all;

fs=4000;
fc_1 = 1500;
fc_0 = 500;
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

%% fig 2 : ����FSK�źż��书����
figure;
t_seg = 0:dt:1/Rs-dt;
carrier_t_0 = cos(2*pi*fc_0*t_seg);
carrier_t_1 = cos(2*pi*fc_1*t_seg);
moudled_signal = [];
% ����
for i = 1:length(bit)
    if bit(i) == 0
        bits = ones(1,N).*carrier_t_0;
    else 
        bits = ones(1,N).*carrier_t_1;
    end
    moudled_signal = [moudled_signal,bits];
end
subplot(2,1,1);
plot(t,moudled_signal);
axis([0,max(t)+dt,-1.5,1.5]);
title('FSK�źŲ���');
xlabel('t/s');
ylabel('A/v');
% FSK�źŹ�����
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

%% fig 4 : ͨ��������ͨ�˲������ѵ��źż��书����
figure;
% ��Ԫ��0����Ӧ�Ĵ�ͨ�˲��� ʱ����
a_0 = [450 550];
Wp_0 = a_0/(fs/2);
b_0 = [350 650];
Ws_0 = b_0/(fs/2);
Rp = 3;
Rs = 40;
[N_But_0,Wn_0] = buttord(Wp_0,Ws_0,Rp,Rs,'s');
[B_0,A_0] = butter(N_But_0,Wn_0,'bandpass');
moudled_signal_bp_0 = filtfilt(B_0,A_0,moudled_signal_awgn);
subplot(4,1,1);
plot(t,moudled_signal_bp_0);
axis([0,t_max,-1.5,1.5]);
title(' ͨ����Ԫ0��Ӧ�Ĵ�ͨ�˲������ѵ��źŲ���');
xlabel('t/s');
ylabel('A/v');
% ͨ����Ԫ'0'��Ӧ�Ĵ�ͨ�˲������źŹ�����
[Pxx_bp_0,Pxxc_bp_0,f_bp_0] = pmtm(moudled_signal_bp_0,3.5,1024,fs,0.99);
hpsd_bp_0 = dspdata.psd(Pxx_bp_0,'Fs',fs);
subplot(4,1,2);
plot(hpsd_bp_0);
% ��Ԫ��1����Ӧ�Ĵ�ͨ�˲��� ʱ����
a_1 = [1450 1550];
Wp_1 = a_1/(fs/2);
b_1 = [1350 1650];
Ws_1 = b_1/(fs/2);
Rp = 3;
Rs = 40;
[N_But_1,Wn_1] = buttord(Wp_1,Ws_1,Rp,Rs,'s');
[B_1,A_1] = butter(N_But_1,Wn_1,'bandpass');
moudled_signal_bp_1 = filtfilt(B_1,A_1,moudled_signal_awgn);
subplot(4,1,3);
plot(t,moudled_signal_bp_1);
axis([0,t_max,-1.5,1.5]);
title(' ͨ����Ԫ1��Ӧ�Ĵ�ͨ�˲������ѵ��źŲ���');
xlabel('t/s');
ylabel('A/v');
% ͨ����Ԫ'1'��Ӧ�Ĵ�ͨ�˲������źŹ�����
[Pxx_bp_1,Pxxc_bp_1,f_bp_1] = pmtm(moudled_signal_bp_1,3.5,1024,fs,0.99);
hpsd_bp_1 = dspdata.psd(Pxx_bp_1,'Fs',fs);
subplot(4,1,4);
plot(hpsd_bp_1);

%% figure 5 ,��ɽ�����뱾���ز���˺�ͨ����ͨ�˲�������źŲ���
figure;
carrier_t_0_all = cos(2*pi*fc_0*t);
carrier_t_1_all = cos(2*pi*fc_1*t);
temp_t_0 = 2*moudled_signal_bp_0.*carrier_t_0_all;
temp_t_1 = 2*moudled_signal_bp_1.*carrier_t_1_all;
Wp = 110/(fs/2);
Ws = 1600/(fs/2);
Rp = 3;
Rs = 40;
[N_But,Wn] = buttord(Wp,Ws,Rp,Rs,'s');
[B,A] = butter(N_But,Wn,'low');
base_signal_r_0 = filtfilt(B,A,temp_t_0);
base_signal_r_1 = filtfilt(B,A,temp_t_1);
subplot(4,1,1);
plot(t,base_signal_r_0);
title(' ͨ����Ԫ0��Ӧ�Ĵ�ͨ�˲������ѵ��ź���ɽ��ͨ����ͨ�˲�����Ĳ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_base_r_0,Pxxc_base_r_0,f_base_r_0] = pmtm(base_signal_r_0,3.5,1024,fs,0.99);
hpsd_base_r_0 = dspdata.psd(Pxx_base_r_0,'Fs',fs);
subplot(4,1,2);
plot(hpsd_base_r_0);
subplot(4,1,3);
plot(t,base_signal_r_1);
title(' ͨ����Ԫ1��Ӧ�Ĵ�ͨ�˲������ѵ��ź���ɽ��ͨ����ͨ�˲�����Ĳ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_base_r_1,Pxxc_base_r_1,f_base_r_1] = pmtm(base_signal_r_1,3.5,1024,fs,0.99);
hpsd_base_r_1 = dspdata.psd(Pxx_base_r_1,'Fs',fs);
subplot(4,1,4);
plot(hpsd_base_r_1);

%% figure 6 , ��·�˲�������Ӳ�о������źŲ���
figure;
t_judge = N/2:N:length(bit)*(N-1)+N/2;
% ��Ԫ0
 base_judge_0 = [];
 for i = 1:length(t_judge)
    if base_signal_r_0(t_judge(i)) < 0.5
        bits = zeros(1,N);
    else 
        bits = ones(1,N);
    end   
    base_judge_0 = [base_judge_0,bits];
end;
subplot(4,1,1);
plot(t,base_judge_0);
axis([0,max(t)+dt,-0.2,1.2]);
title('��Ԫ0Ӳ�о����źŲ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_j_0,Pxxc_j_0,f_j_0] = pmtm(base_judge_0,3.5,1024,fs,0.99);
hpsd_j_0 = dspdata.psd(Pxx_j_0,'Fs',fs);
subplot(4,1,2);
plot(hpsd_j_0 );
% ��Ԫ1
 base_judge_1 = [];
 for i = 1:length(t_judge)
    if base_signal_r_1(t_judge(i)) < 0.5
        bits = zeros(1,N);
    else 
        bits = ones(1,N);
    end   
    base_judge_1 = [base_judge_1,bits];
end;
subplot(4,1,3);
plot(t,base_judge_1);
axis([0,max(t)+dt,-0.2,1.2]);
title('��Ԫ1Ӳ�о����źŲ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_j_1,Pxxc_j_1,f_j_1] = pmtm(base_judge_1,3.5,1024,fs,0.99);
hpsd_j_1 = dspdata.psd(Pxx_j_1,'Fs',fs);
subplot(4,1,4);
plot(hpsd_j_1 );

%% Fig 7 �ϳɺ��Ӳ�о�����źŲ���
figure;
base_judge = ([1-base_judge_0] + base_judge_1)/2;
subplot(2,1,1);
plot(t,base_judge);
axis([0,max(t)+dt,-0.2,1.2]);
title('�ϳɺ��Ӳ�о�����źŲ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_j,Pxxc_j,f_j] = pmtm(base_judge,3.5,1024,fs,0.99);
hpsd_j = dspdata.psd(Pxx_j,'Fs',fs);
subplot(2,1,2);
plot(hpsd_j );

%% figure 8 , Ӳ�о���Ĳ���������źŶԱ�
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