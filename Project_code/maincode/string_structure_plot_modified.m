clear string
capacity = 2 * string_capacity;


v = string_distance_index(1);
%v = distance_index(1);



reference_x = Reference_X(v);
reference_y = Reference_Y(v);

sweep_cluster
Clarke_Wright

%%
figure(5)
plot3(A,B,C,'r*','LineWidth',3);
hold on
plot3(A_end, B_end, C_end,'g*','LineWidth',3);
hold on

trisurf(faces,seaX,seaY,seaZ,'FaceColor', 'w', 'EdgeColor', 'k')
hold on;

axis equal


%cutting cable

for i = 1: cluster_number-1
    for j = 1 : string_capacity + 1
        
     string_route_sequence_1{2*i-1}(j) = cluster_route_sequence{i}(j);
     string_route_sequence_1{2*i}(j) = cluster_route_sequence{i}(j+1+string_capacity);
    end       
    string_route_sequence_1{2*i-1} = fliplr(string_route_sequence_1{2*i-1}) ;
    
end

for i = 1:numel(string_route_sequence_1)
    
    s_distance_1(i) = 0;
    
    for j = 1 : string_capacity
        c = string_route_sequence_1{i}(j);
        d = string_route_sequence_1{i}(j + 1);
        path_distance = distance_matrix(min(c,d),max(c,d));
        s_distance_1(i) = s_distance_1(i) + path_distance;
    end
   
end

      

% string algorithm
for i = 1: cluster_number-1
    for j = 1 : string_capacity
     string{2*i-1}(j) = cluster_route_sequence{i}(j+1);  
     string{2*i}(j) = cluster_route_sequence{i}(j+1+string_capacity);
    end   
end

string_number = 2*(cluster_number-1);
for i = 1:string_number
    
     string_saving_matrix{i} = zeros(size(Nodes,1),size(Nodes,1));
     
     for  string_number_1 = 1: numel(string{i})
        for  string_number_2 = 1: numel(string{i})
            if string_number_1~=string_number_2
            string_saving_matrix{i}(string{i}(string_number_1),string{i}(string_number_2)) = distance_matrix(string{i}(string_number_1),size(Nodes,1))-distance_matrix(min(string{i}(string_number_1),string{i}(string_number_2)),max(string{i}(string_number_1),string{i}(string_number_2)));
            end
        end
    end
     
 [string_saving_sorted{i},string_saving_index{i}] = sort(string_saving_matrix{i}(:),'descend'); 
 
 l=1;
 while string_saving_sorted{i}(l) == 0
     l=l+1;
 end
 
 [m,n] = find(string_saving_matrix{i} == string_saving_sorted{i}(l));
 string_route_sequence_2{i} = [m,n];

    l=2;
    while numel(string_route_sequence_2{i})<numel(string{i})
    if string_saving_sorted{i}(l)~=0  
    [aa,bb] = find (string_saving_matrix{i} == string_saving_sorted{i}(l));
    end
    
     if (aa == string_route_sequence_2{i}(end) && (~ismember(bb, string_route_sequence_2{i})))
        string_route_sequence_2{i} = [string_route_sequence_2{i},bb]; l=2;
     else
        l = l+1;
     end
     end
    
    string_route_sequence_2{i} = [string_route_sequence_2{i},size(Nodes,1)]; 
    
     s_distance_2(i) = 0;
     
     for j = 1 : numel(string_route_sequence_2{i})-1
        c = string_route_sequence_2{i}(j);
        d = string_route_sequence_2{i}(j + 1);
         path_distance = distance_matrix(min(c,d),max(c,d));
         s_distance_2(i) = s_distance_2(i) +  path_distance;
            
     end    
end



for i = 1 : numel(string)
    s_distance(i) = min(s_distance_1(i),s_distance_2(i));
    
    if s_distance(i) == s_distance_1(i)    
    string_route_sequence{i} = string_route_sequence_1{i};
    else
        string_route_sequence{i} = string_route_sequence_2{i};
    end
    

    for j = 1 : numel(string_route_sequence{i})-1
        c = string_route_sequence{i}(j);
        d = string_route_sequence{i}(j + 1);
        
        path_x = path_matrix{min(c,d),max(c,d)}(:,1);
        path_y = path_matrix{min(c,d),max(c,d)}(:,2);
        path_z = path_matrix{min(c,d),max(c,d)}(:,3);
        path_distance = distance_matrix(min(c,d),max(c,d));
        
        plot3(path_x, path_y,path_z,'LineWidth',2)
        hold on;
        string_cluster_cable{i}(j) = path_distance/10;
    end
