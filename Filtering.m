fs = 1000;
T = 1/fs;
N = 1000; % desired length of signal
t = [0:N-1]*T; %time vector 
f2 = 8;  
x = sin(2*pi*f2*t);

%plot a noisy signal
x = x+ rand(size(x))*0.8;
%0.1 *sin(2*pi*1800*t);%(rand(1,length(x)));
subplot(3,3,1)
plot(t,x)
ylabel('Amplitude')
xlabel('Time (seconds)')
title('Noisy signal');



x_fft = abs(fft(x));
subplot(3,3,2);
plot(t,x_fft*2/N)
ylabel('Amplitude')
xlabel('bins')
title('Frequency Signal');

%low pass second order cut off .3 normalized frequency
[b a] = butter(2,0.3,'low')
%david dorran diagram generates a flow graph where a and b parameters are
%there

%plot frquency spectrum of filter
H = freqz(b,a,length(x));
hold on
plot(t,abs(H),'r')

xFilter = filter(b,a,x);
subplot(3,3,3);
plot(t,x)
