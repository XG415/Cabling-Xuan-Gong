
%ring_cable_price = 127600;% cable price (pounds/km£©
energy_price = 150;% energy price (pounds/MWh)
life_time = 25;% the life time of wind farms (years)
G = 5 * 0.33;% turbine rated power (MW)

loop_cluster_number = numel(loop_cluster_cable);

a1 = 50;
total_cost_ring_structure = zeros(a1,a1);
total_cost_multi_loop_structure = zeros(a1,a1);

for j = 0:a1-1
    r = 0.0008+j * (0.015-0.0008)/(a1-1);
   
for k = 0:a1-1
   MTTR =30*24 + k * (3 * 30 * 24-30*24)/(a1-1);
   
   for b1 = 1:loop_cluster_number
       W(b1) = 1;
       for b2 = 1: numel(loop_cluster_cable{b1})
           Availability{b1}(b2) = 1 - r * loop_cluster_cable{b1}(b2);
       W(b1) = W(b1) * Availability{b1}(b2);   
       end
   end
   
   % the situation that there is only one cable down on one loop
    for b1 = 1:loop_cluster_number
        loop_cluster_cable_number(b1) = numel(loop_cluster_cable{b1});
        loop_cluster_turbine_number(b1) = loop_cluster_cable_number(b1)-1;
         
       for b2 = 1: loop_cluster_cable_number(b1)
           lose{b1}(b2) = (1-Availability{b1}(b2)) * (W(b1)/Availability{b1}(b2)); % the probabilty of only losing b2th cable
           string_1_turbine_number = b2 -1;
           string_2_turbine_number = loop_cluster_turbine_number(b1) - (b2-1);%one loop breaks into two strings
           
           if string_1_turbine_number>cable_capacity
               lose_turbine_number{b1}(b2) = string_1_turbine_number - cable_capacity;
           elseif string_2_turbine_number>cable_capacity
           lose_turbine_number{b1}(b2) = string_2_turbine_number - cable_capacity;
           else
               lose_turbine_number{b1}(b2) =0;
           end 
           lost_generation{b1}(b2) = MTTR * G * lose_turbine_number{b1}(b2) * lose{b1}(b2);   
       end
     one_cable_lost_generation_loop(b1) = sum(lost_generation{b1});   
    end
     one_cable_lost_generation = sum (one_cable_lost_generation_loop);
   
     
     
     
     
   %the situation that there are two cables down on one loop
   for  b1 = 1:loop_cluster_number
       two_lose{b1} = zeros(loop_cluster_cable_number(b1),loop_cluster_cable_number(b1));
       
       for b2 = 1: numel(loop_cluster_cable{b1})
           for b3 = 1: numel(loop_cluster_cable{b1})
               if b2<b3
                   two_lose{b1}(b2,b3) = (1-Availability{b1}(b2))*(1-Availability{b1}(b3)) * (W(b1)/(Availability{b1}(b2)*Availability{b1}(b3)));
             
                   string_1_turbine_number = b2-1;
                  disconnected_turbine_number = b3-b2;
                  string_2_turbine_number = loop_cluster_turbine_number(b1) - (b3-1);
                  
          if string_1_turbine_number>cable_capacity
              exceeded_turbine_number = string_1_turbine_number - cable_capacity;
           elseif string_2_turbine_number>cable_capacity
              exceeded_turbine_number = string_2_turbine_number - cable_capacity;
           else
               exceeded_turbine_number =0;
          end
               
          two_lose_turbine_number{b1}(b2,b3) = disconnected_turbine_number + exceeded_turbine_number;
          two_lost_generation{b1}(b2,b3) = MTTR * G * two_lose_turbine_number{b1}(b2,b3) * two_lose{b1}(b2,b3);        
               end        
           end
       end
       two_cable_lost_generation_loop(b1) = sum(sum(two_lost_generation{b1}));
   end
   two_cable_lost_generation = sum (two_cable_lost_generation_loop); 
   
   total_lost_generation = one_cable_lost_generation + two_cable_lost_generation;
   lost_generation_cost = total_lost_generation * life_time * energy_price;
   cabling_cost = ring_distance * ring_cable_price;
   total_cost_ring_structure(j+1,k+1) = lost_generation_cost + cabling_cost;
   
   
   lost_generation_multi_loop_structure = two_cable_lost_generation/3;
   lost_generation_cost_multi_loop_structure = lost_generation_multi_loop_structure * life_time * energy_price;
   cabling_cost_multi_loop_structure = shortest_multi_loop_distance * ring_cable_price;
   total_cost_multi_loop_structure(j+1,k+1) = lost_generation_cost_multi_loop_structure + cabling_cost_multi_loop_structure;
   
end
end

xx = 0.0008+(0:a1-1) * (0.015-0.0008)/(a1-1);
yy = 30*24 + (0:a1-1) * (3 * 30 * 24-30*24)/(a1-1);
[XX,YY] = meshgrid(xx,yy);
D(:,:,1) = 1 + zeros(a1,a1);
D(:,:,2) = 1 + zeros(a1,a1);
D(:,:,3) = zeros(a1,a1);
E(:,:,1) =1+ zeros(a1,a1);
E(:,:,2) = 0 + zeros(a1,a1);
E(:,:,3) = zeros(a1,a1);

figure(8)
 surf(XX,YY,total_cost_ring_structure,D);
 title('Total cost of ring structure')
 xlabel('Cable Availability Failure Rate')
ylabel('MTTR(h)')
zlabel('total cost(pound£©')
title('Total cost of ring structure')

 figure(9)
 surf(XX,YY,total_cost_multi_loop_structure,E);
 title('Total cost of multi-loop structure')
xlabel('Cable Availability Failure Rate')
ylabel('MTTR(h)')
zlabel('total cost(pound£©')
title('Total cost of multi-loop structure')
    