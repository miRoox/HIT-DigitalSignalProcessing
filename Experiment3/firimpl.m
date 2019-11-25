run('han33');
N=128;
n=1:N;
fs=64;
x1=sin(pi*n*6.4/fs); %% 0.1*pi
x2=sin(pi*n*9.6/fs); %% 0.15*pi
x3=sin(pi*n*28.8/fs); %% 0.45*pi
xn=x1+x2+x3;
% yn=filter(h,1,xn);
L=N*2;
xxn=fft(xn,L);
hh=fft(h,L);
yn=ifft(xxn.*hh ,L);

subplot(1,1,1);
plot(1:L,yn);
title('yn');
