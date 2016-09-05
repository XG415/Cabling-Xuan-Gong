capacity = 2 * string_capacity;


v = string_distance_index(1);

reference_x = Reference_X(v);
reference_y = Reference_Y(v);

sweep_cluster
Clarke_Wright

%%
figure(5)
plot3(A,B,C,'r*','LineWidth',3);
hold on


trisurf(faces,seaX,seaY,seaZ,'FaceColor', 'w', 'EdgeColor', 'k')
hold on;

axis equal


cluster_distance = zeros(cluster_number,1);

for i = 1: cluster_number-1
    e = numel(cluster_route_sequence{i});
    
    for j = 1 : string_capacity
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
            path_z = path_matrix{c,d}(:,3);
            path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
            path_z = path_matrix{d,c}(:,3);
            path_distance = distance_matrix(d,c);
        end
          plot3(path_x, path_y,path_z,'LineWidth',2)
          hold on;
        % cluster_distance(i) = cluster_distance(i) +  path_distance
        string_cluster_cable{2*i-1}(j) = path_distance/10;
    end
     string_cluster_cable{2*i-1} = fliplr(string_cluster_cable{2*i-1});
     string_cluster{2*i-1} = fliplr(cluster_route_sequence{i}(1: string_capacity + 1));
    
    for j = string_capacity + 2 : e-1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
            path_z = path_matrix{c,d}(:,3);
            path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
            path_z = path_matrix{d,c}(:,3);
            path_distance = distance_matrix(d,c);
        end
          plot3(path_x, path_y,path_z,'LineWidth',2)
          hold on;
          string_cluster_cable{2*i}(j-(string_capacity + 1)) = path_distance/10;
        % cluster_distance(i) = cluster_distance(i) +  path_distance;
    end
    
   % total_distance = sum(cluster_distance);
   string_cluster{2*i} = cluster_route_sequence{i}(string_capacity + 2 : end);
end



i = cluster_number;
e = numel(cluster_route_sequence{i});

%%
if e -2 <= string_capacity
   
    % string saving algorithm
    string_distance_1 = 0;
    string_distance_2 = 0;
    string_distance_3 = 0;
    string_saving_matrix = zeros(size(Nodes,1),size(Nodes,1));
    for j = 1: cluster_turbine_number(i)
        for k = 1: cluster_turbine_number(i)
            if j~=k
            string_saving_matrix(T{i}(j),T{i}(k)) = distance_matrix(T{i}(j),size(Nodes,1))-distance_matrix(min(T{i}(j),T{i}(k)),max(T{i}(j),T{i}(k)));
            end
        end
    end
    
 [string_saving_sorted,string_saving_index] = sort(string_saving_matrix(:),'descend');   
 
 l=1;
 while string_saving_sorted(l) == 0
     l=l+1;
 end
 
 [m,n] = find(string_saving_matrix == string_saving_sorted(l));
 string_route_sequence = [m,n];

 
 
    l=2;
    while numel(string_route_sequence)<cluster_turbine_number(i)
    if string_saving_sorted(l)~=0  
    [aa,bb] = find (string_saving_matrix == string_saving_sorted(l));
    end
    
     if (aa == string_route_sequence(end) && (~ismember(bb, string_route_sequence)))
        string_route_sequence = [string_route_sequence,bb]; l=2;
     else
        l = l+1;
     end
     end
    
    string_route_sequence = [string_route_sequence,size(Nodes,1)]; % the node number of substation is 49
        
 for j = 1 : numel(string_route_sequence)-1
        c = string_route_sequence(j);
        d = string_route_sequence(j + 1);

            path_distance = distance_matrix(min(c,d),max(c,d));
            string_distance_1 = string_distance_1 +  path_distance;
 end

