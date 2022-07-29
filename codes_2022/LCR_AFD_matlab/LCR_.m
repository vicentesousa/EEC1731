%%Função de cálculo LCR

function [LCR] = LCR_(amostras, nivel, ts)
    AFD = 0;
    LCR = 0;  
    x=[];
for i=1:length(amostras)
      if (amostras(1,i) < nivel)
          x(i) = 1;
      else
        x(i) = 0;
      end
end

a=x;
    for i=length(amostras):-1:2
      if (x(i) == 1 && x(i-1) == 1)
          
        a(i - 1) = 0;
      end
    end
    
LCR = sum(a)/(ts*length(amostras));