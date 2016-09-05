function [ distMat, pathCell ] = distance_matrix( data , vertices, faces)
% Determining the distance between each and other points

    % Generate a table worth of results
    for i = 1:numel(data)
        for j=1:numel(data)
            [i,j; data(i),data(j)];
            [distMat(i,j), pathCell{i,j}] = turbine_distance(data(i), data(j), vertices, faces);
        end
    end
    
   
end