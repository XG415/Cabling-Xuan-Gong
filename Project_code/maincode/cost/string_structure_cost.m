clear;clc
addpath('data')
load distance_matrix.mat
load path_matrix.mat
b=50;
total_cost_string_structure = zeros(b,b);
%C=zeros(b,b);

for j = 0:b-1
    %r = j * 0.015/b;
    r =0.0008+j * (0.015-0.0008)/(b-1);
for k = 0:b-1
    %MTTR = k * 3 * 30 * 24/b;
    MTTR =30*24 + k * (3 * 30 * 24-30*24)/(b-1);
% mean time to repair (hours)
%MTTR = 2 * 30 * 24;
% turbine rated power (MW)
G = 5 * 0.33;
% Cable Availability Failure Rate
%r = 0.00787;
% Cable Price (?/km£©
cable_price = 240000;
% energy price (?/MWh)
energy_price = 150;
% the life time of wind farms (years)
life_time = 25;


string_1_cable_1 = distance_matrix(2,49)/10; % the lengthen (km)of cable 1 of string 1
string_1_cable_2 = distance_matrix(1,2)/10;
string_1_cable_3 = distance_matrix(1,5)/10;
string_1_cable_4 = distance_matrix(5,9)/10;
string_1_cable_5 = distance_matrix(9,13)/10;
string_1_cable_6 = distance_matrix(13,17)/10;

string_2_cable_1 = distance_matrix(6,49)/10;  % the lengthen (km)of cable 1 of string 2
string_2_cable_2 = distance_matrix(6,10)/10;
string_2_cable_3 = distance_matrix(10,14)/10;
string_2_cable_4 = distance_matrix(14,18)/10;
string_2_cable_5 = distance_matrix(18,22)/10;
string_2_cable_6 = distance_matrix(21,22)/10;

string_3_cable_1 = distance_matrix(3,49)/10;  % the lengthen (km)of cable 1 of string 3
string_3_cable_2 = distance_matrix(3,7)/10;
string_3_cable_3 = distance_matrix(7,11)/10;
string_3_cable_4 = distance_matrix(11,15)/10;
string_3_cable_5 = distance_matrix(15,19)/10;
string_3_cable_6 = distance_matrix(19,23)/10;

string_4_cable_1 = distance_matrix(4,49)/10; % the lengthen (km)of cable 1 of string 4
string_4_cable_2 = distance_matrix(4,8)/10;
string_4_cable_3 = distance_matrix(8,12)/10;
string_4_cable_4 = distance_matrix(12,16)/10;
string_4_cable_5 = distance_matrix(16,20)/10;
string_4_cable_6 = distance_matrix(20,24)/10;

string_5_cable_1 = distance_matrix(25,49)/10; % the lengthen (km)of cable 1 of string 5
string_5_cable_2 = distance_matrix(25,29)/10;
string_5_cable_3 = distance_matrix(29,33)/10;
string_5_cable_4 = distance_matrix(33,37)/10;
string_5_cable_5 = distance_matrix(37,41)/10;
string_5_cable_6 = distance_matrix(41,45)/10;

string_6_cable_1 = distance_matrix(26,49)/10; % the lengthen (km)of cable 1 of string 6
string_6_cable_2 = distance_matrix(26,30)/10;
string_6_cable_3 = distance_matrix(30,34)/10;
string_6_cable_4 = distance_matrix(34,38)/10;
string_6_cable_5 = distance_matrix(38,42)/10;
string_6_cable_6 = distance_matrix(42,46)/10;

string_7_cable_1 = distance_matrix(31,49)/10; % the lengthen (km)of cable 1 of string 7
string_7_cable_2 = distance_matrix(31,35)/10;
string_7_cable_3 = distance_matrix(35,39)/10;
string_7_cable_4 = distance_matrix(39,43)/10;
string_7_cable_5 = distance_matrix(43,47)/10;
string_7_cable_6 = distance_matrix(47,48)/10;

string_8_cable_1 = distance_matrix(27,49)/10; % the lengthen (km)of cable 1 of string 6
string_8_cable_2 = distance_matrix(27,28)/10;
string_8_cable_3 = distance_matrix(28,32)/10;
string_8_cable_4 = distance_matrix(32,36)/10;
string_8_cable_5 = distance_matrix(36,40)/10;
string_8_cable_6 = distance_matrix(40,44)/10;

string_1 = [ string_1_cable_1, string_1_cable_2, string_1_cable_3, string_1_cable_4, string_1_cable_5, string_1_cable_6]';
string_2 = [ string_2_cable_1, string_2_cable_2, string_2_cable_3, string_2_cable_4, string_2_cable_5, string_2_cable_6]';
string_3 = [ string_3_cable_1, string_3_cable_2, string_3_cable_3, string_3_cable_4, string_3_cable_5, string_3_cable_6]';
string_4 = [ string_4_cable_1, string_4_cable_2, string_4_cable_3, string_4_cable_4, string_4_cable_5, string_4_cable_6]';
string_5 = [ string_5_cable_1, string_5_cable_2, string_5_cable_3, string_5_cable_4, string_5_cable_5, string_5_cable_6]';
string_6 = [ string_6_cable_1, string_6_cable_2, string_6_cable_3, string_6_cable_4, string_6_cable_5, string_6_cable_6]';
string_7 = [ string_7_cable_1, string_7_cable_2, string_7_cable_3, string_7_cable_4, string_7_cable_5, string_7_cable_6]';
string_8 = [ string_8_cable_1, string_8_cable_2, string_8_cable_3, string_8_cable_4, string_8_cable_5, string_8_cable_6]';

wind_farm = [string_1, string_2, string_3, string_4, string_5, string_6, string_7, string_8];

% the availability of cables
availability = 1 - r * wind_farm;
A = availability;

for i = 1:8

% the probability of losing one turbine on string i
lose_1 = (1 - A(6,i)) * A(1,i) * A(2,i) * A(3,i) * A(4,i) *  A(5,i);
lost_generation_1 = MTTR * G * 1 * lose_1;
% the probability of losing two turbines on string i
lose_2 = (1 -  A(5,i)) * A(1,i) * A(2,i) * A(3,i) * A(4,i);
lost_generation_2 = MTTR * G * 2 * lose_2;
% the probability of losing three turbines on string i
lose_3 = (1 - A(4,i)) * A(1,i) * A(2,i) * A(3,i);
lost_generation_3 = MTTR * G * 3 * lose_3;
% the probability of losing four turbines on string i
lose_4 = (1 - A(3,i)) * A(1,i) * A(2,i) ;
lost_generation_4 = MTTR * G * 4 * lose_4;
% the probability of losing five turbines on string i
lose_5 = (1 - A(2,i)) * A(1,i);
lost_generation_5 = MTTR * G * 5 * lose_5;
% the probability of losing six turbines on string i
lose_6 = 1 - A(1,i);
lost_generation_6 = MTTR * G * 6 * lose_6;

% total lost generation on string i ( MWh)
lost_generation_string(i) = lost_generation_1 + lost_generation_2 + ...
lost_generation_3 + lost_generation_4 + lost_generation_5 + lost_generation_6;
end
lost_generation = sum (lost_generation_string);
lost_generation_cost = lost_generation * life_time * energy_price;
cabling_cost = sum(sum(wind_farm)) * cable_price;

total_cost_string_structure(j+1,k+1) = lost_generation_cost + cabling_cost;
end
end
figure(1)
% x=(1:b) * 0.015/b;
% y=(1:b) * 3 * 30 * 24/b;
x = 0.0008+(0:b-1) * (0.015-0.0008)/(b-1);
y = 30*24 + (0:b-1) * (3 * 30 * 24-30*24)/(b-1);
[X,Y] = meshgrid(x,y);
C(:,:,1) = zeros(b,b);
C(:,:,2) = 1 + zeros(b,b);
C(:,:,3) = zeros(b,b);
surf(X,Y,total_cost_string_structure,C)
xlabel('Cable Availability Failure Rate')
ylabel('MTTR(h)')
zlabel('total cost(pound£©')
title('Total cost of string structure')

% fprintf( 'cost of lost generation = %.1f\n', lost_generation_cost);
% fprintf( 'cost of cabling = %.1f\n', cabling_cost);
% fprintf( 'total cost = %.1f\n', total_cost);
