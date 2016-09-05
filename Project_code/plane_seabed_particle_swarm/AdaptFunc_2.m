function shortest_multi_loop_distance = AdaptFunc_2(sub_loc)



sub_x = sub_loc(1);
sub_y = sub_loc(2);
substation_position = [sub_x,sub_y];
turbine_position = [-8,12; -8,4; -6,20; -10,-16; -6,-4; -8,20; 14,36; 14,-24; -22,16; 8,12];

Nodes = [turbine_position; substation_position];
Node_number = size(Nodes,1);

for i = 1:Node_number-1
    A(i) = Nodes(i,1);
    B(i) = Nodes(i,2);
end
A_end = Nodes(Node_number,1);
B_end = Nodes(Node_number,2);

for i = 1:Node_number
        for j = i+1:Node_number
            distance = sqrt((Nodes(i,1)-Nodes(j,1))^2 + (Nodes(i,2)- Nodes(j,2))^2);
            distance_matrix(i,j) = distance;
            
            path = [Nodes(i,1),Nodes(i,2);Nodes(j,1),Nodes(j,2)];
            path_matrix{i,j} = path;
           
        end
end
    
capacity = 5; %this is the turbine number on one ring
cable_capacity = 4;
string_capacity = 3;

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

for i = 1: cluster_number
    e = numel(cluster_route_sequence{i});
    if cable_capacity < e-2
        critical_turbine(2*i-1) = cluster_route_sequence{i}(cable_capacity + 2);
        critical_turbine(2*i) = cluster_route_sequence{i}(e - cable_capacity - 1);
    end
    if cable_capacity >=e-2
        critical_turbine(2*i-1) = 0;
        critical_turbine(2*i) = 0;
    end
end

s = 1;
for i = 1 : numel(critical_turbine);
    if critical_turbine(i) ~= 0
       connecting_turbine(s) = critical_turbine(i);
       s = s+1;
    end
end

for i = 1 : numel(connecting_turbine);
    connecting_angle(i) = angles(connecting_turbine(i));
end

[connecting_angle_sorted,connecting_angle_index] = sort(connecting_angle); 

for i = 1:numel(connecting_turbine)
    connecting_turbine_sorted(i) = connecting_turbine(connecting_angle_index(i));
end


for i = 1: numel(connecting_turbine_sorted)/2 -1
    pair_1 = min([connecting_turbine_sorted(2*i), connecting_turbine_sorted(2*i+1)]);
    pair_2 = max([connecting_turbine_sorted(2*i), connecting_turbine_sorted(2*i+1)]);
            path_distance = distance_matrix(pair_1,pair_2);
            ring_distance = ring_distance + path_distance;
 end

pair_1 = min([connecting_turbine_sorted(1), connecting_turbine_sorted(numel(connecting_turbine_sorted))]);
pair_2 = max([connecting_turbine_sorted(1), connecting_turbine_sorted(numel(connecting_turbine_sorted))]);
            
            path_distance = distance_matrix(pair_1,pair_2);
            ring_distance = ring_distance + path_distance;
            
            multi_loop_total_distance(v) = ring_distance/10;
end

[multi_loop_distance_sorted, multi_loop_distance_index] = sort(multi_loop_total_distance);
shortest_multi_loop_distance = -multi_loop_distance_sorted(1);


end