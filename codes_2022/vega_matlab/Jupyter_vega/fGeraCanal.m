function [vtDist, vtPathLoss, vtShad, vtFastFading, vtPrxdBm] = fGeraCanal(sPar)

% Parser dos par�metros de entrada
fc = sPar.fc;                      % Frequ�ncia da Portadora  
totalLength = sPar.totalLength;    % Dist�ncia final da rota de medi��o (m)
d0 = sPar.d0;                      % dist�ncia de refer�ncia d0 (m)
nPoints = sPar.nPoints;            % N�mero de amostras da rota de medi��o
dMed = (totalLength-d0)/(nPoints-1);   % Dist�ncia entre pontos de medi��o (m)
p0 = sPar.P0;                      % Pot�ncia medida na dist�ncia de refer�ncia d0 (em dBm)
n = sPar.n;                        % Expoente de perda de percurso
sigmaShad = sPar.sigmaShad;        % Desvio padr�o do shadowing em dB
nSampShadW = ceil(sPar.nSampShadW); % Tamanho da janela de correla��o do shadowing
txPower = sPar.txPower;            % Pot�ncia de transmiss�o (dBm)
pdftype = sPar.pdftype;            % Tipo de pdf (Nakagami, Rician, Rayleigh, Weibull)
s1 = sPar.p;                       % Par�metro "sigma 1" da pdf Rician
s2 = s1;                           % Par�metro "sigma 2" da pdf Rician
sigma = sPar.p;                    % Par�metro "sigma" da pdf Rayleigh
m = sPar.p;                        % Par�metro "m" da pdf Nakagami
a = sPar.p;                        % Par�metro "a" da pdf Weibull
b = sPar.b;                        % Par�metro "b" da pdf Weibull

% Vetor de dist�ncia das medi��es em rela��o ao transmissor
vtDist = d0:dMed:totalLength;
nSamples = length(vtDist);

% Gera��o da Perda de percurso (determin�stica)
vtPathLoss = p0 + (42.6 + 26.*log10(vtDist./d0) + 20.*log10(fc)); % Modelo COST 231 Considerando visada direta (LOS)
%vtPathLoss = p0 + 10*n*log10(vtDist./d0);

% Gera��o do Sombreamento
nShadowSamples = floor(nSamples/nSampShadW)+1;
shadowing = sigmaShad*randn(1,nShadowSamples);
% Amostras para a �ltima janela
restShadowing = sigmaShad*randn(1,1)*ones(1,mod(nSamples,nSampShadW));
% Repeti��o do mesmo valor de sombreamento durante a janela de correla��o
shadowing = ones(nSampShadW,1)*shadowing;
% Amostras organizadas em um vetor
shadowing = [reshape(shadowing,1,nShadowSamples*nSampShadW),restShadowing];
% Filtragem para evitar varia��o abrupta do sombreamento
jan = nSampShadW/2;
iCont = 1;
for i = jan+1:nSamples+nSampShadW-jan
    vtShad(iCont) = mean(shadowing(i-jan:i+jan)); %diminuir a varia��o brusca do sombreamento
    iCont = iCont+1;
end
% Ajuste do desvio padr�o depois do filtro de correla��o do sombreamento
vtShad = vtShad*std(shadowing)/std(vtShad);
vtShad = vtShad - mean(vtShad)+ mean(shadowing);

% Gera��o do desvanecimento de pequena escala
switch pdftype
    case 'Nakagami'
        pdfEquation = @(x)((2.*m.^m)./(gamma(m))).*x.^(2.*m-1).*exp(-(m.*x.^2));
    case 'Rayleigh'
        pdfEquation = @(x) (x./sigma.^2).*exp((-x.^2)/(2.*(sigma.^2)));
    case 'Weibull'
        pdfEquation = @(x) (b/a).*(((x)./a).^(b-1)).*exp(-((x)./a).^b);
    case 'Rician'
        pdfEquation = @(x) (x ./ (s1.^2)) .*exp(-0.5 * (x.^2 + s2.^2) ./ ...
                      (s1.^2)) .*besseli(0, x .* s2 ./ (s1.^2));
end
normEnvelope = slicesample(1,nSamples,'pdf',pdfEquation);
vtFastFading=20.*log10(normEnvelope');

% C�lculo da Pot�ncia recebida
txPower = txPower*ones(1,nSamples);
vtPrxdBm = txPower-vtPathLoss+vtShad+vtFastFading; % Pot�ncia recebida

% Salva vari�veis do canal no Matlab
save([sPar.chFileName '.mat'],'vtDist', 'vtPathLoss', 'vtShad', 'vtFastFading', 'vtPrxdBm');