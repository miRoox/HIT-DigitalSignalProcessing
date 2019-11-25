%% 冲激响应不变法
clc;clear;
T=1;
Wp=0.2*pi/T; Rp=1; %指标变换
Ws=0.3*pi/T;  Rs=15;
[N,Wc]=buttord(Wp,Ws,Rp,Rs,'s');  %%计算巴特沃斯滤波器阶数 N 和Ωc
Wc = Wp / ( (10^(.1*abs(Rp)) - 1)^(1/(2*N)) );  %%阻带留余量(函数通带留余量)
[z,p,k]=buttap(N);  %%计算模拟滤波器原型
[Bp,Ap]=zp2tf(z,p,k);  %%得到归一化函数 Ha(p)的系数
[Bs,As]=lp2lp(Bp,Ap,Wc);  %%解归一化得模拟滤波器传递函数 Ha(s)
[Bz,Az]=impinvar(Bs,As,1/T);  %%Ha(s)－>H(z)求数字滤波器系统函数 H(z)
%% 以上系数都是 p,s,z 的降序排列

[H,W]=freqz(Bz,Az);
Hf=abs(H);
subplot(211);
plot(W/pi,Hf);
title('Amplitude response');
xlabel('w/pi');
subplot(212);
plot(W/pi,20*log10(Hf));
title('Gain curve');
xlabel('w/pi');
axis([0 1 -100 0]);
