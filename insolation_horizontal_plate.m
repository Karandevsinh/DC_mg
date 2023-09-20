% % % % % % % % % % % % % % % % % % % % % % % % % 
% Description : Calculation of the incident energy on a Horizontal surface
%               given the latitude and day number. (ignoring atmospheric
%               effects
% INPUTS
%       N= Day number,N=1 for jan 1st & N=365 for dec 31st
%       Q= Latitude of the place in degrees (convert to radians)
clc
clear

% INPUTS

% Locality
% Latitude Q = 22.5289442 deg North (IIT indore,APJ)
Q= 22.53;
Q=Q*pi/180; % in radians 

%constants
Lsc = 1.37 ; %kW/m2 - mean solar constant

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
    
    Ho(N) = (24*k*Lsc/pi)*(cos(d)*cos(Q)*sin(wsr) + wsr*sin(d)*sin(Q));
    days(N) = N;

end
step = 40/365;
s=0;
for i=1:365
    time(i)=s;
    s=s+step;
end
figure
plot(days,Ho);grid, xlabel('Day number, N'), ylabel('kWh/m2/day'), title('Ho versus Day of year');
legend ('Ho');
legend boxoff;








