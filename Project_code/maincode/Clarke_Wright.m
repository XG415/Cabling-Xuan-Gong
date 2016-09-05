for i = 1:cluster_number   
T{i} = find(Turbine_sorted==i);
end


for i = 1 : cluster_number
    
    cluster_distance_matrix{i} = zeros(48,49); % cluster_distance_matrix has the same size as distance matrix
    cluster_saving_matrix{i} =zeros(48,49); %cluster_saving_matrix has the same size as distance matrix

   
    cluster_turbine_number(i) = numel(T{i});
    for j = 1: cluster_turbine_number(i)
        for k = 1: cluster_turbine_number(i)
            if T{i}(j)<T{i}(k)
             cluster_distance_matrix{i}(T{i}(j), T{i}(k)) = distance_matrix(T{i}(j), T{i}(k));
             cluster_saving_matrix{i}(T{i}(j),T{i}(k)) = distance_matrix(T{i}(j),49)+distance_matrix(T{i}(k),49)-distance_matrix(T{i}(j),T{i}(k));
            end
        end  
    end
    
    [saving_sorted,saving_index] = sort(cluster_saving_matrix{i}(:),'descend');
    [m,n] = find(cluster_saving_matrix{i} == saving_sorted(1));
    cluster_route_sequence{i} = [m,n];
    [a,b] = find (cluster_saving_matrix{i} == saving_sorted(2));
    
    l=2;
    while numel(cluster_route_sequence{i})< cluster_turbine_number(i)
        
    [a,b] = find (cluster_saving_matrix{i} == saving_sorted(l));
    
    if (a == cluster_route_sequence{i}(1) && (~ismember(b, cluster_route_sequence{i})))
        cluster_route_sequence{i} = [b,cluster_route_sequence{i}]; l=2;
    elseif (a == cluster_route_sequence{i}(end) && (~ismember(b, cluster_route_sequence{i})))
        cluster_route_sequence{i} = [cluster_route_sequence{i},b]; l=2;
    elseif (b == cluster_route_sequence{i}(1) && (~ismember(a, cluster_route_sequence{i})))
        cluster_route_sequence{i} = [a,cluster_route_sequence{i}]; l=2;
    elseif (b == cluster_route_sequence{i}(end) && (~ismember(a, cluster_route_sequence{i})))
        cluster_route_sequence{i} = [cluster_route_sequence{i},a]; l=2;
    else
        l = l+1;
    end
    
    end
    
    cluster_route_sequence{i} = [49,cluster_route_sequence{i},49]; % the node number of substation is 49
    
end
                
                