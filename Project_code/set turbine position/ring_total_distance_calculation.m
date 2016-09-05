

cluster_distance = zeros(cluster_number,1);

for i = 1: cluster_number
    e = numel(cluster_route_sequence{i});
    for j = 1 : e-1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_distance = distance_matrix(c,d);
        else
            path_distance = distance_matrix(d,c);
        end
         cluster_distance(i) = cluster_distance(i) +  path_distance;
    end
    ring_distance = sum(cluster_distance);
end
