% % % % % % % % % % % % % % % % % % % % % % % % % 
% Description : Calculation of the incident energy on a Tilted surface
%               given the latitude and day number.Changing angles 3 time a
%               year including atmospheric effects
% INPUTS
%       N= Day number,N=1 for jan 1st & N=365 for dec 31st
%       Q= Latitude of the place in degrees (convert to radians)
clc
clear
load('tiltfactor.mat');
load('Hat1.mat');
% R = readstruct('tiltfactor.mat');
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

Ha= [3.3 5.4 6.1 5.4 4.6;
3.3	5.5	6.2	6.1	4.9;
3.3	5.7	5.8	6.2	4.9;
3.3	5.7	5.9	6.0	4.9;
3.3	5.6	5.4	5.4	4.9;
3.4	5.8	5.6	5.4	4.9;
3.3	5.7	6.1	6.7	4.8;
3.4	5.8	5.9	6.5	4.8;
3.1	5.7	5.4	6.8	4.7;
3.3	5.7	5.5	6.5	4.7;
3.2	5.8	6.2	6.0	4.7;
3.3	5.7	5.6	4.8	4.6;
3.2	5.6	5.9	5.4	4.6;
3.4	5.9	5.9	5.3	4.6;
3.3	6.2	6.2	4.3	4.5;
3.3	6.3	6.3	5.5	4.5;
4.1	6.2	6.7	5.9	4.4;
3.9	6.3	6.5	5.8	4.4;
4.1	6.2	5.7	5.4	4.3;
4.2	6.2	6.1	4.6	4.2;
4.2	6.3	5.8	5.7	3.7;
4.2	5.3	6.4	5.6	3.8;
4.3	6.2	5.4	6.2	3.4;
4.3	5.6	5.4	5.8	3.7;
4.2	6.1	5.3	6.2	3.3;
4.2	6.4	5.6	6.6	3.5;
4.2	6.6	4.2	5.6	3.5;
4.2	6.5	5.4	6.5	3.8;
4.2	6.4	5.3	6.3	3.1;
4.2	6.5	5.2	6.2	3.7;
4.3	6.7	4.7	6.4	3.8;
4.3	6.4	4.7	6.3	3.6;
4.0 6.8	4.7	6.0	3.7;
4.0	6.7	4.8	6.3	3.7;
4.0	6.3	4.5	5.9	3.8;
4.1	6.4	5.2	5.7	3.9;
3.8	6.4	4.5	5.7	4.2;
4.1	6.8	4.1	5.8	4.1;
4.2	6.4	4.0	5.1	4.2;
4.2	6.5	4.4	6.1	4.1;
4.3	6.3	4.2	6.2	4.1;
4.3	6.1	4.9	5.7	4.0;
4.3	6.3	4.9	6.0	4.1;
4.4	6.0	4.6	5.8	4.0;
4.4	5.6	4.0	4.7	3.5;
4.4	6.2	4.7	4.6	3.6;
4.4	6.2	4.5	5.3	3.1;
4.3	5.7	4.5	5.5	3.0;
4.8	5.4	5.3	5.5	3.5;
4.8	5.8	5.2	5.5	3.5;
4.0	5.8	4.6	5.6	3.5;
4.6	5.1	4.6	5.2	3.4;
4.9	5.7	5.0	5.3	3.2;
5.0	4.9	5.0	4.8	3.2;
4.9	5.3	5.5	5.3	3.2;
5.0	5.9	5.3	5.3	3.2;
5.1	6.0	5.2	5.3	3.2;
5.1	6.3	4.8	5.3	3.3;
5.3	6.2	5.2	5.1	3.3;
5.2	4.5	5.0	4.8	3.3;
5.1	6.3	3.8	5.1	3.3;
4.8	6.3	3.8	5.2	3.2;
5.2	6.5	5.3	5.4	3.6;
5.3	6.0	6.0	5.1	3.6;
5.2	6.0	5.7	5.3	3.6;
4.9	6.0	5.9	4.9	3.7;
5.1	6.3	5.4	5.0	3.6;
5.3	6.3	5.3	4.9	3.6;
4.8	6.4	5.0	5.3	3.7;
5.2	6.0	6.2	5.1	3.6;
5.0	6.3	6.6	5.1	3.8;
5.8	6.0	5.4	5.0	3.8;
5.7	5.7	4.8	4.9	3.8];

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
    
     Rd1(N) = Hot(N)/Ho(N);
    
    Hat3(N)= Ha(N)*Rd1(N);
    end
     Ha1=reshape(Ha,1,365);
     s4=sum(Hat3);
     s5=sum(Hot);
figure(6)
plot(days,Rd1,days,Rd,'-.','linewidth',1);grid, xlabel('Day number, N'), ylabel('kWh/m2/day');
title('Tilt factor versus Day of year (comparing tilt factor when tilt changed 1time vs 3time a year)');
legend('3-Rd','Rd')

figure(7)
plot(days,Ho,days,Ha1);grid, xlabel('Day number, N'), ylabel('kWh/m2/day'), title('Ho & Ha versus Day of year');

figure(8)
plot(days,Hot,days,Hat3);grid, xlabel('Day number, N'), ylabel('kWh/m2/day'), title('Hot & Hat(changing tilt 2times) versus Day of year');

figure(9)
plot(days,Hat,'--',days,Hat3,'linewidth',1);grid, xlabel('Day number, N'), ylabel('kWh/m2/day');
title('Hat(horizontal) & Hat(changing titlt 2times) versus Day of year with atmospheric effects');
legend('Hat_3(3-tilts)','Hat_1(1-tilt)')

figure(10)
plot(days,Ho,days,Hot);grid, xlabel('Day number, N'), ylabel('kWh/m2/day'), title('Ho & Hot(changing tilt 2times) versus Day of year');