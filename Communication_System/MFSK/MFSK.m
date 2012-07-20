clc;
clear;
close all;


fc_3 = 1800;
fc_2 = 1300;
fc_1 = 800;
fc_0 = 300;
Rs = 100;
N = 50;
fs=N*Rs;
bit = [3 3 0 2 2 3 3 3 1 0];

%% fig 1 : ���������źż��书����
% �����źŲ���
figure;
dt = 1/Rs/N;
t = 0:dt:length(bit)/Rs-dt;
t_max = max(t)+dt;
base_signal_t = [];
for i = 1:length(bit)
    bits = bit(i)*ones(1,N);
    base_signal_t = [base_signal_t,bits];
end
subplot(2,1,1);
plot(t,base_signal_t);
grid on;
axis([0,max(t)+dt,-0.5,3.5]);
title('�����źŲ���');
xlabel('t/s');
ylabel('A/v');
% �����źŹ�����
[Pxx_t,Pxxc_t,f_t] = pmtm(base_signal_t,3.5,1024,fs,0.99);
hpsd_t = dspdata.psd(Pxx_t,'Fs',fs);
subplot(2,1,2);
plot(hpsd_t);

%% fig 2 : ����4FSK�źż��书����
figure;
t_seg = 0:dt:1/Rs-dt;
carrier_t_0 = sin(2*pi*fc_0*t_seg);
carrier_t_1 = sin(2*pi*fc_1*t_seg);
carrier_t_2 = sin(2*pi*fc_2*t_seg);
carrier_t_3 = sin(2*pi*fc_3*t_seg);
moudled_signal = [];
% ����
for i = 1:length(bit)
    if bit(i) == 0        
        bits = ones(1,N).*carrier_t_0;
    elseif bit(i) == 1
        bits = ones(1,N).*carrier_t_1;
    elseif bit(i) == 2
        bits = ones(1,N).*carrier_t_2;
    else
        bits = ones(1,N).*carrier_t_3;
    end 
    moudled_signal = [moudled_signal,bits];
end
subplot(2,1,1);
plot(t,moudled_signal);
grid on;
axis([0,max(t)+dt,-1.5,1.5]);
title('���ƺ��źŲ���');
xlabel('t/s');
ylabel('A/v');
% 4ASK�źŹ�����
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

%% fig 4 : ͨ��4����ͨ�˲������ѵ��źż��书����
figure;
% ��Ԫ��0����Ӧ�Ĵ�ͨ�˲��� ʱ����
a_0 = [fc_0-50 fc_0+50];
Wp_0 = a_0/(fs/2);
b_0 = [fc_0-100 fc_0+100];
Ws_0 = b_0/(fs/2);
Rp = 3;
Rs = 40;
[N_But_0,Wn_0] = buttord(Wp_0,Ws_0,Rp,Rs,'s');
[B_0,A_0] = butter(N_But_0,Wn_0,'bandpass');
moudled_signal_bp_0 = filtfilt(B_0,A_0,moudled_signal_awgn);
subplot(4,2,1);
plot(t,moudled_signal_bp_0);
axis([0,t_max,-1.5,1.5]);
title(' ͨ����Ԫ0��Ӧ�Ĵ�ͨ�˲������ѵ��źŲ���');
xlabel('t/s');
ylabel('A/v');
% ͨ����Ԫ'0'��Ӧ�Ĵ�ͨ�˲������źŹ�����
[Pxx_bp_0,Pxxc_bp_0,f_bp_0] = pmtm(moudled_signal_bp_0,3.5,1024,fs,0.99);
hpsd_bp_0 = dspdata.psd(Pxx_bp_0,'Fs',fs);
subplot(4,2,2);
plot(hpsd_bp_0);
% ��Ԫ��1����Ӧ�Ĵ�ͨ�˲��� ʱ����
a_1 = [fc_1-50 fc_1+50];
Wp_1 = a_1/(fs/2);
b_1 = [fc_1-100 fc_1+100];
Ws_1 = b_1/(fs/2);
Rp = 3;
Rs = 40;
[N_But_1,Wn_1] = buttord(Wp_1,Ws_1,Rp,Rs,'s');
[B_1,A_1] = butter(N_But_1,Wn_1,'bandpass');
moudled_signal_bp_1 = filtfilt(B_1,A_1,moudled_signal_awgn);
subplot(4,2,3);
plot(t,moudled_signal_bp_1);
axis([0,t_max,-1.5,1.5]);
title(' ͨ����Ԫ1��Ӧ�Ĵ�ͨ�˲������ѵ��źŲ���');
xlabel('t/s');
ylabel('A/v');
% ͨ����Ԫ'1'��Ӧ�Ĵ�ͨ�˲������źŹ�����
[Pxx_bp_1,Pxxc_bp_1,f_bp_1] = pmtm(moudled_signal_bp_1,3.5,1024,fs,0.99);
hpsd_bp_1 = dspdata.psd(Pxx_bp_1,'Fs',fs);
subplot(4,2,4);
plot(hpsd_bp_1);
% ��Ԫ��2����Ӧ�Ĵ�ͨ�˲��� ʱ����
a_2 = [fc_2-50 fc_2+50];
Wp_2 = a_2/(fs/2);
b_2 = [fc_2-100 fc_2+100];
Ws_2 = b_2/(fs/2);
Rp = 2;
Rs = 40;
[N_But_2,Wn_2] = buttord(Wp_2,Ws_2,Rp,Rs,'s');
[B_2,A_2] = butter(N_But_2,Wn_2,'bandpass');
moudled_signal_bp_2 = filtfilt(B_2,A_2,moudled_signal_awgn);
subplot(4,2,5);
plot(t,moudled_signal_bp_2);
axis([0,t_max,-1.5,1.5]);
title(' ͨ����Ԫ2��Ӧ�Ĵ�ͨ�˲������ѵ��źŲ���');
xlabel('t/s');
ylabel('A/v');
% ͨ����Ԫ'2'��Ӧ�Ĵ�ͨ�˲������źŹ�����
[Pxx_bp_2,Pxxc_bp_2,f_bp_2] = pmtm(moudled_signal_bp_2,3.5,1024,fs,0.99);
hpsd_bp_2 = dspdata.psd(Pxx_bp_2,'Fs',fs);
subplot(4,2,6);
plot(hpsd_bp_2);
% ��Ԫ��3����Ӧ�Ĵ�ͨ�˲��� ʱ����
a_3 = [fc_3-50 fc_3+50];
Wp_3 = a_3/(fs/2);
b_3 = [fc_3-100 fc_3+100];
Ws_3 = b_3/(fs/2);
Rp = 3;
Rs = 40;
[N_But_3,Wn_3] = buttord(Wp_3,Ws_3,Rp,Rs,'s');
[B_3,A_3] = butter(N_But_3,Wn_3,'bandpass');
moudled_signal_bp_3 = filtfilt(B_3,A_3,moudled_signal_awgn);
subplot(4,2,7);
plot(t,moudled_signal_bp_3);
axis([0,t_max,-1.5,1.5]);
title(' ͨ����Ԫ3��Ӧ�Ĵ�ͨ�˲������ѵ��źŲ���');
xlabel('t/s');
ylabel('A/v');
% ͨ����Ԫ'3'��Ӧ�Ĵ�ͨ�˲������źŹ�����
[Pxx_bp_3,Pxxc_bp_3,f_bp_3] = pmtm(moudled_signal_bp_3,3.5,1024,fs,0.99);
hpsd_bp_3 = dspdata.psd(Pxx_bp_3,'Fs',fs);
subplot(4,2,8);
plot(hpsd_bp_3);