end
    
        
    




%this is for the last cluster   
i = cluster_number;
e = numel(cluster_route_sequence{i});

 
%%
if e -2 <= string_capacity
    string_distance_1 = 0;
    string_distance_2 = 0;
    string_distance_3 = 0;
    string_saving_matrix{string_number+1} = zeros(size(Nodes,1),size(Nodes,1));
    
    for j = 1: cluster_turbine_number(i)
        for k = 1: cluster_turbine_number(i)
            if j~=k
            string_saving_matrix{string_number+1}(T{i}(j),T{i}(k)) = distance_matrix(T{i}(j),size(Nodes,1))-distance_matrix(min(T{i}(j),T{i}(k)),max(T{i}(j),T{i}(k)));
            end
        end
    end
    
 [string_saving_sorted{string_number+1},string_saving_index{string_number+1}] = sort(string_saving_matrix{string_number+1}(:),'descend'); 
 
 l=1;
 while string_saving_sorted{string_number+1}(l) == 0
     l=l+1;
 end
 
 [m,n] = find(string_saving_matrix{string_number+1} == string_saving_sorted{string_number+1}(l));
 string_route_sequence_2{string_number+1} = [m,n];

    l=2;
    while numel(string_route_sequence_2{string_number+1})<cluster_turbine_number(i)
    if string_saving_sorted{string_number+1}(l)~=0  
    [aa,bb] = find (string_saving_matrix{string_number+1} == string_saving_sorted{string_number+1}(l));
    end
    
     if (aa == string_route_sequence_2{string_number+1}(end) && (~ismember(bb, string_route_sequence_2{string_number+1})))
        string_route_sequence_2{string_number+1} = [string_route_sequence_2{string_number+1},bb]; l=2;
     else
        l = l+1;
     end
     end
    
    string_route_sequence_2{string_number+1} = [string_route_sequence_2{string_number+1},size(Nodes,1)]; 
        
 for j = 1 : numel(string_route_sequence_2{string_number+1})-1
        c = string_route_sequence_2{string_number+1}(j);
        d = string_route_sequence_2{string_number+1}(j + 1);

            path_distance = distance_matrix(min(c,d),max(c,d));
            string_distance_2 = string_distance_2 +  path_distance;
 end


 
 
   for j = 1 : e-1
     string_route_sequence_cut_cable_2(j) = cluster_route_sequence{i}(j);
   end
     string_route_sequence_cut_cable_2 = fliplr(string_route_sequence_cut_cable_2);
    
  for j = 1 : e-2   
        c = string_route_sequence_cut_cable_2(j);
        d = string_route_sequence_cut_cable_2(j + 1); 
            path_distance = distance_matrix(min([c,d]),max([c,d]));
            string_distance_1 = string_distance_1 +  path_distance;
    end
  
   
      for j = 2 : e 
       string_route_sequence_cut_cable_1(j-1) = cluster_route_sequence{i}(j);
      end
      for j = 1 : e-2     
      c = string_route_sequence_cut_cable_1(j);
      d = string_route_sequence_cut_cable_1(j + 1); 
      path_distance = distance_matrix(min([c,d]),max([c,d]));
        string_distance_3 = string_distance_3 +  path_distance;
      end

 s_distance(string_number+1) = min([string_distance_1, string_distance_2, string_distance_3]);
 
 if s_distance(string_number+1) == string_distance_1
    string_route_sequence{string_number+1} = string_route_sequence_cut_cable_2;
 elseif s_distance(string_number+1) == string_distance_2
    string_route_sequence{string_number+1} = string_route_sequence_2{string_number+1};
 else
    string_route_sequence{string_number+1} = string_route_sequence_cut_cable_1;
 end
 
 
  for j = 1 : numel(string_route_sequence{string_number+1})-1
        c = string_route_sequence{string_number+1}(j);
        d = string_route_sequence{string_number+1}(j + 1);
        
        path_x = path_matrix{min(c,d),max(c,d)}(:,1);
        path_y = path_matrix{min(c,d),max(c,d)}(:,2);
        path_z = path_matrix{min(c,d),max(c,d)}(:,3);
        path_distance = distance_matrix(min(c,d),max(c,d));
        
        plot3(path_x, path_y,path_z,'LineWidth',2)
        hold on;
        string_cluster_cable{string_number+1}(j) = path_distance/10;
        
    end
 
 
