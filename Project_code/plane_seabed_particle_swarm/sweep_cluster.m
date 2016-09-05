reference = [reference_x; reference_y];

angles = zeros(Turbine_number,1);

for i=1:Turbine_number
     Turbine(i,1) = Nodes(i,1);
     Turbine(i,2) = Nodes(i,2);
     T_angle = atan2(Turbine(i,2) - sub_y,Turbine(i,1) - sub_x);
     R_angle = atan2(reference_y,reference_x);
     
     if T_angle<0 
         T_angle = 2*pi + T_angle;
     end
     
     if R_angle<0 
         R_angle = 2*pi + R_angle;
     end
     
     angles(i) = T_angle - R_angle;
     
     if angles(i)<0
         angles(i) = angles(i)+ 2*pi;
     end
end

[angle_sorted,angle_index] = sort(angles); 

for i = 1:Turbine_number
    Turbine_sorted(angle_index(i)) = ceil(i/capacity);   
end

cluster_number = max(Turbine_sorted);

