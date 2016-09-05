Nodes = [turbine_position; substation_position];

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
 
 
 global geodesic_library;                
geodesic_library = 'geodesic_debug'; 
rand('state', 0); 
    vertices(:,1) = seaX;
    vertices(:,2) = seaY;
    vertices(:,3) = seaZ;
    faces = delaunay(seaX,seaY);

