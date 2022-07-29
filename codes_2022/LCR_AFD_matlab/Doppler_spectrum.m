%Gerando o Doppler
function y=Doppler_spectrum(fd,Nfft)
% fd = Maximum Doppler frequency
% Nfft= Número de pontos no domínio de frequência
df = 2*fd/Nfft; % Espaçamento entre frequências
% DC primeira componente
f(1) = 0; y(1) = 1.5/(pi*fd);
% Os outros componentes para um lado do espectro
for i = 2:Nfft/2
f(i)=(i-1)*df; % Índices de frequência para ajuste polinomial
y([i Nfft-i+2]) = 1.5/(pi*fd*sqrt(1-(f(i)/fd)^2));
end
% Ajuste polinomial aplicado à frequência de Nyquist usando as últimas 3 amostras
nFitPoints=3 ; 
kk=[Nfft/2-nFitPoints:Nfft/2];
polyFreq = polyfit(f(kk),y(kk),nFitPoints);
y((Nfft/2)+1) = polyval(polyFreq,f(Nfft/2)+df);