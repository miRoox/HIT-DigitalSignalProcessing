run('han33');
fs=64;
N=fs*100;
n=1:N;
x1=sin(pi*n*6.4/fs); %% 0.1*pi
x2=sin(pi*n*9.6/fs); %% 0.15*pi
x3=sin(pi*n*28.8/fs); %% 0.45*pi
xn=x1+x2+x3;
% yn=filter(h,1,xn);
L=128;
yn=zeros(1,N+L);
times=N/(L/2);
hh=fft(h,L);

for k = 0 : (times-1)
    xxt=fft(xn(1+k*L/2:L/2+k*L/2),L);
    yt=ifft(xxt.*hh ,L);
	yn(1+k*L/2:L+k*L/2)=yt+yn(1+k*L/2:L+k*L/2);
end

subplot(2,1,1);
plot(yn);
title('yn');
subplot(2,1,2);
plot(1:2*L,yn(1:2*L));
title('1~2L part of yn');
