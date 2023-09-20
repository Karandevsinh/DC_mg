% % % % % % % % % % % % % % % % % % % % % % % % % 
% Description : Calculation of the incident energy on a Tilted surface
%               given the latitude and day number. (ignoring atmospheric
%               effects
% INPUTS
%       N= Day number,N=1 for jan 1st & N=365 for dec 31st
%       Q= Latitude of the place in degrees (convert to radians)
clc
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Results = B=20 deg max insolation and min ripple
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS

% Locality
% Latitude Q = 22.5289442 deg North (IIT indore,APJ)
Q= 22.53;
Q=Q*pi/180; % in radians 
B=Q;

%constants
Lsc = 1.37 ; %kW/m2 - mean solar constant
disp(['Hot-MIN',"\t\t",'H-RIPPLE',"\t",'LATITUDE,deg',"\t",'TILT ANGLE,deg']);
Bmax= 45*pi/180;
% Calculation of insolation and energy on all days of the year
for B=0:Bmax/45:Bmax
    
    for N=1:365
        
    %Calculation of declination
    a = 2*pi*(N-80)/365 ;
    d = 23.45*sin(a)*(pi/180) ; % radians

    % calculation of extra-terrestrial insolation scale factor and hour
    % angle
    k = 1 + 0.033*cos(2*pi*N/365);
    wsr = acos(-1*tan(d)*tan(Q));
    wsrb = acos(-1*tan(d)*tan(Q-B));
    
    wsrt = min(wsr,wsrb);
    
    % Calculation of daily energy available for horizontal surface
    % (kWh/m2/day)
    
    Ho(N) = (24*k*Lsc/pi)*(cos(d)*cos(Q)*sin(wsr) + wsr*sin(d)*sin(Q));
    Hot(N) = (24*k*Lsc/pi)*(cos(d)*cos(Q-B)*sin(wsrt) + wsrt*sin(d)*sin(Q-B));
    days(N) = N;

    end
disp([num2str(min(Hot)),"\t\t",num2str(max(Hot)-min(Hot)),"\t\t",num2str(Q*180/pi),"\t\t",num2str(B*180/pi)]);
figure(2)
plot(days,Ho,days,Hot);grid, xlabel('Day number, N'), ylabel('kWh/m2/day'), title('Ho & Hot versus Day of year');
pause
end