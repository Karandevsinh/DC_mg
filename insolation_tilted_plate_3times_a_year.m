% % % % % % % % % % % % % % % % % % % % % % % % % 
% Description : Calculation of the incident energy on a Tilted surface
%               given the latitude and day number.Changing angles 3 time a year (ignoring atmospheric
%               effects
% INPUTS
%       N= Day number,N=1 for jan 1st & N=365 for dec 31st
%       Q= Latitude of the place in degrees (convert to radians)
clc
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Results = B=23 deg for N:1 to 98
%           B=0 deg for N:99 to 251
%           B=30 deg for N:252 to 365
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS

% Locality
% Latitude Q = 22.5289442 deg North (IIT indore,APJ)
Q= 22.53;
Q=Q*pi/180; % in radians 


%constants
Lsc = 1.37 ; %kW/m2 - mean solar constant
disp(['Hot-MIN',"\t\t",'H-RIPPLE',"\t",'LATITUDE,deg',"\t",'TILT ANGLE,deg']);
Bmax= 45*pi/180;
% Calculation of insolation and energy on all days of the year
    
    for N=1:365
        
    %Calculation of declination
    a = 2*pi*(N-80)/365 ;
    d = 23.45*sin(a)*(pi/180) ; % radians

    % calculation of extra-terrestrial insolation scale factor and hour
    % angle
    k = 1 + 0.033*cos(2*pi*N/365);
    wsr = acos(-1*tan(d)*tan(Q));
    
    % Calculation of daily energy available for horizontal surface
    % (kWh/m2/day)
    if(N>=1)&&(N<=98)
        B=23*pi/180;
        wsrb = acos(-1*tan(d)*tan(Q-B));
         wsrt = min(wsr,wsrb);   
        Hot(N) = (24*k*Lsc/pi)*(cos(d)*cos(Q-B)*sin(wsrt) + wsrt*sin(d)*sin(Q-B));
    elseif (N>98) && (N<=251)
        B=0;
        wsrb = acos(-1*tan(d)*tan(Q-B));
         wsrt = min(wsr,wsrb);   
        Hot(N) = (24*k*Lsc/pi)*(cos(d)*cos(Q-B)*sin(wsrt) + wsrt*sin(d)*sin(Q-B));
    else
            B=30*pi/180;
             wsrb = acos(-1*tan(d)*tan(Q-B));
         wsrt = min(wsr,wsrb);   
        Hot(N) = (24*k*Lsc/pi)*(cos(d)*cos(Q-B)*sin(wsrt) + wsrt*sin(d)*sin(Q-B));
    end
            Ho(N) = (24*k*Lsc/pi)*(cos(d)*cos(Q)*sin(wsr) + wsr*sin(d)*sin(Q));
    days(N) = N;
    end
  figure
plot(days,Ho,days,Hot);grid, xlabel('Day number, N'), ylabel('kWh/m2/day'), title('Ho & Hot versus Day of year');

  
   
    
