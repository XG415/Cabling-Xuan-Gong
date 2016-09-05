G = 5 * 0.33;
%string_cable_price = 83700;
energy_price = 150;
life_time = 25;

string_cluster_number = numel(string_cluster_cable);

d1=50;
total_cost_string_structure = zeros(d1,d1);

for j = 0:d1-1
    r =0.0008+j * (0.015-0.0008)/(d1-1);
for k = 0:d1-1
    MTTR =30*24 + k * (3 * 30 * 24-30*24)/(d1-1);
    
    for e1 = 1:string_cluster_number
        for e2 = 1: numel(string_cluster_cable{e1})
           Cable_availability{e1}(e2) = 1 - r * string_cluster_cable{e1}(e2);
        end
    end
    
    for i =1:string_cluster_number
        string_cluster_turbine_number(i) = numel(string_cluster_cable{i});
   
        %the probability of losing f1 turbines on string i
        for f1 = 1: string_cluster_turbine_number(i)
            string_lose{i}(f1) = 1-Cable_availability{i}(f1);
            if f1<string_cluster_turbine_number(i)
                for f2 = f1+1:string_cluster_turbine_number(i)
                    string_lose{i}(f1) = string_lose{i}(f1)*Cable_availability{i}(f2);
                end
            end
           string_lost_generation{i}(f1) = MTTR * G * f1 * string_lose{i}(f1); 
        end
        string_lost_generation_cluster(i) = sum(string_lost_generation{i});   
    end
    
    total_string_lost_generation = sum(string_lost_generation_cluster);
    string_lost_generation_cost = total_string_lost_generation * life_time * energy_price;
    string_cabling_cost = shortest_string_distance * string_cable_price;
    
    total_cost_string_structure(j+1,k+1) = string_lost_generation_cost + string_cabling_cost;
    
end
end

figure(7)
xx = 0.0008+(0:d1-1) * (0.015-0.0008)/(d1-1);
yy = 30*24 + (0:d1-1) * (3 * 30 * 24-30*24)/(d1-1);
[XX,YY] = meshgrid(xx,yy);
F(:,:,1) = zeros(d1,d1);
F(:,:,2) = 1 + zeros(d1,d1);
F(:,:,3) = zeros(d1,d1);
surf(XX,YY,total_cost_string_structure,F)
xlabel('Cable Availability Failure Rate')
ylabel('MTTR(h)')
zlabel('total cost(pound£©')
title('Total cost of string structure')