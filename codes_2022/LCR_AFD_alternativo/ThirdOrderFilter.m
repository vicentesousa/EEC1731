function [Y_T, t] = ThirdOrderFilter(fd,Ts,ts)
%% Parameters
t=0:ts:Ts;
zeta=0.175;                           % Underdamp  value for zeta
w0=2*pi*fd/1.2;                       % Natural angular frequency

%% Third order filter
% Coefficients
a=w0^3;
b=(2*zeta*w0)+w0;
c=(2*zeta*(w0^2))+(w0^2);

%% building third order Filter
syms f s w;                               % define symbols
tf_s=tf(a,[1 b c a]);                     % 3rd order tf in S domain
tf_z=c2d(tf_s,ts,'tustin');               % tustin: bilinear transformation

%% Impulse response of Digital Filter (channel)
[numZ, denZ, ts]=tfdata(tf_z,'v');
figure
[h] = impz(numZ,denZ);
%% find n0 : at this point h(n) become negligible
[pks,locs] = findpeaks(h);
nv=0.01;                  % negligible value  as a percentage of maximum value
b=find(pks>=(nv*max(pks)));
n0=max(locs(b));
%% normalizing the filter H(Z)
numZ_N=numZ./sqrt(sum(h.^2));      % normalize numerator of H(z)

%% Generating an input signal with unit power => (power_db = 0)
% Ip is vector (n0 ,1) , simulation time:T=0.1 sec
IP_no=(1/(sqrt(2))).*(randn(1,n0)+(1j*randn(1,n0)));
IP_T=(1/(sqrt(2))).*(randn(1,length(t))+(1j*randn(1,length(t))));
IP=[IP_no IP_T];                      % first n0 bits for transient response
% Output from filter
Y = filter(numZ_N,denZ,IP);              % output from filter
Y_T = Y(n0+1:end);                       % output after removing transients