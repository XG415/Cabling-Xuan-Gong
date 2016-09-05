
plot(A,B,'r*','LineWidth',2);
hold on
plot(A_end, B_end,'g*','LineWidth',2);
axis equal
axis([-24 24 -48 48])
hold on

for i = 1: cluster_number
    e = numel(cluster_route_sequence{i});
    for j = 1 : e-1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
            %path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
            %path_distance = distance_matrix(d,c);
        end
           plot(path_x, path_y,'LineWidth',2)
           hold on;
         %cluster_distance(i) = cluster_distance(i) +  path_distance;
    end
    %total_distance = sum(cluster_distance);
end

