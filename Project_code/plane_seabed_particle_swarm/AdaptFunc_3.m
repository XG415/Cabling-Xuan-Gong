function shortest_string_distance = AdaptFunc_3(sub_loc)



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
           
 string_distance_calculation
 
 shortest_string_distance = -shortest_string_distance;

end