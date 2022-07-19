% this function takes four variables:- 
%    x: vector of real values
%    L: Level of crossing
%    ts: sampling time
% this function returns four variables:-
%    CN_PD: crossing number in Positive direction
%    CPV  : vector denoting the location of crossing at Positive direction
%    LCR  : Level Crossing Rate
%    AFD  : Average fade duration
%    FT   : Fraction of time that signal goes below L
function  [CN_PD CPV LCR AFD FT]= Cross_N_PD(x,L,ts)
AFD=0;
b=double((x<L));                
c=b;                            
for k=length(b):-1:2            
    if b(k)==1 & b(k-1)==1        
       c(k-1)=0;                
    end
end
CN_PD = sum(c);                  
CPV=c;
LCR=CN_PD/(ts*length(x));
AFD=(sum(b)).*ts./CN_PD;
FT=AFD.*CN_PD;