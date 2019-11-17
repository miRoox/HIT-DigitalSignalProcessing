%% 滤波器的实现
%% 在 exp1-2.m 后运行
N1=128;
n=1:N1;
fs=64;
x1=sin(pi*n*6.4/fs);
x2=sin(pi*n*9.6/fs);
x3=sin(pi*n*28.8/fs);
xn=x1+x2+x3;

yn=zeros(1,N1);
for n=7:N1
    for i=0:6
        yn(n)=yn(n)+Bz(i+1)*xn(n-i);
    end
    for k=1:6
        yn(n)=yn(n)-Az(k+1)*yn(n-k);
    end
end

subplot(311);plot(xn);
title('xn');
axis([0 N1 -3 3]);
subplot(312);plot(x1+x2);
title('x1+x2');
axis([0 N1 -2 2]);
subplot(313);plot(yn);
title('yn');
axis([0 N1 -2 2]);