end


 %%

 if e -2 == 2 * string_capacity
  
    for j = 1 : string_capacity + 1
        
     string_route_sequence_1{2*i-1}(j) = cluster_route_sequence{i}(j);
     string_route_sequence_1{2*i}(j) = cluster_route_sequence{i}(j+1+string_capacity);
    end       
    string_route_sequence_1{2*i-1} = fliplr(string_route_sequence_1{2*i-1}) ;
 
    
for k = string_number+1 : string_number+2
    s_distance_1(k) = 0;
    
    for j = 1 : string_capacity
        c = string_route_sequence_1{k}(j);
        d = string_route_sequence_1{k}(j + 1);
        path_distance = distance_matrix(min(c,d),max(c,d));
        s_distance_1(k) = s_distance_1(k) + path_distance;
    end

end

      

% string algorithm
    for j = 1 : string_capacity
     string{2*i-1}(j) = cluster_route_sequence{i}(j+1);  
     string{2*i}(j) = cluster_route_sequence{i}(j+1+string_capacity);
    end   

for k = string_number+1 : string_number+2
    
     string_saving_matrix{k} = zeros(size(Nodes,1),size(Nodes,1));
     
     for  string_number_1 = 1: numel(string{k})
        for  string_number_2 = 1: numel(string{k})
            if string_number_1~=string_number_2
            string_saving_matrix{k}(string{k}(string_number_1),string{k}(string_number_2)) = distance_matrix(string{k}(string_number_1),size(Nodes,1))-distance_matrix(min(string{k}(string_number_1),string{k}(string_number_2)),max(string{k}(string_number_1),string{k}(string_number_2)));
            end
        end
    end
     
 [string_saving_sorted{k},string_saving_index{k}] = sort(string_saving_matrix{k}(:),'descend'); 
 
 l=1;
 while string_saving_sorted{k}(l) == 0
     l=l+1;
 end
 
 [m,n] = find(string_saving_matrix{k} == string_saving_sorted{k}(l));
 string_route_sequence_2{k} = [m,n];

    l=2;
    while numel(string_route_sequence_2{k})<numel(string{k})
    if string_saving_sorted{k}(l)~=0  
    [aa,bb] = find (string_saving_matrix{k} == string_saving_sorted{k}(l));
    end
    
     if (aa == string_route_sequence_2{k}(end) && (~ismember(bb, string_route_sequence_2{k})))
        string_route_sequence_2{k} = [string_route_sequence_2{k},bb]; l=2;
     else
        l = l+1;
     end
     end
    
    string_route_sequence_2{k} = [string_route_sequence_2{k},size(Nodes,1)]; 
    
     s_distance_2(k) = 0;
     
     for j = 1 : numel(string_route_sequence_2{k})-1
        c = string_route_sequence_2{k}(j);
        d = string_route_sequence_2{k}(j + 1);
         path_distance = distance_matrix(min(c,d),max(c,d));
         s_distance_2(k) = s_distance_2(k) +  path_distance;
            
     end    
end
 
for k = string_number+1 : string_number+2
    s_distance(k) = min(s_distance_1(k),s_distance_2(k));
    
    if s_distance(k) == s_distance_1(k)    
    string_route_sequence{k} = string_route_sequence_1{k};
    else
        string_route_sequence{k} = string_route_sequence_2{k};
    end
    
    for j = 1 : numel(string_route_sequence{k})-1
        c = string_route_sequence{k}(j);
        d = string_route_sequence{k}(j + 1);
        
        path_x = path_matrix{min(c,d),max(c,d)}(:,1);
        path_y = path_matrix{min(c,d),max(c,d)}(:,2);
        path_z = path_matrix{min(c,d),max(c,d)}(:,3);
        path_distance = distance_matrix(min(c,d),max(c,d));
        
        plot3(path_x, path_y,path_z,'LineWidth',2)
        hold on;
        
        string_cluster_cable{k}(j) = path_distance/10;
    end
end

end

