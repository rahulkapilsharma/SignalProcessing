fs = 500;
T = 1/fs;
N = 250; % desired length of signal
t = [0:N-1]*T; %time vector 
f1 = 8; f2=f1*2; 
%x = sin(2*pi*f1*t-pi/2) + sin(2*pi*f2*t);
x = sin(2*pi*f2*t);
%adding noise
x = x+ 0.5 * rand(1, length(x));
subplot(3,3,1)
plot(t,x)

%adding noise on both positive and negative side
x = x+ 0.5 * 2*(rand(1,length(x))-.5);
subplot(3,3,2)
plot(t,x)
ylabel('Amplitude')
xlabel('Time (seconds)')
title('Noisy signal');

%can you five 1024 in fft function
%no only allows how many samples you used in input
%so here in input N=250 and fft function will also give 250 bins
xfft = abs(fft(x));
subplot(3,3,3)
plot(xfft)
title('Magnitude spectrum of the signal');
ylabel('Magnitude')
xlabel('DFT bins not hertz say bins')

%can you directly see the frequency of signal from plot 
% No because x axis is not in hertz but in bins
%to convert (frq(bins)) to freq(herts)
% your plot shows that there are 250 sample
% fs = 500 Hz
% the middle sample i.e. 125 (it represents fs/2)on plot represents 250 Hz
% similarly 62.5 represents 125 Hz and so on
%peek we see at betwwen 8 and 9 so roughly 16 Hz
%magnitude is around 127 which is roughly magOfSin* length(250)/2
% so to get magnitude abs(frquency bin)/length(signal)*2

%lets make x axis normalized
%just divide by length of FFT
subplot(3,3,4)
plot([0:1/(length(xfft)-1):1],xfft)
ylabel('Magnitude')
xlabel('Normalized DFT bins')

subplot(3,3,5)
freq_plot(x)
%Now lets try to remove noise