%%

   for j = 1 : e-2
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1); 
            path_distance = distance_matrix(min([c,d]),max([c,d]));
            string_distance_2 = string_distance_2 +  path_distance;
   end
   
      for j = 2 : e-1 
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1); 
        path_distance = distance_matrix(min([c,d]),max([c,d]));
        string_distance_3 = string_distance_3 +  path_distance;
      end

   
 %% compare
 if string_distance_1 == min([string_distance_1, string_distance_2, string_distance_3])
   for j = 1 : numel(string_route_sequence)-1
        c = string_route_sequence(j);
        d = string_route_sequence(j + 1);

             path_x = path_matrix{min(c,d),max(c,d)}(:,1);
             path_y = path_matrix{min(c,d),max(c,d)}(:,2);
             path_z = path_matrix{min(c,d),max(c,d)}(:,3);
             path_distance = distance_matrix(min(c,d),max(c,d));
             plot3(path_x, path_y,path_z,'LineWidth',2)
             hold on;
          string_cluster_cable{2*i-1}(j) = path_distance/10;
   end
  % string_cluster_cable{2*i-1} = fliplr(string_cluster_cable{2*i-1});
   string_cluster{2*i-1} = string_route_sequence;
   
 else if string_distance_2 == min([string_distance_1, string_distance_2, string_distance_3])
     for j = 1 : e-2
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1); 
             path_x = path_matrix{min(c,d),max(c,d)}(:,1);
             path_y = path_matrix{min(c,d),max(c,d)}(:,2);
             path_z = path_matrix{min(c,d),max(c,d)}(:,3);
             path_distance = distance_matrix(min(c,d),max(c,d));
             plot3(path_x, path_y,path_z,'LineWidth',2)
             hold on;
         string_cluster_cable{2*i-1}(j) = path_distance/10;
     end
     string_cluster_cable{2*i-1} = fliplr(string_cluster_cable{2*i-1});
     string_cluster{2*i-1} = fliplr(cluster_route_sequence{i}(1:e-1));
     
     else
          for j = 2 : e-1 
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1); 
             path_x = path_matrix{min(c,d),max(c,d)}(:,1);
             path_y = path_matrix{min(c,d),max(c,d)}(:,2);
             path_z = path_matrix{min(c,d),max(c,d)}(:,3);
             path_distance = distance_matrix(min(c,d),max(c,d));
             plot3(path_x, path_y,path_z,'LineWidth',2)
             hold on;
             string_cluster_cable{2*i-1}(j-1) = path_distance/10;
          end
          string_cluster{2*i-1} = cluster_route_sequence{i}(2:e);
     end
 end
 
end 

 %%
if e -2 == 2 * string_capacity
   for j = 1 : string_capacity
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
            path_z = path_matrix{c,d}(:,3);
         %   path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
            path_z = path_matrix{d,c}(:,3);
            path_distance = distance_matrix(d,c);
        end
          plot3(path_x, path_y,path_z,'LineWidth',2)
          hold on;
          string_cluster_cable{2*i-1}(j) = path_distance/10;
        % cluster_distance(i) = cluster_distance(i) +  path_distance;
   end
    string_cluster_cable{2*i-1} = fliplr(string_cluster_cable{2*i-1});
    string_cluster{2*i-1} = fliplr(cluster_route_sequence{i}(1 : string_capacity+1));
    
    
    for j = string_capacity + 2 : e-1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
            path_z = path_matrix{c,d}(:,3);
            path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
            path_z = path_matrix{d,c}(:,3);
           path_distance = distance_matrix(d,c);
        end
          plot3(path_x, path_y,path_z,'LineWidth',2)
          hold on;
          string_cluster_cable{2*i}(j-(string_capacity + 1)) = path_distance/10;
        % cluster_distance(i) = cluster_distance(i) +  path_distance;
    end
    string_cluster{2*i} = cluster_route_sequence{i}(string_capacity + 2 : e-1);

end

%%
if e-2 > string_capacity && e-2 < 2 * string_capacity
        for j = e-1-string_capacity : string_capacity + 1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        string_path_distance(j) = distance_matrix(min(c,d), max(c,d));
    end
    
