plot3(A,B,C,'r*','LineWidth',3);
hold on
plot3(A_end, B_end, C_end,'g*','LineWidth',3);
hold on



trisurf(faces,seaX,seaY,seaZ,'FaceColor', 'w', 'EdgeColor', 'k')
hold on;

axis equal



cluster_distance = zeros(cluster_number,1);

for i = 1: cluster_number
    e = numel(cluster_route_sequence{i});
    for j = 1 : e-1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
            path_z = path_matrix{c,d}(:,3);
            path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
            path_z = path_matrix{d,c}(:,3);
            path_distance = distance_matrix(d,c);
        end
          plot3(path_x, path_y,path_z,'LineWidth',2)
          hold on;
          loop_cluster_cable{i}(j) = path_distance/10;
         cluster_distance(i) = cluster_distance(i) +  path_distance;
    end
    
end
