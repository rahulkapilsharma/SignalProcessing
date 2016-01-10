clear all;
close all;

fs = 500;
T = 1/fs;
N = 250; % desired length of signal
t = [0:N-1]*T; %time vector 
f1 = 8; f2=f1*2; 
%x = sin(2*pi*f1*t-pi/2) + sin(2*pi*f2*t);
x = sin(2*pi*f2*t);
subplot(3,1,1)
plot(t,x,'-b',t,x,'*r')

fs = 40;
T = 1/fs;
N = 20; % desired length of signal
t = [0:N-1]*T; %time vector 
x = sin(2*pi*f2*t);
subplot(3,1,2)
plot(t,x,'-b',t,x,'*r')

ylabel('Amplitude')
xlabel('Time (seconds)')
title('Synthesised Signal');