[max_string_path_distance,  max_string_path_distance_index] = max(string_path_distance);

 for j = 1 : max_string_path_distance_index - 1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
            path_z = path_matrix{c,d}(:,3);
            path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
            path_z = path_matrix{d,c}(:,3);
            path_distance = distance_matrix(d,c);
        end
          plot3(path_x, path_y,path_z,'LineWidth',2)
          hold on;
         string_cluster_cable{2*i-1}(j) = path_distance/10;
        % cluster_distance(i) = cluster_distance(i) +  path_distance;
 end
 
  string_cluster_cable{2*i-1} = fliplr(string_cluster_cable{2*i-1});
 string_cluster{2*i-1} = fliplr(cluster_route_sequence{i}(1 : max_string_path_distance_index));
   
    
    for j = max_string_path_distance_index + 1 : e-1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
            path_z = path_matrix{c,d}(:,3);
            path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
            path_z = path_matrix{d,c}(:,3);
            path_distance = distance_matrix(d,c);
        end
          plot3(path_x, path_y,path_z,'LineWidth',2)
          hold on;
        % cluster_distance(i) = cluster_distance(i) +  path_distance;
        string_cluster_cable{2*i}(j-max_string_path_distance_index)= path_distance/10;
    end
string_cluster{2*i} = cluster_route_sequence{i}(max_string_path_distance_index+1 : e);
    
end




















%% This is for plane string graph
figure(6)

cluster_distance = zeros(cluster_number,1);

plot(A,B,'b*','LineWidth',2);
axis equal
axis([-24 24 -48 48])
hold on

for i = 1: cluster_number-1
    e = numel(cluster_route_sequence{i});
    
    for j = 1 : string_capacity
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
%             path_z = path_matrix{c,d}(:,3);
            path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
%             path_z = path_matrix{d,c}(:,3);
           path_distance = distance_matrix(d,c);
        end
          plot(path_x, path_y,'LineWidth',2)
          hold on;
         cluster_distance(i) = cluster_distance(i) +  path_distance;
    end
    
    for j = string_capacity + 2 : e-1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
            %path_z = path_matrix{c,d}(:,3);
            path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
            %path_z = path_matrix{d,c}(:,3);
            path_distance = distance_matrix(d,c);
        end
          plot(path_x, path_y,'LineWidth',2)
          hold on;
          cluster_distance(i) = cluster_distance(i) +  path_distance;
    end
 
end
    
i = cluster_number;
e = numel(cluster_route_sequence{i});    
 
%%
if e -2 <= string_capacity
   
    % string saving algorithm
    string_distance_1 = 0;
    string_distance_2 = 0;
    string_distance_3 = 0;
    string_saving_matrix = zeros(size(Nodes,1),size(Nodes,1));
    for j = 1: cluster_turbine_number(i)
        for k = 1: cluster_turbine_number(i)
            if j~=k
            string_saving_matrix(T{i}(j),T{i}(k)) = distance_matrix(T{i}(j),size(Nodes,1))-distance_matrix(min(T{i}(j),T{i}(k)),max(T{i}(j),T{i}(k)));
            end
        end
    end
    
 [string_saving_sorted,string_saving_index] = sort(string_saving_matrix(:),'descend'); 
 
 l=1;
 while string_saving_sorted(l) == 0
     l=l+1;
 end
 
 [m,n] = find(string_saving_matrix == string_saving_sorted(l));
 string_route_sequence = [m,n];

    l=2;
    while numel(string_route_sequence)<cluster_turbine_number(i)
    if string_saving_sorted(l)~=0  
    [aa,bb] = find (string_saving_matrix == string_saving_sorted(l));
    end
    
     if (aa == string_route_sequence(end) && (~ismember(bb, string_route_sequence)))
        string_route_sequence = [string_route_sequence,bb]; l=2;
     else
        l = l+1;
     end
     end
    
    string_route_sequence = [string_route_sequence,size(Nodes,1)]; % the node number of substation is 49
        
 for j = 1 : numel(string_route_sequence)-1
        c = string_route_sequence(j);
        d = string_route_sequence(j + 1);

            path_distance = distance_matrix(min(c,d),max(c,d));
            string_distance_1 = string_distance_1 +  path_distance;
 end

