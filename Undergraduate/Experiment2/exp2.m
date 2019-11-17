%% 信号滤波
%% 在 exp1-2.m 后运行
N=128;
n=1:N;
fs=64;
x1=sin(pi*n*6.4/fs); %% 0.1*pi
x2=sin(pi*n*9.6/fs); %% 0.15*pi
x3=sin(pi*n*28.8/fs); %% 0.45*pi
xn=x1+x2+x3;
yn=filter(Bz,Az,xn);

subplot(311);plot(xn);
title('xn');
axis([0 128 -3 3]);
subplot(312);plot(x1+x2);
title('x1+x2');
axis([0 128 -2 2]);
subplot(313);plot(yn);
title('yn');
axis([0 128 -2 2]);
