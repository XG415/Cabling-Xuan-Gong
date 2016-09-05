
addpath('data')
load distance_matrix.mat
load path_matrix.mat

c=50;
total_cost_ring_structure = zeros(c,c);
total_cost_multi_loop_structure = zeros(c,c);
%C=zeros(c,c);
for j = 0:c-1
    %r = j * 0.015/c;
    r = 0.0008+j * (0.015-0.0008)/(c-1);
    
for k = 0:c-1
   MTTR =30*24 + k * (3 * 30 * 24-30*24)/(c-1);
 
% mean time to repair (hours)
%MTTR = 2 * 30 * 24;
% turbine rated power (MW)
G = 5 * 0.33;
% Cable Availability Failure Rate
%r = 0.00742;
% Cable Price (?/km£©
cable_price = 370000;
% energy price (?/MWh)
energy_price = 150;
% the life time of wind farms (years)
life_time = 25;

loop_1_cable_1 = distance_matrix(2,49)/10; % the length (km)of cable 1 of loop 1
loop_1_cable_2 = distance_matrix(1,2)/10;
loop_1_cable_3 = distance_matrix(1,5)/10;
loop_1_cable_4 = distance_matrix(5,9)/10;
loop_1_cable_5 = distance_matrix(9,13)/10;
loop_1_cable_6 = distance_matrix(13,17)/10;
loop_1_cable_7 = distance_matrix(17,21)/10;
loop_1_cable_8 = distance_matrix(21,22)/10;
loop_1_cable_9 = distance_matrix(18,22)/10;
loop_1_cable_10 = distance_matrix(14,18)/10;
loop_1_cable_11 = distance_matrix(10,14)/10;
loop_1_cable_12 = distance_matrix(6,10)/10;
loop_1_cable_13 = distance_matrix(6,49)/10;

loop_2_cable_1 = distance_matrix(3,49)/10; % the lengthen (km)of cable 1 of loop 2
loop_2_cable_2 = distance_matrix(3,7)/10;
loop_2_cable_3 = distance_matrix(7,11)/10;
loop_2_cable_4 = distance_matrix(11,15)/10;
loop_2_cable_5 = distance_matrix(15,19)/10;
loop_2_cable_6 = distance_matrix(19,23)/10;
loop_2_cable_7 = distance_matrix(23,24)/10;
loop_2_cable_8 = distance_matrix(20,24)/10;
loop_2_cable_9 = distance_matrix(16,20)/10;
loop_2_cable_10 = distance_matrix(12,16)/10;
loop_2_cable_11 = distance_matrix(8,12)/10;
loop_2_cable_12 = distance_matrix(4,8)/10;
loop_2_cable_13 = distance_matrix(4,49)/10;

loop_3_cable_1 = distance_matrix(25,49)/10; % the lengthen (km)of cable 1 of loop 3
loop_3_cable_2 = distance_matrix(25,29)/10;
loop_3_cable_3 = distance_matrix(29,33)/10;
loop_3_cable_4 = distance_matrix(33,37)/10;
loop_3_cable_5 = distance_matrix(37,41)/10;
loop_3_cable_6 = distance_matrix(41,45)/10;
loop_3_cable_7 = distance_matrix(45,46)/10;
loop_3_cable_8 = distance_matrix(42,46)/10;
loop_3_cable_9 = distance_matrix(38,42)/10;
loop_3_cable_10 = distance_matrix(34,38)/10;
loop_3_cable_11 = distance_matrix(30,34)/10;
loop_3_cable_12 = distance_matrix(26,30)/10;
loop_3_cable_13 = distance_matrix(26,49)/10;

loop_4_cable_1 = distance_matrix(31,49)/10; % the lengthen (km)of cable 1 of loop 4
loop_4_cable_2 = distance_matrix(31,35)/10;
loop_4_cable_3 = distance_matrix(35,39)/10;
loop_4_cable_4 = distance_matrix(39,43)/10;
loop_4_cable_5 = distance_matrix(43,47)/10;
loop_4_cable_6 = distance_matrix(47,48)/10;
loop_4_cable_7 = distance_matrix(44,48)/10;
loop_4_cable_8 = distance_matrix(40,44)/10;
loop_4_cable_9 = distance_matrix(36,40)/10;
loop_4_cable_10 = distance_matrix(32,36)/10;
loop_4_cable_11 = distance_matrix(28,32)/10;
loop_4_cable_12 = distance_matrix(27,28)/10;
loop_4_cable_13 = distance_matrix(27,49)/10;

% the extra cables of multi-loop structure
cable_1 = distance_matrix(9,37)/10;
cable_2 = distance_matrix(15,18)/10;
cable_3 = distance_matrix(38,43)/10;
cable_4 = distance_matrix(16,36)/10;
extra_cables = cable_1 + cable_2 + cable_3 + cable_4;

loop_1 = [ loop_1_cable_1, loop_1_cable_2, loop_1_cable_3, loop_1_cable_4, loop_1_cable_5, loop_1_cable_6, ...
    loop_1_cable_7, loop_1_cable_8, loop_1_cable_9, loop_1_cable_10, loop_1_cable_11, loop_1_cable_12, loop_1_cable_13]';
loop_2 = [ loop_2_cable_1, loop_2_cable_2, loop_2_cable_3, loop_2_cable_4, loop_2_cable_5, loop_2_cable_6, ...
    loop_2_cable_7, loop_2_cable_8, loop_2_cable_9, loop_2_cable_10, loop_2_cable_11, loop_2_cable_12, loop_2_cable_13]';
loop_3 = [ loop_3_cable_1, loop_3_cable_2, loop_3_cable_3, loop_3_cable_4, loop_3_cable_5, loop_3_cable_6, ...
    loop_3_cable_7, loop_3_cable_8, loop_3_cable_9, loop_3_cable_10, loop_3_cable_11, loop_3_cable_12, loop_3_cable_13]';
loop_4 = [ loop_4_cable_1, loop_4_cable_2, loop_4_cable_3, loop_4_cable_4, loop_4_cable_5, loop_4_cable_6, ...
    loop_4_cable_7, loop_4_cable_8, loop_4_cable_9, loop_4_cable_10, loop_4_cable_11, loop_4_cable_12, loop_4_cable_13]';

wind_farm = [loop_1, loop_2, loop_3, loop_4];

%the availability of cables
% the availability of cables
availability = 1 - r * wind_farm;
A = availability;

for i=1:4
% if a fault occurs on cable 1.
lose_1 = (1 - A(1,i)) * A(2,i) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lost_generation_1 = MTTR * G * 4 * lose_1;
% if a fault occurs on cable 2.
lose_2 = A(1,i) * (1 - A(2,i)) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lost_generation_2 = MTTR * G * 3 * lose_2;
% if a fault occurs on cable 3.
lose_3 = A(1,i) * A(2,i) * (1 - A(3,i)) * A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lost_generation_3 = MTTR * G * 2 * lose_3;
% if a fault occurs on cable 4.
lose_4 =  A(1,i) * A(2,i) * A(3,i)* (1 - A(4,i))* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lost_generation_4 = MTTR * G * 1 * lose_4;
% if a fault occurs on cable 5, 6 ,7, 8 or 9
lost_generation_5 = 0;
lost_generation_6 = 0;
lost_generation_7 = 0;
lost_generation_8 = 0;
lost_generation_9 = 0;
% if a fault occurs on cable 10, 11, 12,13. 
lose_10 =  A(1,i) * A(2,i) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* (1 -A(10,i))* A(11,i)* A(12,i)* A(13,i);
lost_generation_10 = MTTR * G * 1 * lose_10;
lose_11 =  A(1,i) * A(2,i) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* (1 - A(11,i))* A(12,i)* A(13,i);
lost_generation_11 = MTTR * G * 2 * lose_11;
lose_12 =  A(1,i) * A(2,i) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)*(1 - A(12,i))* A(13,i);
lost_generation_12 = MTTR * G * 3 * lose_12;
lose_13 =  A(1,i) * A(2,i) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* (1 - A(13,i));
lost_generation_13 = MTTR * G * 4 * lose_13;

