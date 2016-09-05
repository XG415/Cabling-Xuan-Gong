function [distance , result_path] = turbine_distance( start, finish, vertices, faces)

[mesh, edge_to_vertex, edge_to_face] = geodesic_new_mesh(vertices,faces);
vertex_id = start;        
    source_points = {geodesic_create_surface_point('vertex',vertex_id,vertices(vertex_id,:))};

vertex_id = finish;           %last vertex of the mesh is destination
    destination = geodesic_create_surface_point('vertex',vertex_id,vertices(vertex_id,:));
  
    algorithm = geodesic_new_algorithm(mesh, 'exact');      %initialize new geodesic algorithm
    geodesic_propagate(algorithm, source_points);   %propagation stage of the algorithm (the most time-consuming)
    
    path = geodesic_trace_back(algorithm, destination); 
    [x,y,z] = extract_coordinates_from_path(path);
    result_path = [x,y,z];
        %plot3(x,y,z,'LineWidth',2);    %plot a sinlge path for this algorithm
        distance = sum(sqrt(diff(x).^2 + diff(y).^2 + diff(z).^2));
        %[source_id, distances] = geodesic_distance_and_source(algorithm)
end