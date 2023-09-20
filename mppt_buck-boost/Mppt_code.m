function D  = mppt(v_PV,i_PV)

Dmax = 0.95;
Dmin = 0;
Dinit = 0.10;
deltaD = 0.01;

%persistent variable type can store the data
% we need the old data by obtaining difference 
%between old and new value 

persistent vold pold Dold ;

dataType = 'double';

if isempty(vold)
    vold=0;
    pold=0;
    Dold=Dinit;
end

P = v_PV*i_PV;
dV = v_PV - vold;
dP = P - pold;

if(dP~=0)
    if(dP<0)
       if dV<0
           D = Dold - deltaD;
       else
           D = Dold + deltaD;
       end
    else
      if dV<0  
          D = Dold + deltaD;
      else
          D = Dold - deltaD;
      end
    end
else D= Dold;
end
          
if D>=Dmax || D<=Dmin
    D = Dold;
end

Dold= D;
vold = v_PV;
pold = P;
