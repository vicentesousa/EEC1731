clear all
close all
clc
%% Parâmetros
fd=10;                              % frequency filter
ts=1e-6;                            % tempo de amostragem
fs = 1/ts;                          % taxa de amostragem

[Y_T, t] = ThirdOrderFilter(fd,ts);

% sinal em dB
Y_T_db=20.*log10(abs(Y_T));
% cálculo do RMS (Root Mean Square) do sinal
rms_Y_T=rms(abs(Y_T));                  % rms of output length = T

%% cálculo da magnitude da envoltoria complexa/RMS
Rho = abs(Y_T)/sqrt(rms_Y_T);
Rho_db=20*log10(Rho);
xRho = ceil(min(Rho_db))+1:floor(max(Rho_db))-1;

%% plot do sinal no domínio do tempo
plot(t,Rho_db,'k','LineWidth',1.5)
grid on
xlabel('Tempo (s)');
ylabel('Magnitude do Complexo da Envoltoria (dB/RMS)');
grid minor

%% cálculo do LCR e AFD 
for i=1:length(xRho)
    [LCR(i), AFD(i)]= CalculateLCRandAFD(Y_T_db,xRho(i),ts);
end

%% cálculo do LCR e AFD teórico (Rayleigh)
LCRt_norm=(sqrt(2*pi).*(10.^(xRho./10)).*exp(-10.^(xRho./20)));   
AFDt_norm=(exp(10.^(xRho./20))-1)./((sqrt(2*pi)).*(10.^(xRho./10)));

%% cálculo da frequência Doppler
fd_lcr = LCR./LCRt_norm;
fd_afd = AFDt_norm./AFD;

%% cálculo da velocidade
c = 3*10^8;                      % velocidade da luz
lambda = c/(fs/2);
% velocidade estimada
v_lcr = fd_lcr*lambda/3.6;
v_afd = fd_afd*lambda/3.6;
% velocidade teórica
v_teo = fd*lambda/3.6;
disp('A velocidade teórica, em km/h, é: ')
v_teo

%% Calcular melhores níveis
% para frequência Doppler
fd_erro_lcr = abs(fd_lcr - fd)/fd;
fd_erro_afd = abs(fd_afd - fd)/fd;
fd_idxbestRho_lcr=find(fd_erro_lcr==min(fd_erro_lcr));
fd_idxbestRho_afd=find(fd_erro_afd==min(fd_erro_afd));
fd_bestRho_lcr=fd_lcr(fd_idxbestRho_lcr);
fd_bestRho_afd=fd_afd(fd_idxbestRho_afd);
% para velocidade
v_erro_lcr = abs(v_lcr - v_teo)/v_teo;
v_erro_afd = abs(v_afd - v_teo)/v_teo;
v_idxbestRho_lcr=find(v_erro_lcr==min(v_erro_lcr));
v_idxbestRho_afd=find(v_erro_afd==min(v_erro_afd));
v_bestRho_lcr=v_lcr(v_idxbestRho_lcr);
v_bestRho_afd=v_afd(v_idxbestRho_afd);
%

%% % PLOTS
%% plot AFD
figure,semilogy(xRho,AFDt_norm,xRho,AFD,'LineWidth',1.5);
xlabel('Nível do sinal (dB/RMS)') 
ylabel('AFD (Comprimento de onda)') 
legend('AFD - Teórico (normalizado)','AFD - Medido')
grid on
%
%% plot LCR
figure,semilogy(xRho,LCRt_norm,xRho,LCR,'LineWidth',1.5)
xlabel('Nível do sinal (dB/RMS)') 
ylabel('LCR (Comprimento de onda)')
legend('LCR - Teórico (normalizado)','LCR - Medido')
grid on
%
%% plot frequência Doppler
figure,plot(xRho,fd_lcr,xRho,fd_afd,'LineWidth',1.5)
xlabel('Nível do sinal (dB/RMS)')
ylabel('Frequência Doppler (km/h)')
legend('LCR','AFD')
grid on
ylim([min(fd_lcr) max(fd_lcr)])
%
figure,plot(t,Rho_db,'k','LineWidth',1.5)
grid on
xlabel('Tempo (s)');
ylabel('Magnitude da envoltória complexa (dB/RMS)');
hold on
plot([t(1) t(end)],[xRho(fd_idxbestRho_lcr) xRho(fd_idxbestRho_lcr)],'-r','linewidth',1.5)
plot([t(1) t(end)],[xRho(fd_idxbestRho_afd) xRho(fd_idxbestRho_afd)],'--green','linewidth',1.5)
legend('\rho','Melhor nível - LCR','Melhor nível - AFD')
grid minor
hold off
%
figure,plot(xRho,fd_lcr,xRho,fd_afd,'LineWidth',1.5)
xlabel('Nível do sinal (dB/RMS)')
ylabel('Frequência Doppler (km/h)')
grid on
ylim([min(fd_lcr) max(fd_lcr)])
hold on
scatter(xRho(fd_idxbestRho_lcr),fd_bestRho_lcr,'filled','r')
scatter(xRho(fd_idxbestRho_afd),fd_bestRho_afd,'filled','g')
legend('LCR','AFD','Melhor ponto - LCR', 'Melhor ponto - AFD')
%
%% plot velocidade
% 
figure,plot(xRho,v_lcr,xRho,v_afd,'LineWidth',1.5)
xlabel('Nível do sinal (dB/RMS)')
ylabel('Velocidade (km/h)')
legend('Velocidade - LCR - Doppler','Velocidade - AFD - Doppler')
grid on
ylim([min(v_lcr) max(v_lcr)])
%
figure,plot(t,Rho_db,'k','LineWidth',1.5)
grid on
xlabel('Tempo (s)');
ylabel('Magnitude da envoltória complexa (dB/RMS)');
hold on
plot([t(1) t(end)],[xRho(v_idxbestRho_lcr) xRho(v_idxbestRho_lcr)],'-r','linewidth',1.5)
plot([t(1) t(end)],[xRho(v_idxbestRho_afd) xRho(v_idxbestRho_afd)],'--green','linewidth',1.5)
legend('\rho','Melhor nível - LCR','Melhor nível - AFD')
grid minor
hold off
%
figure,plot(xRho,v_lcr,xRho,v_afd,'LineWidth',1.5)
xlabel('Nível do sinal (dB/RMS)')
ylabel('Velocidade (km/h)')
grid on
ylim([min(v_lcr) max(v_lcr)])
hold on
scatter(xRho(v_idxbestRho_lcr),v_bestRho_lcr,'filled','r')
scatter(xRho(v_idxbestRho_afd),v_bestRho_afd,'filled','g')
legend('LCR','AFD','Melhor ponto - LCR', 'Melhor ponto - AFD')
%