%%
if e-2 > string_capacity && e-2 < 2 * string_capacity
    
    for k = e-1-string_capacity : string_capacity + 1
     k_no = k - (e-1-string_capacity) + 1;
            
     %cutting cable
     string_route_sequence_3{k_no,1} = cluster_route_sequence{i}(1:k);     
     string_route_sequence_3{k_no,1} = fliplr(string_route_sequence_3{k_no,1});
     string_route_sequence_3{k_no,2} = cluster_route_sequence{i}(k+1:end);
     
    
    for jj = 1:2
        st_distance_1(k_no,jj) = 0; 
    for j = 1 : numel(string_route_sequence_3{k_no,jj})-1
        c = string_route_sequence_3{k_no,jj}(j);
        d = string_route_sequence_3{k_no,jj}(j + 1);
        path_distance = distance_matrix(min(c,d),max(c,d));
        st_distance_1(k_no,jj) = st_distance_1(k_no,jj) + path_distance;
    end
    end

    
    
    %string algorithm
     string_2{k_no,1} = string_route_sequence_3{k_no,1}(1:end-1);
     string_2{k_no,2} = string_route_sequence_3{k_no,2}(1:end-1);
       
     
    for jj = 1:2
    
     string_saving_matrix_2{k_no,jj} = zeros(size(Nodes,1),size(Nodes,1));
     
     for  string_number_1 = 1: numel(string_2{k_no,jj})
        for  string_number_2 = 1: numel(string_2{k_no,jj})
            if string_number_1~=string_number_2
            string_saving_matrix_2{k_no,jj}(string_2{k_no,jj}(string_number_1),string_2{k_no,jj}(string_number_2)) = distance_matrix(string_2{k_no,jj}(string_number_1),size(Nodes,1))-distance_matrix(min(string_2{k_no,jj}(string_number_1),string_2{k_no,jj}(string_number_2)),max(string_2{k_no,jj}(string_number_1),string_2{k_no,jj}(string_number_2)));
            end
        end
    end
     
 [string_saving_sorted_2{k_no,jj},string_saving_index_2{k_no,jj}] = sort(string_saving_matrix_2{k_no,jj}(:),'descend'); 
 
 l=1;
 while string_saving_sorted_2{k_no,jj}(l) == 0
     l=l+1;
 end
 
 [m,n] = find(string_saving_matrix_2{k_no,jj} == string_saving_sorted_2{k_no,jj}(l));
 string_route_sequence_4{k_no,jj} = [m,n];

    l=2;
    while numel(string_route_sequence_4{k_no,jj})<numel(string_2{k_no,jj})
        
      
    if string_saving_sorted_2{k_no,jj}(l)~=0  
    [aa,bb] = find (string_saving_matrix_2{k_no,jj} == string_saving_sorted_2{k_no,jj}(l));
    end
    
     if (aa == string_route_sequence_4{k_no,jj}(end) && (~ismember(bb, string_route_sequence_4{k_no,jj})))
        string_route_sequence_4{k_no,jj} = [string_route_sequence_4{k_no,jj},bb]; l=2;
     else
        l = l+1;
     end
     end
    
    string_route_sequence_4{k_no,jj} = [string_route_sequence_4{k_no,jj},size(Nodes,1)]; 
    
    end
    
 
    for jj = 1:2
        st_distance_2(k_no,jj) = 0; 
    for j = 1 : numel(string_route_sequence_4{k_no,jj})-1
        c = string_route_sequence_4{k_no,jj}(j);
        d = string_route_sequence_4{k_no,jj}(j + 1);
        path_distance = distance_matrix(min(c,d),max(c,d));
        st_distance_2(k_no,jj) = st_distance_2(k_no,jj) + path_distance;
    end
    end
    
    total_st_distance_1(k_no) = st_distance_1(k_no,1) + st_distance_1(k_no,2);
    total_st_distance_2(k_no) = st_distance_2(k_no,1) + st_distance_2(k_no,2);      
    end
    
    total_st_distance = [ total_st_distance_1; total_st_distance_2];
    minimum_total_st_distance = min(min(total_st_distance));
    [optimal_algorithm,optimal_k_no] = find(total_st_distance == minimum_total_st_distance); 
    optimal_algorithm = optimal_algorithm(1);
    optimal_k_no = optimal_k_no(1);
    
    if optimal_algorithm == 1;
        s_distance(string_number+1) = st_distance_1(optimal_k_no,1);
        string_route_sequence{string_number+1} = string_route_sequence_3{optimal_k_no,1};
        s_distance(string_number+2) = st_distance_1(optimal_k_no,2);
        string_route_sequence{string_number+2} = string_route_sequence_3{optimal_k_no,2};
    else
        s_distance(string_number+1) = st_distance_2(optimal_k_no,1);
        string_route_sequence{string_number+1} = string_route_sequence_4{optimal_k_no,1};
        s_distance(string_number+2) = st_distance_2(optimal_k_no,2);
        string_route_sequence{string_number+2} = string_route_sequence_4{optimal_k_no,2};
    end
    
    
    for jj = string_number+1 : string_number+2
    for j = 1 : numel(string_route_sequence{jj})-1
        c = string_route_sequence{jj}(j);
        d = string_route_sequence{jj}(j + 1);
        
        path_x = path_matrix{min(c,d),max(c,d)}(:,1);
        path_y = path_matrix{min(c,d),max(c,d)}(:,2);
        path_z = path_matrix{min(c,d),max(c,d)}(:,3);
        path_distance = distance_matrix(min(c,d),max(c,d));
        
        plot3(path_x, path_y,path_z,'LineWidth',2)
        hold on;
        string_cluster_cable{jj}(j) = path_distance/10;
    end
    end  
    
