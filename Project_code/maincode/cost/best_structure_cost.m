string_structure_cost
clearvars -except total_cost_string_structure
 
ring_multi_loop_structure_cost
clearvars -except total_cost_string_structure total_cost_ring_structure total_cost_multi_loop_structure

A = total_cost_string_structure;
B = total_cost_ring_structure;
C = total_cost_multi_loop_structure;
b = 50;

for i = 1:b
    for j= 1:b
   D = [A(i,j),B(i,j),C(i,j)];
   [a,c] = min(D);
   E(i,j) = a;
   if c==1
   F(i,j,1) = 0;
   F(i,j,2) = 1;
   F(i,j,3) = 0;
   elseif c==2
   F(i,j,1) = 1;
   F(i,j,2) = 1;
   F(i,j,3) = 0;
   else
       F(i,j,1) = 1;
       F(i,j,2) = 0;
       F(i,j,3) = 0;
   end
       
    end
end 
figure(4)
x = 0.0008+(0:b-1) * (0.015-0.0008)/(b-1);
y = 30*24 + (0:b-1) * (3 * 30 * 24-30*24)/(b-1);
[X,Y] = meshgrid(x,y);
surf(X,Y,E,F);
xlabel('Cable Availability Failure Rate')
ylabel('MTTR(h)')
zlabel('total cost(pound£©')
title('Best choice')
figure(5)
surf(X,Y,E,F);
view(0,90)
xlabel('Cable Availability Failure Rate')
ylabel('MTTR(h)')
title('Best choice')
