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
%general fundamental frq = bin*fs/N; 
%lets make x axis normalized
%just divide by length of FFT
subplot(3,3,4)
plot([0:1/(length(xfft)-1):1],xfft)
ylabel('Magnitude')
xlabel('Normalized DFT bins')

subplot(3,3,5)
freq_plot(x)

%we added noise lets see later how to remove it
%first lets see how to use windowing etc
%what happen if number of cycles are not interger multiple
%circular property of DFT no more holds TODO study it.
fs =1000
t=0:1/fs:1-1/fs;
f1 = 2;
x1 = 0.5*cos(2*pi*f1*t);
subplot(2,2,1)
plot(x1)
xlabel('samples');
ylabel('amplitude');

X1=fft(x1);
subplot(2,2,2)
plot(abs(X1))
xlabel('bins');
ylabel('magnitude');

% upper case if you see plot sinusoid exactly 2 cycles
%and freq is perfect two peaks of 250
%lets add half cycle
f1 = 2.5;
x1 = 0.5*cos(2*pi*f1*t);
x1=x1.*hanning(length(x1))'; %hanning gives column convert to row, to
%remove side lobes

%by zero padding we tell DFT to correlate the signal with more basis 
%that have more integer cycles making DFT greater opportunity to  get 
%exact match between signal anaylsed and basis function 
%thats how magnitude increased to real value
x1 = [x1 zeros(1,11000)] 
subplot(2,2,1)
plot(x1)
xlabel('samples');
ylabel('amplitude');

X1=fft(x1);
subplot(2,2,2)
plot(abs(X1))
xlabel('bins');
ylabel('magnitude');
%now 2.5 cycles peak is not perfect even see magnitude it is incorrect it
%is reduced a bit or to say there is spread of spectral energy, energy on
%multiple bins (why energy ibetween 2 and 3 ? asthis sinu lies between sin
%with 3 cycles and sin with 2 cycles )

%pad it take random but large number of zeros (if you dont know exact
%frequency resolution) %enable line 77

%magnitude has corrected itself it is 250 again...
%zoom it (with zeros added you will) there are side lobes
%  now use hanning window to reduce side lobs (line 76)
%hanning
figure;
x1 = 0.5*cos(2*pi*f1*t);

hanwin = hanning(1000);%same length of signal
%green(original) * blue(hanning) = result (red)
plot(hanwin,'-b')
hold on
plot(x1,'g')
hold on
x1=x1.*hanning(length(x1))'; %hanning gives column convert to row
plot(x1,'r')

% enable 76 and 77 you will see sidelobes reduced
% but magnitude becomes 125 which was corrected by zero padding
% when ever use hanning window do following
% to get amplitude when in hanning window general rule
%at bin 30 (31) amplitude is 125
% 1000 is length
ampl = abs(X1(31))/(1000/4); % 0.5 which is correct
ang = angle(X1(31)) %add 0.2 in phase and you will get it


%in this example frequency = bin number
%to get original frequency
freq = 30 * 1000/12000;%divide by total bins  2.5





%% WHAT IF TWO SINUSOIDS
% YOU WILL GET TWO BELL SHAPES
%% ADD AND SEE IF YOU GET EXACT AMPLITUDE WITH ABOVE PROCEDURE
% HOW dft IS CALCULATED 
% SUPPOSE A RANDOM SIGNAL IS THERE (BY FOUREIR SERIES IT IS SUM OF VARIOUS)
% SINUSOIDAL SIGNALS. tO COMPUTE dft FIRST TAKE BASIS FUNCTION - SINUOIDAL SIN
% AND SINUSOIDAL COSINE ARE TWO BASIS FUNCTION
% assumption is there are only integer multiple cycles
% like for X[1] i.e bin number one, we will correlate with cosine having one 
% cycle in given interval. (this is a). correlating our signal with sin having
% one cycle gives b (X[1] = a+ib)
% going ahead for X[2] take basis sinusoidal functional with two cycles in 
%interval.........signals and basis functions with different cycles are 
%continuouslt correlated to calcuate n bins where n bins are lenagth of
%signal

%dude what about bin 0 X[0] (zero cycle in basis function??) it should be
%constant
%here zero frequency basis function is used take average amplitude of the
%signal
% X[k] = summation (x[n] * exp (-j w_k n)) where  w_k = 2*pi*k/N
% if you see x[n] * cosine (corrrelation result)  + x[n] * sin (corr result)

% cos (2*pi*k(which is2)/N) % so 2 cycles over N samples
% so all diff cosine and sine functions are analysis basis functions
% correlation produces a non zero values if signal you are analysing
% contains the basis function for all others it gives zero (as equal
%number of positive and negative which cancels out)

% try to understand when we used non integer in windowing (this cancelling)
%out doesn;t happen as all basis functions are integer multiple of cycles
%hence and some bins other than target bin contain some 
%energy

%frequency resolution
%difference between different DFT bins given by fs/N
%this can be source of error like some places you need better frequency 
%resolution so increase N. It is needed in audio applications
%what about increasing accuracy by just zzero padding and not increasing N?
%by taking longer TD segments we can extract more frequency information
%we can do it by extending TD  by adding zeross
%better to take more time domain signal because in zero padding , when in
%real there may be sidelobes, you will be sseing a merged and think there
%is only one signal
%All lower resolution DFTs are actually sampled version of higher
%resolution DFTs
%what about only one sample ? zero pad it :p
%frequency is rate of change with 1 sample , no rate of change
%pointer fft operation works well when N = 2^k

%search zero padding vs windowing
%zero padding is rectangular window
