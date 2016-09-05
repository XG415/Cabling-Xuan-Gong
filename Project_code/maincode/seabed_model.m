addpath('data');
load Nodes.mat

n = 25;
[X,Y,Z] = peaks(n);

seaX = zeros(n*n,1);
seaY = zeros(n*n,1);
seaZ = zeros(n*n,1);

 for i=1:n;
    for j= 1:n;
        seaX(j+ n*(i-1),1) = X(j, i)/3*24;
        seaY(j+ n*(i-1),1) = Y(j, i)/3*48;
        seaZ(j+ n*(i-1),1) = Z(j, i);
        
    end
 end
 
 seabed(:,1) = seaX;
 seabed(:,2) = seaY;
 seabed(:,3) = seaZ;

for Node_number = 1:size(Nodes,1)
   temp = abs(seaX-Nodes(Node_number,1))+abs(seaY-Nodes(Node_number,2));
    [c Node_index(Node_number)] = min(temp);
end

for i = 1:Node_number -1
    A(i) = seabed(Node_index(i),1);
    B(i) = seabed(Node_index(i),2);
    C(i) = seabed(Node_index(i),3);
end
A_end = seabed(Node_index(Node_number),1);
B_end = seabed(Node_index(Node_number),2);
C_end = seabed(Node_index(Node_number),3);

% plot3(A,B,C,'r*','LineWidth',3);
% hold on
% plot3(A_end, B_end, C_end,'g*','LineWidth',3);
% hold on

global geodesic_library;                
geodesic_library = 'geodesic_debug'; 
rand('state', 0); 
    vertices(:,1) = seaX;
    vertices(:,2) = seaY;
    vertices(:,3) = seaZ;
    faces = delaunay(seaX,seaY);
    
   trisurf(faces,seaX,seaY,seaZ,'FaceColor', 'w', 'EdgeColor', 'k')
hold on;

axis equal

%view(0,90)

%daspect([5,5,1])

% [mesh, edge_to_vertex, edge_to_face] = geodesic_new_mesh(vertices,faces);
% vertex_id = 313;        
%     source_points = {geodesic_create_surface_point('vertex',vertex_id,vertices(vertex_id,:))};
% 
% vertex_id = 164;           %last vertex of the mesh is destination
%     destination = geodesic_create_surface_point('vertex',vertex_id,vertices(vertex_id,:));
%   
%     algorithm = geodesic_new_algorithm(mesh, 'exact');      %initialize new geodesic algorithm
%     geodesic_propagate(algorithm, source_points);   %propagation stage of the algorithm (the most time-consuming)
%     
%     path = geodesic_trace_back(algorithm, destination); 
%     [x,y,z] = extract_coordinates_from_path(path);
%     result_path = [x,y,z];
%         plot3(x,y,z,'LineWidth',2);    %plot a sinlge path for this algorithm
%         distance = sum(sqrt(diff(x).^2 + diff(y).^2 + diff(z).^2))
