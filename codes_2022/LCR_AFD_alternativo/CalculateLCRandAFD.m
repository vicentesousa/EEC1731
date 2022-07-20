% this function takes four variables:- 
%    x: vector of real values
%    L: Level of crossing
%    ts: sampling time
% this function returns four variables:-
%    LCR  : Level Crossing Rate
%    AFD  : Average fade duration
function  [LCR AFD]= CalculateLCRandAFD(x,L,ts)
b=double((x<L));                
c=b;                            
for k=length(b):-1:2            
    if b(k)==1 & b(k-1)==1        
       c(k-1)=0;                
    end
end
CN_PD = sum(c);                  
LCR=CN_PD/(ts*length(x));
AFD=(sum(b)).*ts./CN_PD;