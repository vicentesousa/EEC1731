function [vtDist, vtSlowFadMod, vtPathLossMod, vtShadMod, vtFastFadMod, vtPrx] = fGeraCanal(sPar)
% Parser dos parâmetros de entrada
fc = sPar.fc;                      % Frequência da Portadora  
totalLength = sPar.totalLength;    % Distância final da rota de medição (m)
d0 = sPar.d0;                      % distância de referência (m)
nPoints = sPar.nPoints;            % Número de amostras da rota de medição
dMed = (totalLength-d0)/(nPoints-1);   % Distância entre pontos de medição (m)
p0 = sPar.P0;                      % Potência medida na distância de referência d0 (dBm)
n = sPar.n;                        % Expoente de perda de percurso
sigmaShad = sPar.sigmaShad;        % Desvio padrão do shadowing em dB
nSampShadW = ceil(sPar.nSampShadW); % Tamanho da janela de correlação do shadowing
txPower = sPar.txPower;            % Potência de transmissão (dBm)
pdftype = sPar.pdftype;            % Tipo de pdf (Nakagami, Rician, Rayleigh, Weibull)
s1 = sPar.p;                       % Parâmetro "sigma 1" da pdf Rician
s2 = s1;                           % Parâmetro "sigma 2" da pdf Rician
sigma = sPar.p;                    % Parâmetro "sigma" da pdf Rayleigh
m = sPar.p;                        % Parâmetro "m" da pdf Nakagami
a = sPar.p;                        % Parâmetro "a" da pdf Weibull
b = sPar.b;                        % Parâmetro "b" da pdf Weibull

% Vetor de distância das medições em relação ao transmissor
vtDist = d0:dMed:totalLength;
nSamples = length(vtDist);

% Geração da Perda de percurso (determinística)
% Modelo COST 231 Considerando visada direta (LOS)
vtPathLossMod = p0 + (42.6 + 26.*log10(vtDist./d0) + 20.*log10(fc)); 

% Geração do Sombreamento
nShadowSamples = floor(nSamples/nSampShadW)+1;
shadowing = sigmaShad*randn(1,nShadowSamples);
% Amostras para a última janela
restShadowing = sigmaShad*randn(1,1)*ones(1,mod(nSamples,nSampShadW));
% Repetição do mesmo valor de sombreamento durante a janela de correlação
shadowing = ones(nSampShadW,1)*shadowing;
% Amostras organizadas em um vetor
shadowing = [reshape(shadowing,1,nShadowSamples*nSampShadW),restShadowing];
% Filtragem para evitar variação abrupta do sombreamento
jan = nSampShadW/2;
iCont = 1;
for i = jan+1:nSamples+nSampShadW-jan
    vtShadMod(iCont) = mean(shadowing(i-jan:i+jan)); %diminuir a variação brusca do sombreamento
    iCont = iCont+1;
end
% Ajuste do desvio padrão depois do filtro de correlação do sombreamento
vtShadMod = vtShadMod*std(shadowing)/std(vtShadMod);
vtShadMod = vtShadMod - mean(vtShadMod)+ mean(shadowing);

% Geração do desvanecimento de pequena escala
switch pdftype
    case 'Nakagami'
        pdfEquation = @(x)((2.*m.^m)./(gamma(m))).*x.^(2.*m-1).*exp(-(m.*x.^2));
    case 'Rayleigh'
        pdfEquation = @(x) (x./sigma.^2).*exp((-x.^2)/(2.*(sigma.^2)));
    case 'Weibull'
       % pdfEquation = ;
    case 'Rician'
        pdfEquation = @(x) (x ./ (s1.^2)) .*exp(-0.5 * (x.^2 + s2.^2) ./ ...
                      (s1.^2)) .*besseli(0, x .* s2 ./ (s1.^2));
end
normEnvelope = slicesample(1,nSamples,'pdf',pdfEquation);
vtFastFadMod=20.*log10(normEnvelope');

% Cálculo da Potência recebida
txPower = txPower*ones(1,nSamples);
vtPrx = txPower-vtPathLossMod+vtShadMod+vtFastFadMod; % Potência recebida
vtSlowFadMod = txPower-vtPathLossMod+vtShadMod; % Desvanecimento de Larga Escala

% Salva variáveis do canal no Matlab
save([sPar.chFileName '.mat'],'vtDist', 'vtSlowFadMod', 'vtPathLossMod', 'vtShadMod', 'vtFastFadMod', 'vtPrx');