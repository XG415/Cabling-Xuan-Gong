clear all;
close all;
clc;
addpath('geodesic');


sub_x = 0; sub_y = 0;        
substation_position = [sub_x,sub_y];
turbine_position = [-8,12; -8,4; -6,20; -10,-16; -6,-4; -8,20; 14,36; 14,-24; -22,16; 8,12];


seabed_model

for i = 1:numel(Node_index)
        for j = i+1:numel(Node_index)
            [distance , path] = turbine_distance( Node_index(i), Node_index(j), vertices, faces);
            distance_matrix(i,j) = distance;
            path_matrix{i,j} = path;
        end
end


capacity = 5; %this is the turbine number on one ring
cable_capacity = 4;
string_capacity = 3;% this is the turbine number on one string

Turbine_number = Node_number - 1;

Reference_X = [1,1,1,1,1,1,1,1,1, 0,-1,-1,-1,-1,-1,-1,-1,-1, -1,-1,-1,-1,-1,-1,-1,-1,-1, 0,1,1,1,1,1,1,1,1];
Reference_Y = [0, 0.1763, 0.354, 0.5774, 0.8391, 1.1912, 1.7321, 2.7475, 5.6713,...
               1, 5.6713, 2.7475, 1.7321, 1.1912, 0.8391, 0.5774, 0.354, 0.1763, ...
               0, -0.1763, -0.354, -0.5774, -0.8391, -1.1912, -1.7321, -2.7475, -5.6713,...
               -1, -5.6713, -2.7475, -1.7321, -1.1912, -0.8391, -0.5774, -0.354, -0.1763];
           
 for v = 1:36
    
reference_x = Reference_X(v);
reference_y = Reference_Y(v);

sweep_cluster
Clarke_Wright

ring_total_distance_calculation
Ring_Total_Distance(v) = ring_distance;

 end

[ring_distance_sorted,ring_distance_index] = sort(Ring_Total_Distance);
shortest_ring_distance = ring_distance_sorted(1);
shortest_ring_distance = shortest_ring_distance/10;

v = ring_distance_index(1);

reference_x = Reference_X(v);
reference_y = Reference_Y(v);

sweep_cluster
Clarke_Wright
 
figure(1)
ring_3D_plot

figure(2)
ring_plane_graph
title(sprintf('ring distance = %f km', shortest_ring_distance))


multi_loop_distance_calculation
multi_loop_structure_plot
 
string_distance_calculation_modified
string_structure_plot_modified


%% Calculate total cost
cable_95_price = 83700;
cable_240_price = 127600;
cable_400_price = 250000;
cable_630_price = 350000;


if string_capacity <=3
    string_cable_price = cable_95_price;
elseif string_capacity <=5
        string_cable_price = cable_240_price;
elseif string_capacity <=6
            string_cable_price = cable_400_price;
elseif string_capacity <=8
                string_cable_price = cable_630_price;
        end
        
        
if cable_capacity <=3
    ring_cable_price = cable_95_price;
elseif cable_capacity <=5
        ring_cable_price = cable_240_price;
elseif cable_capacity <=6
            ring_cable_price = cable_400_price;
elseif string_capacity <=8
            ring_cable_price = cable_630_price;
        end
            
 string_structure_cost
 ring_multi_loop_structure_cost
 best_structure_cost

