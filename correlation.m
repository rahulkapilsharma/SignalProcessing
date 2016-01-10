%simple correlatio
a = [.1 .2 .3 .4];
b = [.1 .2 .3 .4];
N= length(a);

meansure = sum(a.*b);
disp(['The correlation measurement is ', num2str(meansure)]);

%cross correlation
%two signals at different time lag position
%here we take lag 0 so sample 0 of x aligned with sample 0 of y
%so at zero lag
x= [.1 .2 .3 .4];
y= [.1 -.2 .3 -.4];
meansure = sum(x.*y);
disp(['The correlation measurement is ', num2str(meansure)]);

% at lag 1 
%trying different lags we try to find a correlation sequence w
x= [0 .1 .2 .3 .4];
y= [.1 .2 .3 .4];
meansure = xcorr(x,y);
disp(['The correlation measurement is ', num2str(meansure)]);

%xcorr can also return lag value
%.3 at time lag 1 
[meansure,lags] = xcorr(x,y);
disp(['The correlation measurement is ', num2str(meansure)]);
disp(['The correlation measurement is ', num2str(lags)]);
plot(lags,meansure)
xlabel('lags')
ylabel('meansure')

%normalised correaltion
%what if different signal are of different energy levels
x = [.1 .2 .3 .4];
y = [.1 .2 .3 .4];
z = [100 -.2 -.3 -.4];
meansure = sum(x.*y);
disp(['The correlation measurement is ', num2str(meansure)]);

%this should not be high as x and z not similiar
meansure = sum(x.*z);
disp(['The correlation measurement is ', num2str(meansure)]);

%lets normalize them divide correlation by some scaling factor
% normalized corr = num / sqrt(summationofxsquare * summationofysquared)
%Normalized: Maximum correlation is 1, Minimum is -1
xSquare = sum(x.*x);
ySquare = sum(y.*y);
zSquare = sum(z.*z);

denominatorXY = sqrt(xSquare.*ySquare);
denominatorXZ = sqrt(xSquare.*zSquare);

meansure = sum(x.*y);
meansure = meansure/denominatorXY;
disp(['The correlation measurement is ', num2str(meansure)]);

meansure = sum(x.*z);
meansure = meansure/denominatorXZ;
disp(['The correlation measurement is ', num2str(meansure)]);

%then why not use normalized always
% if you wanna know how strongly a sinusoid is present in one signal than
% other
t = [0:100-1]/100;
s1 = cos(2*pi*1*t);
s2 = cos(2*pi*4*t);

%signals
a = 2*s1 + s2;
b = 4*s1 + s2;

%so s1 is double in b
corr_standardA = sum(a.*s1);
corr_standardB = sum(b.*s1);

corr_normalizedA = corr_standardA/sqrt(sum(a.^2).*sum(s1.^2));
corr_normalizedB = corr_standardB/sqrt(sum(b.^2).*sum(s1.^2));
disp(['signal s1 in a ', num2str(corr_standardA)]);
disp(['signal s1 in b ', num2str(corr_standardB)]);
disp(['signal s1 in a normalized ', num2str(corr_normalizedA)]);
disp(['signal s1 in b normalized  ', num2str(corr_normalizedB)]);

% he correlation measurement is 0.3
% The correlation measurement is -0.1
% The correlation measurement is -3.1225e-17 -4.1633e-17        0.04        0.11         0.2         0.3         0.2        0.11        0.04
% The correlation measurement is -3.1225e-17 -4.1633e-17        0.04        0.11         0.2         0.3         0.2        0.11        0.04
% The correlation measurement is -4 -3 -2 -1  0  1  2  3  4
% The correlation measurement is 0.3
% The correlation measurement is 9.71
% The correlation measurement is 1
% The correlation measurement is 0.17728
% signal s1 in a 100
% signal s1 in b 200
% signal s1 in a normalized 0.89443
% signal s1 in b normalized  0.97014
