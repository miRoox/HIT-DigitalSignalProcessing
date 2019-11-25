%% gb2312 encode
clear;
N=33; %%% 窗口长度
w=0.25*pi; %% 截止频率wc
n=0:N-1;
m=n-0.5*(N-1)+eps;
hd=sin(w*m)./(pi*m); %% 理想低通滤波器单位脉冲响应
figure;
subplot(2,3,1);
stem(n,hd);
axis([0 N-1 -0.1 0.3]);
hold on;
xlabel('n');
title('理想低通滤波器的hd(n)');
%B=boxcar(N); %%矩形窗
B=hanning(N); %%汉宁窗
%B=hamming(N); %%海明窗
%B=blackman(N); %%布莱克曼窗
subplot(2,3,4);
stem(n,B);
axis([0 N-1 0 1]);
hold on;
xlabel('n');
title('窗函数w(n)');
string=['N=',num2str(N)];
h=hd.*(B)'; %% 得到FIR数字滤波器(理想滤波器乘以窗函数)
subplot(2,3,2);
n=0:N-1;
stem(n,h,'.');
axis([0 N-1 -0.1 0.3]);
hold on;
xlabel('n');
title('实际低通滤波器的h(n)');
text((0.3*N),0.27,string);
[H,W]=freqz(h,1,100); %% 求其频响
mag=abs(H);
db=20*log10(mag/max(mag)); %% 增益(dB)
mag=mag/mag(1); %% 得到归一化幅值特性
pha=angle(H); %% 得到相位
subplot(2,3,3);
plot(W/pi,db);
axis([0 1 -100 0]);
title('幅频特性-增益(dB)');
xlabel('w/pi');
grid;
subplot(2,3,5);
plot(W/pi,pha);
hold on;
title('相频特性');
xlabel('w/pi');
axis([0 1 -4 4]);
subplot(2,3,6);
plot(W/pi,mag);
axis([0 1 0 1.5]);
title('幅频特性');
xlabel('w/pi');
grid;