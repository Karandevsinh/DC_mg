% % % % % % % % % % % % % % % % % % % % % % % % % 
% Description : Calculation of the incident energy on a Tilted surface
%               given the latitude and day number. (Including atmosphere)
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
B=20*pi/180;

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
    wsrb = acos(-1*tan(d)*tan(Q-B));
    
    wsrt = min(wsr,wsrb);
    
    % Calculation of daily energy available for horizontal surface
    % (kWh/m2/day)
    
    Ho(N) = (24*k*Lsc/pi)*(cos(d)*cos(Q)*sin(wsr) + wsr*sin(d)*sin(Q));
    Hot(N) = (24*k*Lsc/pi)*(cos(d)*cos(Q-B)*sin(wsrt) + wsrt*sin(d)*sin(Q-B));
    days(N) = N;
    
    Rd(N) = Hot(N)/Ho(N);
    
    Hat(N)= Ha(N)*Rd(N);
    
    
    end
    Ha1=reshape(Ha,1,365);
    s = sum(Ha1);
    s1 = sum(Ho);
    s2 = sum(Hat);
    s3 = sum (Hot);
figure(1)
plot(days,Ho,days,Ha1,'-.','linewidth',1);grid, xlabel('Day number, N'), ylabel('kWh/m2/day'); 
title('Ho & Ha versus Day of year(on horizontal surface)');
legend('Ho','Ha')
ylim([2,12])

figure(2)
plot(days,Hot,days,Hat,'-.','linewidth',0.75);grid, xlabel('Day number, N'), ylabel('kWh/m2/day'); 
title('Hot & Hat versus Day of year(with tilt of 20deg)');
legend ('Hot','Hat')

figure(3)
plot(days,Ha1,'-.',days,Hat,'-','linewidth',0.75);grid, xlabel('Day number, N'), ylabel('kWh/m2/day');
title('Ha & Hat versus Day of year with atmospheric effects');
legend ('Ha','Hat')

figure(4)
plot(days,Ho,days,Hot);grid, xlabel('Day number, N'), ylabel('kWh/m2/day'), title('Ho & Hot versus Day of year');

figure(5)
plot(days,Rd);grid, xlabel('Day number, N'), ylabel('Rd'), title('Tilt factor versus Day of year');