%%

   for j = 1 : e-2
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1); 
            path_distance = distance_matrix(min([c,d]),max([c,d]));
            string_distance_2 = string_distance_2 +  path_distance;
   end
   
      for j = 2 : e-1 
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1); 
        path_distance = distance_matrix(min([c,d]),max([c,d]));
        string_distance_3 = string_distance_3 +  path_distance;
      end

   
 %% compare
 if string_distance_1 == min([string_distance_1, string_distance_2, string_distance_3])
   for j = 1 : numel(string_route_sequence)-1
        c = string_route_sequence(j);
        d = string_route_sequence(j + 1);

             path_x = path_matrix{min(c,d),max(c,d)}(:,1);
             path_y = path_matrix{min(c,d),max(c,d)}(:,2);
            % path_z = path_matrix{min(c,d),max(c,d)}(:,3);
              plot(path_x, path_y,'LineWidth',2)
              hold on;
   end
 else if string_distance_2 == min([string_distance_1, string_distance_2, string_distance_3])
     for j = 1 : e-2
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1); 
             path_x = path_matrix{min(c,d),max(c,d)}(:,1);
             path_y = path_matrix{min(c,d),max(c,d)}(:,2);
            % path_z = path_matrix{min(c,d),max(c,d)}(:,3);
              plot(path_x, path_y,'LineWidth',2)
              hold on;
     end
     else
          for j = 2 : e-1 
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1); 
             path_x = path_matrix{min(c,d),max(c,d)}(:,1);
             path_y = path_matrix{min(c,d),max(c,d)}(:,2);
            % path_z = path_matrix{min(c,d),max(c,d)}(:,3);
              plot(path_x, path_y,'LineWidth',2)
              hold on;
          end
     end
 end
 cluster_distance(i) = min([string_distance_1, string_distance_2, string_distance_3]);
end
 
 %%
if e -2 == 2 * string_capacity
   for j = 1 : string_capacity
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
           % path_z = path_matrix{c,d}(:,3);
            path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
           % path_z = path_matrix{d,c}(:,3);
            path_distance = distance_matrix(d,c);
        end
           plot(path_x, path_y,'LineWidth',2)
           hold on;
         cluster_distance(i) = cluster_distance(i) +  path_distance;
    end
    
    for j = string_capacity + 2 : e-1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
           % path_z = path_matrix{c,d}(:,3);
            path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
           % path_z = path_matrix{d,c}(:,3);
            path_distance = distance_matrix(d,c);
        end
           plot(path_x, path_y,'LineWidth',2)
           hold on;
         cluster_distance(i) = cluster_distance(i) +  path_distance;
    end
 
end

%%
if e-2 > string_capacity && e-2 < 2 * string_capacity
        for j = e-1-string_capacity : string_capacity + 1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        string_path_distance(j) = distance_matrix(min(c,d), max(c,d));
    end
    
[max_string_path_distance,  max_string_path_distance_index] = max(string_path_distance);

 for j = 1 : max_string_path_distance_index - 1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
           % path_z = path_matrix{c,d}(:,3);
            path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
           % path_z = path_matrix{d,c}(:,3);
            path_distance = distance_matrix(d,c);
        end
           plot(path_x, path_y,'LineWidth',2)
           hold on;
         cluster_distance(i) = cluster_distance(i) +  path_distance;
    end
    
    for j = max_string_path_distance_index + 1 : e-1
        c = cluster_route_sequence{i}(j);
        d = cluster_route_sequence{i}(j + 1);
        
        if c<d
            path_x = path_matrix{c,d}(:,1);
            path_y = path_matrix{c,d}(:,2);
           % path_z = path_matrix{c,d}(:,3);
            path_distance = distance_matrix(c,d);
        else
            path_x = path_matrix{d,c}(:,1);
            path_y = path_matrix{d,c}(:,2);
           % path_z = path_matrix{d,c}(:,3);
            path_distance = distance_matrix(d,c);
        end
           plot(path_x, path_y,'LineWidth',2)
           hold on;
         cluster_distance(i) = cluster_distance(i) +  path_distance;
    end

end

    
 string_total_distance = sum(cluster_distance)/10;
    
title(sprintf('string distance = %f km', string_total_distance))