v = multi_loop_distance_index(1);

reference_x = Reference_X(v);
reference_y = Reference_Y(v);

sweep_cluster
Clarke_Wright


figure(3)
plot3(A,B,C,'r*','LineWidth',3);
hold on
plot3(A_end, B_end, C_end,'g*','LineWidth',3);
hold on
trisurf(faces,seaX,seaY,seaZ,'FaceColor', 'w', 'EdgeColor', 'k')
hold on;
axis equal

for i = 1: cluster_number
    e = numel(cluster_route_sequence{i});
    for j = 1 : e-1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
            path_z = path_matrix{c,d}(:,3);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
            path_z = path_matrix{d,c}(:,3);
        end
          plot3(path_x, path_y,path_z,'LineWidth',2)
          hold on;
    end
    
end

multi_loop_path_plot

figure(4)
ring_plane_graph
multi_loop_plane_graph

title(sprintf('multi-loop distance = %f km', shortest_multi_loop_distance))