one_cable_lost_generation_loop(i) = lost_generation_1 + lost_generation_2 + lost_generation_3 + ...
    lost_generation_4 + lost_generation_10 + lost_generation_11 + lost_generation_12 + ...
    lost_generation_13;
end
one_cable_lost_generation = sum (one_cable_lost_generation_loop);


for i = 1:4
% Cable 1 is one of the two down cables
lose_1_2 = (1 - A(1,i)) *(1 - A(2,i)) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i); % the probability that cable 1 and cable 2 are down
lose_1_3 = (1 - A(1,i)) *(1 - A(3,i)) * A(2,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_1_4 = (1 - A(1,i)) *(1 - A(4,i)) * A(3,i)* A(2,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i); 
lose_1_5 = (1 - A(1,i)) *(1 - A(5,i)) * A(3,i)* A(4,i)* A(2,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_1_6 = (1 - A(1,i)) *(1 - A(6,i)) * A(3,i)* A(4,i)* A(5,i)* A(2,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_1_7 = (1 - A(1,i)) *(1 - A(7,i)) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(2,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_1_8 = (1 - A(1,i)) *(1 - A(8,i)) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(2,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_1_9 = (1 - A(1,i)) *(1 - A(9,i)) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(2,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_1_10 = (1 - A(1,i)) *(1 - A(10,i)) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(2,i)* A(11,i)* A(12,i)* A(13,i);
lose_1_11 = (1 - A(1,i)) *(1 - A(11,i)) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(2,i)* A(12,i)* A(13,i);
lose_1_12 = (1 - A(1,i)) *(1 - A(12,i)) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(2,i)* A(13,i);
lose_1_13 = (1 - A(1,i)) *(1 - A(13,i)) * A(3,i)* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(2,i);

lost_generation_1_2 = MTTR * G * 4 * lose_1_2;
lost_generation_1_3 = MTTR * G * 4 * lose_1_3;
lost_generation_1_4 = MTTR * G * 4 * lose_1_4;
lost_generation_1_5 = MTTR * G * 4 * lose_1_5;
lost_generation_1_6 = MTTR * G * 5 * lose_1_6;
lost_generation_1_7 = MTTR * G * 6 * lose_1_7;
lost_generation_1_8 = MTTR * G * 7 * lose_1_8;
lost_generation_1_9 = MTTR * G * 8 * lose_1_9;
lost_generation_1_10 = MTTR * G * 9 * lose_1_10;
lost_generation_1_11 = MTTR * G * 10 * lose_1_11;
lost_generation_1_12 = MTTR * G * 11 * lose_1_12;
lost_generation_1_13 = MTTR * G * 12 * lose_1_13;

lost_generation_cable_1 = lost_generation_1_2 + lost_generation_1_3 + ...
    lost_generation_1_4 + lost_generation_1_5 + lost_generation_1_6 + ...
    lost_generation_1_7 + lost_generation_1_8 + lost_generation_1_9 + ...
    lost_generation_1_10 + lost_generation_1_11 + lost_generation_1_12 + ...
    lost_generation_1_13;

% Cable 2 is one of the two down cables
lose_2_3 = A(1,i) *(1 - A(2,i)) * (1 - A(3,i))* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i); % the probability that cable 2 and cable 3 are down
lose_2_4 = A(1,i) *(1 - A(2,i)) * (1 - A(4,i))* A(3,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_2_5 = A(1,i) *(1 - A(2,i)) * (1 - A(5,i))* A(4,i)* A(3,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_2_6 = A(1,i) *(1 - A(2,i)) * (1 - A(6,i))* A(4,i)* A(5,i)* A(3,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_2_7 = A(1,i) *(1 - A(2,i)) * (1 - A(7,i))* A(4,i)* A(5,i)* A(6,i)* A(3,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_2_8 = A(1,i) *(1 - A(2,i)) * (1 - A(8,i))* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(3,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_2_9 = A(1,i) *(1 - A(2,i)) * (1 - A(9,i))* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(3,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_2_10 = A(1,i) *(1 - A(2,i)) * (1 - A(10,i))* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(3,i)* A(11,i)* A(12,i)* A(13,i);
lose_2_11 = A(1,i) *(1 - A(2,i)) * (1 - A(11,i))* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(3,i)* A(12,i)* A(13,i);
lose_2_12 = A(1,i) *(1 - A(2,i)) * (1 - A(12,i))* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(3,i)* A(13,i);
lose_2_13 = A(1,i) *(1 - A(2,i)) * (1 - A(13,i))* A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(3,i);

lost_generation_2_3 = MTTR * G * 3 * lose_2_3;
lost_generation_2_4 = MTTR * G * 3 * lose_2_4;
lost_generation_2_5 = MTTR * G * 3 * lose_2_5;
lost_generation_2_6 = MTTR * G * 4 * lose_2_6;
lost_generation_2_7 = MTTR * G * 5 * lose_2_7;
lost_generation_2_8 = MTTR * G * 6 * lose_2_8;
lost_generation_2_9 = MTTR * G * 7 * lose_2_9;
lost_generation_2_10 = MTTR * G * 8 * lose_2_10;
lost_generation_2_11 = MTTR * G * 9 * lose_2_11;
lost_generation_2_12 = MTTR * G * 10 * lose_2_12;
lost_generation_2_13 = MTTR * G * 11 * lose_2_13;

lost_generation_cable_2 = lost_generation_2_3 + lost_generation_2_4 + ...
    lost_generation_2_5 + lost_generation_2_6 + lost_generation_2_7 + ...
    lost_generation_2_8 + lost_generation_2_9 + lost_generation_2_10 + ...
    lost_generation_2_11 + lost_generation_2_12 + lost_generation_2_13;

% Cable 3 is one of the two down cables
lose_3_4 = A(1,i) * A(2,i) * (1 - A(3,i))* (1 - A(4,i))* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i); % the probability that cable 3 and cable 4 are down
lose_3_5 = A(1,i) * A(2,i) * (1 - A(3,i))* (1 - A(5,i))* A(4,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_3_6 = A(1,i) * A(2,i) * (1 - A(3,i))* (1 - A(6,i))* A(5,i)* A(4,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_3_7 = A(1,i) * A(2,i) * (1 - A(3,i))* (1 - A(7,i))* A(5,i)* A(6,i)* A(4,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_3_8 = A(1,i) * A(2,i) * (1 - A(3,i))* (1 - A(8,i))* A(5,i)* A(6,i)* A(7,i)* A(4,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_3_9 = A(1,i) * A(2,i) * (1 - A(3,i))* (1 - A(9,i))* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(4,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_3_10 = A(1,i) * A(2,i) * (1 - A(3,i))* (1 - A(10,i))* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(4,i)* A(11,i)* A(12,i)* A(13,i);
lose_3_11 = A(1,i) * A(2,i) * (1 - A(3,i))* (1 - A(11,i))* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(4,i)* A(12,i)* A(13,i);
lose_3_12 = A(1,i) * A(2,i) * (1 - A(3,i))* (1 - A(12,i))* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(4,i)* A(13,i);
lose_3_13 = A(1,i) * A(2,i) * (1 - A(3,i))* (1 - A(13,i))* A(5,i)* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(4,i);

lost_generation_3_4 = MTTR * G * 2 * lose_3_4;
lost_generation_3_5 = MTTR * G * 2 * lose_3_5;
lost_generation_3_6 = MTTR * G * 3 * lose_3_6;
lost_generation_3_7 = MTTR * G * 4 * lose_3_7;
lost_generation_3_8 = MTTR * G * 5 * lose_3_8;
lost_generation_3_9 = MTTR * G * 6 * lose_3_9;
lost_generation_3_10 = MTTR * G * 7 * lose_3_10;
lost_generation_3_11 = MTTR * G * 8 * lose_3_11;
lost_generation_3_12 = MTTR * G * 9 * lose_3_12;
lost_generation_3_13 = MTTR * G * 10 * lose_3_13;

lost_generation_cable_3 = lost_generation_3_4 + lost_generation_3_5 + ...
    lost_generation_3_6 + lost_generation_3_7 + lost_generation_3_8 + ...
    lost_generation_3_9 + lost_generation_3_10 + lost_generation_3_11 +...
    lost_generation_3_12 + lost_generation_3_13;

% Cable 4 is one of the two down cables
lose_4_5 = A(1,i) * A(2,i) * A(3,i)* (1 - A(4,i))* (1 - A(5,i))* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i); % the probability that cable 4 and cable 5 are down
lose_4_6 = A(1,i) * A(2,i) * A(3,i)* (1 - A(4,i))* (1 - A(6,i))* A(5,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_4_7 = A(1,i) * A(2,i) * A(3,i)* (1 - A(4,i))* (1 - A(7,i))* A(6,i)* A(5,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_4_8 = A(1,i) * A(2,i) * A(3,i)* (1 - A(4,i))* (1 - A(8,i))* A(6,i)* A(7,i)* A(5,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_4_9 = A(1,i) * A(2,i) * A(3,i)* (1 - A(4,i))* (1 - A(9,i))* A(6,i)* A(7,i)* A(8,i)* A(5,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_4_10 = A(1,i) * A(2,i) * A(3,i)* (1 - A(4,i))* (1 - A(10,i))* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(5,i)* A(11,i)* A(12,i)* A(13,i);
lose_4_11 = A(1,i) * A(2,i) * A(3,i)* (1 - A(4,i))* (1 - A(11,i))* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(5,i)* A(12,i)* A(13,i);
lose_4_12 = A(1,i) * A(2,i) * A(3,i)* (1 - A(4,i))* (1 - A(12,i))* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(5,i)* A(13,i);
lose_4_13 = A(1,i) * A(2,i) * A(3,i)* (1 - A(4,i))* (1 - A(13,i))* A(6,i)* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(5,i);

lost_generation_4_5 = MTTR * G * 1 * lose_4_5;
lost_generation_4_6 = MTTR * G * 2 * lose_4_6;
lost_generation_4_7 = MTTR * G * 3 * lose_4_7;
lost_generation_4_8 = MTTR * G * 4 * lose_4_8;
lost_generation_4_9 = MTTR * G * 5 * lose_4_9;
lost_generation_4_10 = MTTR * G * 6 * lose_4_10;
lost_generation_4_11 = MTTR * G * 7 * lose_4_11;
lost_generation_4_12 = MTTR * G * 8 * lose_4_12;
lost_generation_4_13 = MTTR * G * 9 * lose_4_13;

lost_generation_cable_4 = lost_generation_4_5 + lost_generation_4_6 + ...
    lost_generation_4_7 + lost_generation_4_8 + lost_generation_4_9 + ...
    lost_generation_4_10 + lost_generation_4_11 + lost_generation_4_12 + ...
    lost_generation_4_13;

% Cable 5 is one of the two down cables
lose_5_6 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* (1 - A(5,i))* (1 - A(6,i))* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i); % the probability that cable 5 and cable 6 are down
lose_5_7 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* (1 - A(5,i))* (1 - A(7,i))* A(6,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_5_8 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* (1 - A(5,i))* (1 - A(8,i))* A(7,i)* A(6,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_5_9 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* (1 - A(5,i))* (1 - A(9,i))* A(7,i)* A(8,i)* A(6,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_5_10 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* (1 - A(5,i))* (1 - A(10,i))* A(7,i)* A(8,i)* A(9,i)* A(6,i)* A(11,i)* A(12,i)* A(13,i);
lose_5_11 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* (1 - A(5,i))* (1 - A(11,i))* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(6,i)* A(12,i)* A(13,i);
lose_5_12 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* (1 - A(5,i))* (1 - A(12,i))* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(6,i)* A(13,i);
lose_5_13 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* (1 - A(5,i))* (1 - A(13,i))* A(7,i)* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(6,i);


lost_generation_5_6 = MTTR * G * 1 * lose_5_6;
lost_generation_5_7 = MTTR * G * 2 * lose_5_7;
lost_generation_5_8 = MTTR * G * 3 * lose_5_8;
lost_generation_5_9 = MTTR * G * 4 * lose_5_9;
lost_generation_5_10 = MTTR * G * 5 * lose_5_10;
lost_generation_5_11 = MTTR * G * 6 * lose_5_11;
lost_generation_5_12 = MTTR * G * 7 * lose_5_12;
lost_generation_5_13 = MTTR * G * 8 * lose_5_13;

lost_generation_cable_5 = lost_generation_5_6 + lost_generation_5_7 + ...
    lost_generation_5_8 + lost_generation_5_9 + lost_generation_5_10 + ...
    lost_generation_5_11 + lost_generation_5_12 + lost_generation_5_13;


% Cable 6 is one of the two down cables
lose_6_7 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* (1 - A(6,i))* (1 - A(7,i))* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i); % the probability that cable 6 and cable 7 are down
lose_6_8 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* (1 - A(6,i))* (1 - A(8,i))* A(7,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_6_9 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* (1 - A(6,i))* (1 - A(9,i))* A(8,i)* A(7,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_6_10 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* (1 - A(6,i))* (1 - A(10,i))* A(8,i)* A(9,i)* A(7,i)* A(11,i)* A(12,i)* A(13,i);
lose_6_11 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* (1 - A(6,i))* (1 - A(11,i))* A(8,i)* A(9,i)* A(10,i)* A(7,i)* A(12,i)* A(13,i);
lose_6_12 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* (1 - A(6,i))* (1 - A(12,i))* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(7,i)* A(13,i);
lose_6_13 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* (1 - A(6,i))* (1 - A(13,i))* A(8,i)* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(7,i);


lost_generation_6_7 = MTTR * G * 1 * lose_6_7;
lost_generation_6_8 = MTTR * G * 2 * lose_6_8;
lost_generation_6_9 = MTTR * G * 3 * lose_6_9;
lost_generation_6_10 = MTTR * G * 4 * lose_6_10;
lost_generation_6_11 = MTTR * G * 5 * lose_6_11;
lost_generation_6_12 = MTTR * G * 6 * lose_6_12;
lost_generation_6_13 = MTTR * G * 7 * lose_6_13;

lost_generation_cable_6 = lost_generation_6_7 + lost_generation_6_8 + ...
    lost_generation_6_9 + lost_generation_6_10 + lost_generation_6_11 + ...
    lost_generation_6_12 + lost_generation_6_13;

% Cable 7 is one of the two down cables
lose_7_8 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* (1 - A(7,i))*(1 - A(8,i))* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i); % the probability that cable 7 and cable 8 are down
lose_7_9 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* (1 - A(7,i))*(1 - A(9,i))* A(8,i)* A(10,i)* A(11,i)* A(12,i)* A(13,i);
lose_7_10 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* (1 - A(7,i))*(1 - A(10,i))* A(9,i)* A(8,i)* A(11,i)* A(12,i)* A(13,i);
lose_7_11 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* (1 - A(7,i))*(1 - A(11,i))* A(9,i)* A(10,i)* A(8,i)* A(12,i)* A(13,i);
lose_7_12 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* (1 - A(7,i))*(1 - A(12,i))* A(9,i)* A(10,i)* A(11,i)* A(8,i)* A(13,i);
lose_7_13 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* (1 - A(7,i))*(1 - A(13,i))* A(9,i)* A(10,i)* A(11,i)* A(12,i)* A(8,i);

lost_generation_7_8 = MTTR * G * 1 * lose_7_8;
lost_generation_7_9 = MTTR * G * 2 * lose_7_9;
lost_generation_7_10 = MTTR * G * 3 * lose_7_10;
lost_generation_7_11 = MTTR * G * 4 * lose_7_11;
lost_generation_7_12 = MTTR * G * 5 * lose_7_12;
lost_generation_7_13 = MTTR * G * 6 * lose_7_13;

lost_generation_cable_7 = lost_generation_7_8 + lost_generation_7_9 + ...
    lost_generation_7_10 + lost_generation_7_11 + lost_generation_7_12 + ...
    lost_generation_7_13;

% Cable 8 is one of the two down cables
lose_8_9 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)*(1 - A(8,i))*(1 - A(9,i))* A(10,i)* A(11,i)* A(12,i)* A(13,i); % the probability that cable 8 and cable 9 are down
lose_8_10 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)*(1 - A(8,i))*(1 - A(10,i))* A(9,i)* A(11,i)* A(12,i)* A(13,i);
lose_8_11 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)*(1 - A(8,i))*(1 - A(11,i))* A(10,i)* A(9,i)* A(12,i)* A(13,i);
lose_8_12 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)*(1 - A(8,i))*(1 - A(12,i))* A(10,i)* A(11,i)* A(9,i)* A(13,i);
lose_8_13 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)*(1 - A(8,i))*(1 - A(13,i))* A(10,i)* A(11,i)* A(12,i)* A(9,i);

lost_generation_8_9 = MTTR * G * 1 * lose_8_9;
lost_generation_8_10 = MTTR * G * 2 * lose_8_10;
lost_generation_8_11 = MTTR * G * 3 * lose_8_11;
lost_generation_8_12 = MTTR * G * 4 * lose_8_12;
lost_generation_8_13 = MTTR * G * 5 * lose_8_13;

lost_generation_cable_8 = lost_generation_8_9 + lost_generation_8_10 + ...
    lost_generation_8_11 + lost_generation_8_12 + lost_generation_8_13;

% Cable 9 is one of the two down cables
lose_9_10 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i) *(1 - A(9,i))* (1 - A(10,i))* A(11,i)* A(12,i)* A(13,i); % the probability that cable 9 and cable 10 are down
lose_9_11 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i) *(1 - A(9,i))* (1 - A(11,i))* A(10,i)* A(12,i)* A(13,i);
lose_9_12 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i) *(1 - A(9,i))* (1 - A(12,i))* A(11,i)* A(10,i)* A(13,i);
lose_9_13 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i) *(1 - A(9,i))* (1 - A(13,i))* A(11,i)* A(12,i)* A(10,i);

lost_generation_9_10 = MTTR * G * 1 * lose_9_10;
lost_generation_9_11 = MTTR * G * 2 * lose_9_11;
lost_generation_9_12 = MTTR * G * 3 * lose_9_12;
lost_generation_9_13 = MTTR * G * 4 * lose_9_13;

lost_generation_cable_9 = lost_generation_9_10 + lost_generation_9_11 + ...
    lost_generation_9_12 + lost_generation_9_13;

% Cable 10 is one of the two down cables
lose_10_11 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i) * A(9,i)* (1 - A(10,i))* (1- A(11,i)) * A(12,i)* A(13,i); % the probability that cable 9 and cable 10 are down
lose_10_12 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i) * A(9,i)* (1 - A(10,i))* (1- A(12,i)) * A(11,i)* A(13,i);
lose_10_13 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i) * A(9,i)* (1 - A(10,i))* (1- A(13,i)) * A(12,i)* A(11,i);

lost_generation_10_11 = MTTR * G * 2 * lose_10_11;
lost_generation_10_12 = MTTR * G * 3 * lose_10_12;
lost_generation_10_13 = MTTR * G * 4 * lose_10_13;

lost_generation_cable_10 = lost_generation_10_11 + lost_generation_10_12 + ...
    lost_generation_10_13;

% Cable 11 is one of the two down cables;
lose_11_12 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i) * A(9,i)* A(10,i)* (1- A(11,i)) * (1 - A(12,i))* A(13,i); % the probability that cable 11 and cable 12 are down
lose_11_13 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i) * A(9,i)* A(10,i)* (1- A(11,i)) * (1 - A(13,i))* A(12,i);

lost_generation_11_12 = MTTR * G * 3 * lose_11_12;
lost_generation_11_13 = MTTR * G * 4 * lose_11_13;

lost_generation_cable_11 = lost_generation_11_12 + lost_generation_11_13;

% Cable 12 is one of the two down cables;
lose_12_13 = A(1,i) * A(2,i) * A(3,i)*  A(4,i)* A(5,i)* A(6,i)* A(7,i)* A(8,i) * A(9,i)* A(10,i)* A(11,i) * (1 - A(12,i))* (1 - A(13,i));

lost_generation_12_13 = MTTR * G * 4 * lose_12_13;

lost_generation_cable_12 = lost_generation_12_13;


two_cables_lost_generation_loop(i) = lost_generation_cable_1 + lost_generation_cable_2 + ...
    + lost_generation_cable_3 + lost_generation_cable_4 + lost_generation_cable_5 + ...
    lost_generation_cable_6 + lost_generation_cable_7 + lost_generation_cable_8 + ...
    lost_generation_cable_9 + lost_generation_cable_10 + lost_generation_cable_11 + ...
    lost_generation_cable_12;
end
two_cables_lost_generation = sum (two_cables_lost_generation_loop);

lost_generation = one_cable_lost_generation + two_cables_lost_generation;
lost_generation_cost = lost_generation * life_time * energy_price;
cabling_cost = sum(sum(wind_farm)) * cable_price;
total_cost_ring_structure(j+1,k+1) = lost_generation_cost + cabling_cost;

% fprintf ( 'ring structue\n');
% fprintf( 'lost generation due to two down cables = %.1f\n', two_cables_lost_generation);
% fprintf( 'cost of lost generation = %.1f\n', lost_generation_cost);
% fprintf( 'cost of cabling = %.1f\n', cabling_cost);
% fprintf( 'total cost = %.1f\n', total_cost);

lost_generation_multi_loop_structure = two_cables_lost_generation/3;
lost_generation_cost_multi_loop_structure = lost_generation_multi_loop_structure * life_time * energy_price;
cabling_cost_multi_loop_structure = (sum(sum(wind_farm)) + extra_cables) * cable_price;
total_cost_multi_loop_structure(j+1,k+1) = lost_generation_cost_multi_loop_structure + cabling_cost_multi_loop_structure;

% fprintf ( 'multi-loop structue\n');
% fprintf( 'lost generation due to two down cables = %.1f\n', lost_generation_multi_loop_structure);
% fprintf( 'cost of lost generation = %.1f\n', lost_generation_cost_multi_loop_structure);
% fprintf( 'cost of cabling = %.1f\n', cabling_cost_multi_loop_structure);
% fprintf( 'total cost = %.1f\n', total_cost_multi_loop_structure);
end
end

x = 0.0008+(0:c-1) * (0.015-0.0008)/(c-1);
y = 30*24 + (0:c-1) * (3 * 30 * 24-30*24)/(c-1);
[X,Y] = meshgrid(x,y);
C(:,:,1) = 1 + zeros(c,c);
C(:,:,2) = 1 + zeros(c,c);
C(:,:,3) = zeros(c,c);
D(:,:,1) =1+ zeros(c,c);
D(:,:,2) = 0 + zeros(c,c);
D(:,:,3) = zeros(c,c);

 figure(2)
 surf(X,Y,total_cost_ring_structure,C);
 title('Total cost of ring structure')
 xlabel('Cable Availability Failure Rate')
ylabel('MTTR(h)')
zlabel('total cost(pound£©')
title('Total cost of ring structure')
 figure(3)
 surf(X,Y,total_cost_multi_loop_structure,D);
 title('Total cost of multi-loop structure')
xlabel('Cable Availability Failure Rate')
ylabel('MTTR(h)')
zlabel('total cost(pound£©')
title('Total cost of multi-loop structure')
% sum(sum(wind_farm))
% sum(sum(wind_farm)) + extra_cables