%% Initialisation
clear all;
close all;
addpath('geodesic');
%% Generate seabed model
display('Generating seabed model');

seabed_model

%% Generate diatance matrix
display('Generating distance matrix');

addpath('data')
load distance_matrix.mat
load path_matrix.mat

% % for i = 1:numel(Node_index)
% %         for j = i+1:numel(Node_index)
% %             [distance , path] = turbine_distance( Node_index(i), Node_index(j), vertices, faces);
% %             distance_matrix(i,j) = distance;
% %             path_matrix{i,j} = path;
% %             %[distMat(i,j), pathCell{i,j}] = turbine_diatance(data(i), data(j), vertices, faces);
% %         end
% %     end
% 
%% Sweep and cluster
capacity = 12;
cable_capacity = 8;
string_capacity = 6;

Turbine_number = Node_number - 1;

Reference_X = [1,1,1,1,1,1,1,1,1, 0,-1,-1,-1,-1,-1,-1,-1,-1, -1,-1,-1,-1,-1,-1,-1,-1,-1, 0,1,1,1,1,1,1,1,1];
Reference_Y = [0, 0.1763, 0.354, 0.5774, 0.8391, 1.1912, 1.7321, 2.7475, 5.6713,...
               1, 5.6713, 2.7475, 1.7321, 1.1912, 0.8391, 0.5774, 0.354, 0.1763, ...
               0, -0.1763, -0.354, -0.5774, -0.8391, -1.1912, -1.7321, -2.7475, -5.6713,...
               -1, -5.6713, -2.7475, -1.7321, -1.1912, -0.8391, -0.5774, -0.354, -0.1763];

for v = 1:36
    
reference_x = Reference_X(v);
reference_y = Reference_Y(v);

sweep_cluster;

%% Clarke and Wright's Saving Algorithm

Clarke_Wright

%% calculate different total distance based on different sweep vector

total_distance_calculation

Total_Distance(v) = total_distance;

end


%% Find the shortest distance and corresponding sweep vector
[distance_sorted,distance_index] = sort(Total_Distance);
shortest_distance = distance_sorted(1);
v = distance_index(1);
%v = 10;
reference_x = Reference_X(v);
reference_y = Reference_Y(v);

sweep_cluster
Clarke_Wright

%% Plot loop structure
figure(1)
loop_3D_plot

figure(2)
loop_plane_graph
title(sprintf('ring distance = %f km', Total_Distance(v)/10))

%% Plot Multiloop structure

multi_loop_distance_calculation
multi_loop_structure_plot
 
 %% Plot string structure
% string_structure

% string_distance_calculation
% string_structure_plot

string_distance_calculation_modified
string_structure_plot_modified
  