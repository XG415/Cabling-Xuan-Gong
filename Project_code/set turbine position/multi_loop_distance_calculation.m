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
shortest_multi_loop_distance = multi_loop_distance_sorted(1);