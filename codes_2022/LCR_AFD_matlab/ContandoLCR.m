%%Cálculo da LCR (contando LCR)
filename = 'Clarke.mat';

delimiterIn = ' ';
headerlinesIn = 1;
B = importdata(filename,delimiterIn,headerlinesIn);
vtPrx2  = (B');
vtPrx2 = B.h;
thr1= -10:0.1:10;
 
for i = 1:length( thr1 )
        tmp2 = ( vtPrx2 > thr1(i) );
        tmp2 = diff( tmp2 );
        lcf2( i ) = sum( tmp2==1 );
end
%Plot do número de cruzamentos
figure
plot(thr1,lcf2)
grid minor
xlabel('dBm')
ylabel('Número de cruzamentos')
title('Desvanecimento de pequena escala')