end




















%% This is for plane string graph
figure(6)

plot(A,B,'r*','LineWidth',3);
hold on
plot(A_end, B_end,'g*','LineWidth',3);
hold on

axis equal
axis([-24 24 -48 48])

for i = 1: cluster_number-1
    for j = 1 : string_capacity + 1
        
     string_route_sequence_1{2*i-1}(j) = cluster_route_sequence{i}(j);
     string_route_sequence_1{2*i}(j) = cluster_route_sequence{i}(j+1+string_capacity);
    end       
    string_route_sequence_1{2*i-1} = fliplr(string_route_sequence_1{2*i-1}) ;
    
end

for i = 1:numel(string_route_sequence_1)
    
    s_distance_1(i) = 0;
    
    for j = 1 : string_capacity
        c = string_route_sequence_1{i}(j);
        d = string_route_sequence_1{i}(j + 1);
        path_distance = distance_matrix(min(c,d),max(c,d));
        s_distance_1(i) = s_distance_1(i) + path_distance;
    end
   
end

      

% string algorithm
for i = 1: cluster_number-1
    for j = 1 : string_capacity
     string{2*i-1}(j) = cluster_route_sequence{i}(j+1);  
     string{2*i}(j) = cluster_route_sequence{i}(j+1+string_capacity);
    end   
end

string_number = 2*(cluster_number-1);
for i = 1:string_number
    
     string_saving_matrix{i} = zeros(size(Nodes,1),size(Nodes,1));
     
     for  string_number_1 = 1: numel(string{i})
        for  string_number_2 = 1: numel(string{i})
            if string_number_1~=string_number_2
            string_saving_matrix{i}(string{i}(string_number_1),string{i}(string_number_2)) = distance_matrix(string{i}(string_number_1),size(Nodes,1))-distance_matrix(min(string{i}(string_number_1),string{i}(string_number_2)),max(string{i}(string_number_1),string{i}(string_number_2)));
            end
        end
    end
     
 [string_saving_sorted{i},string_saving_index{i}] = sort(string_saving_matrix{i}(:),'descend'); 
 
 l=1;
 while string_saving_sorted{i}(l) == 0
     l=l+1;
 end
 
 [m,n] = find(string_saving_matrix{i} == string_saving_sorted{i}(l));
 string_route_sequence_2{i} = [m,n];

    l=2;
    while numel(string_route_sequence_2{i})<numel(string{i})
    if string_saving_sorted{i}(l)~=0  
    [aa,bb] = find (string_saving_matrix{i} == string_saving_sorted{i}(l));
    end
    
     if (aa == string_route_sequence_2{i}(end) && (~ismember(bb, string_route_sequence_2{i})))
        string_route_sequence_2{i} = [string_route_sequence_2{i},bb]; l=2;
     else
        l = l+1;
     end
     end
    
    string_route_sequence_2{i} = [string_route_sequence_2{i},size(Nodes,1)]; 
    
     s_distance_2(i) = 0;
     
     for j = 1 : numel(string_route_sequence_2{i})-1
        c = string_route_sequence_2{i}(j);
        d = string_route_sequence_2{i}(j + 1);
         path_distance = distance_matrix(min(c,d),max(c,d));
         s_distance_2(i) = s_distance_2(i) +  path_distance;
            
     end    
end



for i = 1 : numel(string)
    s_distance(i) = min(s_distance_1(i),s_distance_2(i));
    
    if s_distance(i) == s_distance_1(i)    
    string_route_sequence{i} = string_route_sequence_1{i};
    else
        string_route_sequence{i} = string_route_sequence_2{i};
    end
% string_route_sequence{i} = string_route_sequence_1{i};%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for j = 1 : numel(string_route_sequence{i})-1
        c = string_route_sequence{i}(j);
        d = string_route_sequence{i}(j + 1);
        
        path_x = path_matrix{min(c,d),max(c,d)}(:,1);
        path_y = path_matrix{min(c,d),max(c,d)}(:,2);
        
        plot(path_x, path_y,'LineWidth',2)
        hold on;
    end
