%Gerando a função do modelo (Clark/Gan) FWGN
function [h,Nfft,Nifft,doppler_coeff]=FWGN_model(fm,fs,N)
% Input: fm= Maximum Doppler frquency
% fs= Sampling frequency, N = Number of samples
% Output: h = Complex fading channel
Nfft = 2^max(3,nextpow2(2*fm/fs*N)); % Nfft=2^n
Nifft = ceil(Nfft*fs/(2*fm));
% Gera o processo aleatório Gaussiano complexo independente
% Generate the independent complex Gaussian random process
GI = randn(1,Nfft); 
GQ = randn(1,Nfft);
% Tirar FFT do sinal real para tornar o hermitiano simétrico
% Take FFT of real signal in order to make hermitian symmetric
CGI = fft(GI); 
CGQ = fft(GQ);
% de geração de espectro Doppler de amostra Nfft
% Nfft sample Doppler spectrum generation
doppler_coeff = Doppler_spectrum(fm,Nfft);
% Faça a filtragem das variáveis aleatórias gaussianas aqui
% Do the filtering of the Gaussian random variables here
f_CGI = CGI.*sqrt(doppler_coeff);
f_CGQ = CGQ.*sqrt(doppler_coeff);
% Ajuste o tamanho da amostra para obter IFFT por (Nifft-Nfft) preenchimento zero da amostra
% Adjust sample size to take IFFT by (Nifft-Nfft) sample zero-padding
Filtered_CGI=[f_CGI(1:Nfft/2) zeros(1,Nifft-Nfft) f_CGI(Nfft/2+1:Nfft)];
Filtered_CGQ=[f_CGQ(1:Nfft/2) zeros(1,Nifft-Nfft) f_CGQ(Nfft/2+1:Nfft)];
hI = ifft(Filtered_CGI); 
hQ= ifft(Filtered_CGQ);
% Take the magnitude squared of the I and Q components and add them
rayEnvelope = sqrt(abs(hI).^2 + abs(hQ).^2);
% Compute the root mean squared value and normalize the envelope
rayRMS = sqrt(mean(rayEnvelope(1:N).*rayEnvelope(1:N)));
h = complex(real(hI(1:N)),-real(hQ(1:N)))/rayRMS;