%% figure 5 ,��ɽ�����뱾���ز���˺�ͨ����ͨ�˲�������źŲ���
figure;
carrier_t_0_all = sin(2*pi*fc_0*t);
carrier_t_1_all = sin(2*pi*fc_1*t);
carrier_t_2_all = sin(2*pi*fc_2*t);
carrier_t_3_all = sin(2*pi*fc_3*t);
% carrier_t_0_all = [];
% carrier_t_1_all = [];
% carrier_t_2_all = [];
% carrier_t_3_all = [];
% for i = 1:length(bit)
%     carrier_t_0_all = [carrier_t_0_all,carrier_t_0];
%     carrier_t_1_all = [carrier_t_1_all,carrier_t_1];
%     carrier_t_2_all = [carrier_t_2_all,carrier_t_2];
%     carrier_t_3_all = [carrier_t_3_all,carrier_t_3];
% end
temp_t_0 = 2*moudled_signal_bp_0.*carrier_t_0_all;
temp_t_1 = 2*moudled_signal_bp_1.*carrier_t_1_all;
temp_t_2 = 2*moudled_signal_bp_2.*carrier_t_2_all;
temp_t_3 = 2*moudled_signal_bp_3.*carrier_t_3_all;
Wp = 110/(fs/2);
Ws = 200/(fs/2);
Rp = 1;
Rs = 40;
[N_But,Wn] = buttord(Wp,Ws,Rp,Rs,'s');
[B,A] = butter(N_But,Wn,'low');
base_signal_r_0 = filtfilt(B,A,temp_t_0);
base_signal_r_1 = filtfilt(B,A,temp_t_1);
base_signal_r_2 = filtfilt(B,A,temp_t_2);
base_signal_r_3 = filtfilt(B,A,temp_t_3);
% plot 0
subplot(4,2,1);
plot(t,base_signal_r_0);
grid on;
title(' ͨ����Ԫ0��Ӧ�Ĵ�ͨ�˲������ѵ��ź���ɽ��ͨ����ͨ�˲�����Ĳ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_base_r_0,Pxxc_base_r_0,f_base_r_0] = pmtm(base_signal_r_0,3.5,1024,fs,0.99);
hpsd_base_r_0 = dspdata.psd(Pxx_base_r_0,'Fs',fs);
subplot(4,2,2);
plot(hpsd_base_r_0);
% plot 1
subplot(4,2,3);
plot(t,base_signal_r_1);
grid on;
title(' ͨ����Ԫ1��Ӧ�Ĵ�ͨ�˲������ѵ��ź���ɽ��ͨ����ͨ�˲�����Ĳ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_base_r_1,Pxxc_base_r_1,f_base_r_1] = pmtm(base_signal_r_1,3.5,1024,fs,0.99);
hpsd_base_r_1 = dspdata.psd(Pxx_base_r_1,'Fs',fs);
subplot(4,2,4);
plot(hpsd_base_r_1);
% plot 2
subplot(4,2,5);
plot(t,base_signal_r_2);
grid on;
title(' ͨ����Ԫ2��Ӧ�Ĵ�ͨ�˲������ѵ��ź���ɽ��ͨ����ͨ�˲�����Ĳ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_base_r_2,Pxxc_base_r_2,f_base_r_2] = pmtm(base_signal_r_2,3.5,1024,fs,0.99);
hpsd_base_r_2 = dspdata.psd(Pxx_base_r_2,'Fs',fs);
subplot(4,2,6);
plot(hpsd_base_r_2);
% plot 3
subplot(4,2,7);
plot(t,base_signal_r_3);
grid on;
title(' ͨ����Ԫ3��Ӧ�Ĵ�ͨ�˲������ѵ��ź���ɽ��ͨ����ͨ�˲�����Ĳ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_base_r_3,Pxxc_base_r_3,f_base_r_3] = pmtm(base_signal_r_3,3.5,1024,fs,0.99);
hpsd_base_r_3 = dspdata.psd(Pxx_base_r_3,'Fs',fs);
subplot(4,2,8);
plot(hpsd_base_r_3);

%% figure 6 , 4·�˲�������Ӳ�о������źŲ���
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
subplot(4,2,1);
plot(t,base_judge_0);
axis([0,max(t)+dt,-0.2,1.2]);
title('��Ԫ0Ӳ�о����źŲ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_j_0,Pxxc_j_0,f_j_0] = pmtm(base_judge_0,3.5,1024,fs,0.99);
hpsd_j_0 = dspdata.psd(Pxx_j_0,'Fs',fs);
subplot(4,2,2);
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
subplot(4,2,3);
plot(t,base_judge_1);
axis([0,max(t)+dt,-0.2,1.2]);
title('��Ԫ1Ӳ�о����źŲ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_j_1,Pxxc_j_1,f_j_1] = pmtm(base_judge_1,3.5,1024,fs,0.99);
hpsd_j_1 = dspdata.psd(Pxx_j_1,'Fs',fs);
subplot(4,2,4);
plot(hpsd_j_1 );
% ��Ԫ2
 base_judge_2 = [];
 for i = 1:length(t_judge)
    if base_signal_r_2(t_judge(i)) < 0.5
        bits = zeros(1,N);
    else 
        bits = ones(1,N);
    end   
    base_judge_2 = [base_judge_2,bits];
end;
subplot(4,2,5);
plot(t,base_judge_2);
axis([0,max(t)+dt,-0.2,1.2]);
title('��Ԫ2Ӳ�о����źŲ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_j_2,Pxxc_j_2,f_j_2] = pmtm(base_judge_2,3.5,1024,fs,0.99);
hpsd_j_2 = dspdata.psd(Pxx_j_2,'Fs',fs);
subplot(4,2,6);
plot(hpsd_j_2 );
% ��Ԫ3
 base_judge_3 = [];
 for i = 1:length(t_judge)
    if base_signal_r_3(t_judge(i)) < 0.5
        bits = zeros(1,N);
    else 
        bits = ones(1,N);
    end   
    base_judge_3 = [base_judge_3,bits];
end;
subplot(4,2,7);
plot(t,base_judge_3);
axis([0,max(t)+dt,-0.2,1.2]);
title('��Ԫ3Ӳ�о����źŲ���');
xlabel('t/s');
ylabel('A/v');
[Pxx_j_3,Pxxc_j_3,f_j_3] = pmtm(base_judge_3,3.5,1024,fs,0.99);
hpsd_j_3 = dspdata.psd(Pxx_j_3,'Fs',fs);
subplot(4,2,8);
plot(hpsd_j_3 );

%% Fig 7 �ϳɺ��Ӳ�о�����źŲ���
figure;
base_judge = 0*base_judge_0 + 1*base_judge_1+2*base_judge_2+3*base_judge_3;
subplot(2,1,1);
plot(t,base_judge);
grid on;
axis([0,max(t)+dt,-0.5,3.5]);
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
grid on;
axis([0,max(t)+dt,-0.5,3.5]);
title('�����źŲ���');
xlabel('t/s');
ylabel('A/v');
subplot(2,1,2);
plot(t,base_judge);
grid on;
axis([0,max(t)+dt,-0.5,3.5]);
title('Ӳ�о����źŲ���');
xlabel('t/s');
ylabel('A/v');