end
    
        
    




%this is for the last cluster   
i = cluster_number;
e = numel(cluster_route_sequence{i});

 
%%
if e -2 <= string_capacity
    string_distance_1 = 0;
    string_distance_2 = 0;
    string_distance_3 = 0;
    string_saving_matrix{string_number+1} = zeros(size(Nodes,1),size(Nodes,1));
    
    for j = 1: cluster_turbine_number(i)
        for k = 1: cluster_turbine_number(i)
            if j~=k
            string_saving_matrix{string_number+1}(T{i}(j),T{i}(k)) = distance_matrix(T{i}(j),size(Nodes,1))-distance_matrix(min(T{i}(j),T{i}(k)),max(T{i}(j),T{i}(k)));
            end
        end
    end
    
 [string_saving_sorted{string_number+1},string_saving_index{string_number+1}] = sort(string_saving_matrix{string_number+1}(:),'descend'); 
 
 l=1;
 while string_saving_sorted{string_number+1}(l) == 0
     l=l+1;
 end
 
 [m,n] = find(string_saving_matrix{string_number+1} == string_saving_sorted{string_number+1}(l));
 string_route_sequence_2{string_number+1} = [m,n];

    l=2;
    while numel(string_route_sequence_2{string_number+1})<cluster_turbine_number(i)
    if string_saving_sorted{string_number+1}(l)~=0  
    [aa,bb] = find (string_saving_matrix{string_number+1} == string_saving_sorted{string_number+1}(l));
    end
    
     if (aa == string_route_sequence_2{string_number+1}(end) && (~ismember(bb, string_route_sequence_2{string_number+1})))
        string_route_sequence_2{string_number+1} = [string_route_sequence_2{string_number+1},bb]; l=2;
     else
        l = l+1;
     end
     end
    
    string_route_sequence_2{string_number+1} = [string_route_sequence_2{string_number+1},size(Nodes,1)]; 
        
 for j = 1 : numel(string_route_sequence_2{string_number+1})-1
        c = string_route_sequence_2{string_number+1}(j);
        d = string_route_sequence_2{string_number+1}(j + 1);

            path_distance = distance_matrix(min(c,d),max(c,d));
            string_distance_2 = string_distance_2 +  path_distance;
 end


 
 
   for j = 1 : e-1
     string_route_sequence_cut_cable_2(j) = cluster_route_sequence{i}(j);
   end
     string_route_sequence_cut_cable_2 = fliplr(string_route_sequence_cut_cable_2);
    
  for j = 1 : e-2   
        c = string_route_sequence_cut_cable_2(j);
        d = string_route_sequence_cut_cable_2(j + 1); 
            path_distance = distance_matrix(min([c,d]),max([c,d]));
            string_distance_1 = string_distance_1 +  path_distance;
    end
  
   
      for j = 2 : e 
       string_route_sequence_cut_cable_1(j-1) = cluster_route_sequence{i}(j);
      end
      for j = 1 : e-2     
      c = string_route_sequence_cut_cable_1(j);
      d = string_route_sequence_cut_cable_1(j + 1); 
      path_distance = distance_matrix(min([c,d]),max([c,d]));
        string_distance_3 = string_distance_3 +  path_distance;
      end

 s_distance(string_number+1) = min([string_distance_1, string_distance_2, string_distance_3]);
 
 if s_distance(string_number+1) == string_distance_1
    string_route_sequence{string_number+1} = string_route_sequence_cut_cable_2;
 elseif s_distance(string_number+1) == string_distance_2
    string_route_sequence{string_number+1} = string_route_sequence_2{string_number+1};
 else
    string_route_sequence{string_number+1} = string_route_sequence_cut_cable_1;
 end
 
 
  for j = 1 : numel(string_route_sequence{string_number+1})-1
        c = string_route_sequence{string_number+1}(j);
        d = string_route_sequence{string_number+1}(j + 1);
        
        path_x = path_matrix{min(c,d),max(c,d)}(:,1);
        path_y = path_matrix{min(c,d),max(c,d)}(:,2);
        
        plot(path_x, path_y,'LineWidth',2)
        hold on;
    end
 
 
end


 %%

 if e -2 == 2 * string_capacity
  
    for j = 1 : string_capacity + 1
        
     string_route_sequence_1{2*i-1}(j) = cluster_route_sequence{i}(j);
     string_route_sequence_1{2*i}(j) = cluster_route_sequence{i}(j+1+string_capacity);
    end       
    string_route_sequence_1{2*i-1} = fliplr(string_route_sequence_1{2*i-1}) ;
 
    
for k = string_number+1 : string_number+2
    s_distance_1(k) = 0;
    
    for j = 1 : string_capacity
        c = string_route_sequence_1{k}(j);
        d = string_route_sequence_1{k}(j + 1);
        path_distance = distance_matrix(min(c,d),max(c,d));
        s_distance_1(k) = s_distance_1(k) + path_distance;
    end

end

      

% string algorithm
    for j = 1 : string_capacity
     string{2*i-1}(j) = cluster_route_sequence{i}(j+1);  
     string{2*i}(j) = cluster_route_sequence{i}(j+1+string_capacity);
    end   

for k = string_number+1 : string_number+2
    
     string_saving_matrix{k} = zeros(size(Nodes,1),size(Nodes,1));
     
     for  string_number_1 = 1: numel(string{k})
        for  string_number_2 = 1: numel(string{k})
            if string_number_1~=string_number_2
            string_saving_matrix{k}(string{k}(string_number_1),string{k}(string_number_2)) = distance_matrix(string{k}(string_number_1),size(Nodes,1))-distance_matrix(min(string{k}(string_number_1),string{k}(string_number_2)),max(string{k}(string_number_1),string{k}(string_number_2)));
            end
        end
    end
     
 [string_saving_sorted{k},string_saving_index{k}] = sort(string_saving_matrix{k}(:),'descend'); 
 
 l=1;
 while string_saving_sorted{k}(l) == 0
     l=l+1;
 end
 
 [m,n] = find(string_saving_matrix{k} == string_saving_sorted{k}(l));
 string_route_sequence_2{k} = [m,n];

    l=2;
    while numel(string_route_sequence_2{k})<numel(string{k})
    if string_saving_sorted{k}(l)~=0  
    [aa,bb] = find (string_saving_matrix{k} == string_saving_sorted{k}(l));
    end
    
     if (aa == string_route_sequence_2{k}(end) && (~ismember(bb, string_route_sequence_2{k})))
        string_route_sequence_2{k} = [string_route_sequence_2{k},bb]; l=2;
     else
        l = l+1;
     end
     end
    
    string_route_sequence_2{k} = [string_route_sequence_2{k},size(Nodes,1)]; 
    
     s_distance_2(k) = 0;
     
     for j = 1 : numel(string_route_sequence_2{k})-1
        c = string_route_sequence_2{k}(j);
        d = string_route_sequence_2{k}(j + 1);
         path_distance = distance_matrix(min(c,d),max(c,d));
         s_distance_2(k) = s_distance_2(k) +  path_distance;
            
     end    
end
 
for k = string_number+1 : string_number+2
    s_distance(k) = min(s_distance_1(k),s_distance_2(k));
    
    if s_distance(k) == s_distance_1(k)    
    string_route_sequence{k} = string_route_sequence_1{k};
    else
        string_route_sequence{k} = string_route_sequence_2{k};
    end
    
    for j = 1 : numel(string_route_sequence{k})-1
        c = string_route_sequence{k}(j);
        d = string_route_sequence{k}(j + 1);
        
        path_x = path_matrix{min(c,d),max(c,d)}(:,1);
        path_y = path_matrix{min(c,d),max(c,d)}(:,2);
         
        plot(path_x, path_y,'LineWidth',2)
        hold on;
    end
end

end

%%
if e-2 > string_capacity && e-2 < 2 * string_capacity
    
    for k = e-1-string_capacity : string_capacity + 1
     k_no = k - (e-1-string_capacity) + 1;
            
     %cutting cable
     string_route_sequence_3{k_no,1} = cluster_route_sequence{i}(1:k);     
     string_route_sequence_3{k_no,1} = fliplr(string_route_sequence_3{k_no,1});
     string_route_sequence_3{k_no,2} = cluster_route_sequence{i}(k+1:end);
     
    
    for jj = 1:2
        st_distance_1(k_no,jj) = 0; 
    for j = 1 : numel(string_route_sequence_3{k_no,jj})-1
        c = string_route_sequence_3{k_no,jj}(j);
        d = string_route_sequence_3{k_no,jj}(j + 1);
        path_distance = distance_matrix(min(c,d),max(c,d));
        st_distance_1(k_no,jj) = st_distance_1(k_no,jj) + path_distance;
    end
    end

    
    
    %string algorithm
     string_2{k_no,1} = string_route_sequence_3{k_no,1}(1:end-1);
     string_2{k_no,2} = string_route_sequence_3{k_no,2}(1:end-1);
       
     
    for jj = 1:2
    
     string_saving_matrix_2{k_no,jj} = zeros(size(Nodes,1),size(Nodes,1));
     
     for  string_number_1 = 1: numel(string_2{k_no,jj})
        for  string_number_2 = 1: numel(string_2{k_no,jj})
            if string_number_1~=string_number_2
            string_saving_matrix_2{k_no,jj}(string_2{k_no,jj}(string_number_1),string_2{k_no,jj}(string_number_2)) = distance_matrix(string_2{k_no,jj}(string_number_1),size(Nodes,1))-distance_matrix(min(string_2{k_no,jj}(string_number_1),string_2{k_no,jj}(string_number_2)),max(string_2{k_no,jj}(string_number_1),string_2{k_no,jj}(string_number_2)));
            end
        end
    end
     
 [string_saving_sorted_2{k_no,jj},string_saving_index_2{k_no,jj}] = sort(string_saving_matrix_2{k_no,jj}(:),'descend'); 
 
 if numel(string_2{k_no,jj})==1
     string_route_sequence_4{k_no,jj} = [string_2{k_no,jj},size(Nodes,1)]; 
 else 
 
 l=1;
 while string_saving_sorted_2{k_no,jj}(l) == 0
     l=l+1;
 end
 
 [m,n] = find(string_saving_matrix_2{k_no,jj} == string_saving_sorted_2{k_no,jj}(l));
 string_route_sequence_4{k_no,jj} = [m,n];

    l=2;
    while numel(string_route_sequence_4{k_no,jj})<numel(string_2{k_no,jj})
      
    if string_saving_sorted_2{k_no,jj}(l)~=0  
    [aa,bb] = find (string_saving_matrix_2{k_no,jj} == string_saving_sorted_2{k_no,jj}(l));
    end
    
     if (aa == string_route_sequence_4{k_no,jj}(end) && (~ismember(bb, string_route_sequence_4{k_no,jj})))
        string_route_sequence_4{k_no,jj} = [string_route_sequence_4{k_no,jj},bb]; l=2;
     else
        l = l+1;
     end
     end
    
    string_route_sequence_4{k_no,jj} = [string_route_sequence_4{k_no,jj},size(Nodes,1)]; 
    
 end
    end
    
 
    for jj = 1:2
        st_distance_2(k_no,jj) = 0; 
    for j = 1 : numel(string_route_sequence_4{k_no,jj})-1
        c = string_route_sequence_4{k_no,jj}(j);
        d = string_route_sequence_4{k_no,jj}(j + 1);
        path_distance = distance_matrix(min(c,d),max(c,d));
        st_distance_2(k_no,jj) = st_distance_2(k_no,jj) + path_distance;
    end
    end
    
    total_st_distance_1(k_no) = st_distance_1(k_no,1) + st_distance_1(k_no,2);
    total_st_distance_2(k_no) = st_distance_2(k_no,1) + st_distance_2(k_no,2);      
    end
    
    total_st_distance = [ total_st_distance_1; total_st_distance_2];
    minimum_total_st_distance = min(min(total_st_distance));
    [optimal_algorithm,optimal_k_no] = find(total_st_distance == minimum_total_st_distance);   
    optimal_algorithm = optimal_algorithm(1);
    optimal_k_no = optimal_k_no(1);
    
    if optimal_algorithm == 1;
        s_distance(string_number+1) = st_distance_1(optimal_k_no,1);
        string_route_sequence{string_number+1} = string_route_sequence_3{optimal_k_no,1};
        s_distance(string_number+2) = st_distance_1(optimal_k_no,2);
        string_route_sequence{string_number+2} = string_route_sequence_3{optimal_k_no,2};
    else
        s_distance(string_number+1) = st_distance_2(optimal_k_no,1);
        string_route_sequence{string_number+1} = string_route_sequence_4{optimal_k_no,1};
        s_distance(string_number+2) = st_distance_2(optimal_k_no,2);
        string_route_sequence{string_number+2} = string_route_sequence_4{optimal_k_no,2};
    end
    
    
    for jj = string_number+1 : string_number+2
    for j = 1 : numel(string_route_sequence{jj})-1
        c = string_route_sequence{jj}(j);
        d = string_route_sequence{jj}(j + 1);
        
        path_x = path_matrix{min(c,d),max(c,d)}(:,1);
        path_y = path_matrix{min(c,d),max(c,d)}(:,2);
        
        plot(path_x, path_y,'LineWidth',2)
        hold on;
    end
    end  
    
end
    
title(sprintf('string distance = %f km', shortest_string_distance))