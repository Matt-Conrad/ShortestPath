function [path, path_length] = PathFinder(image,V,p,q,path_type)
%PATHFINDER This function maps a path from point p to q
%   Image = array of image or segment of an image, V is the set of pixel
%   values that define the path, p and q are the start and end pixels of
%   the path, and lastly the path type is the type of adjacency that
%   defines the path. This function uses these parameters to map a path and
%   return the total path length for the shortest path in pixels and also a
%   L by 2 matrix that contains x and y coordinates for every step along
%   the path.
tic
% Check if image is larger than 1x1
if isequal( size(image) , [1,1] )
    error('Image is too small');
end
% Check if p and q are not equal
if isequal(p,q)
    error('p and q should be different coordinates');
end
% Check if p is in the image
if p(1,1)>size(image,1) || p(1,1)<0 || p(1,2)>size(image,2) || p(1,2)<0
    error('p is not in the boundaries of the image');
end
% Check if q is in the image
if q(1,1)>size(image,1) || q(1,1)<0 || q(1,2)>size(image,2) || q(1,2)<0
    error('q is not in the boundaries of the image');
end
% Check if V is empty
if isempty(V)
    error('V does not have any values in it');
end
% Check if path_type is valid
if path_type ~= '4' && path_type ~= '8' && path_type ~= 'm'
    error('path_type is not a valid entry. Please enter 4, 8, or m');
end

start_pixel = p;
end_pixel = q;

% Create an array of ints that represents the distance between the
% corresponding pixel and the starting pixel
[m_image, n_image] = size(image);
tentative_distance = Inf(m_image,n_image);

% Create an array of pixels to visit
pixels_to_visit = start_pixel;
visited_pixels = uint16.empty(0,2);

% Create a column vector that matches up with pixels_to_visit and contains
% the iteration these pixels were added
iteration_vector = 0;

while ~isempty(pixels_to_visit)
    % Grab the location of the next pixel out of the
    % pixels_to_visit list
    current_pixel = pixels_to_visit(1,1:2);
    
    % Retrieve the neighborhood for the current pixel
    [current_neighborhood, ~] = GetNeighborhood(image,current_pixel,path_type,V);
    
    % Check if each neighbor pixel is in the visited array
    logical_array = ~ismember( current_neighborhood , visited_pixels , 'rows' ); % 0 if it has been visited, 1 if not visited
    
    % Extract the pixels that haven't been visited
    potential_pixels_to_visit = current_neighborhood(logical_array,:);
    
    % Check if these potential pixels are already in
    % pixels_to_visit
    % 1 if it needs to be added to the pixels_to_visit list, 0 if not
    logical_array = ~ismember( potential_pixels_to_visit , pixels_to_visit , 'rows');
    
    % Extract the list of the pixels to add to the pixels_to_visit list
    pixels_to_add = potential_pixels_to_visit(logical_array,:);
    
    % Create a list of distances from start_pixel
    pixels_to_add_distances = ones( size(pixels_to_add,1) , 1 ); 
    current_iteration = iteration_vector(1,1);
    pixels_to_add_distances = pixels_to_add_distances .* (current_iteration+1);
    
    % Add these pixels to the list
    pixels_to_visit( end+1 : end+size(pixels_to_add,1) , : ) = pixels_to_add;
    iteration_vector( end+1 : end+size(pixels_to_add_distances,1) , 1) = pixels_to_add_distances;
    
    % Store the distance in the tentative_distance array
    tentative_distance(current_pixel(1,1),current_pixel(1,2)) = iteration_vector(1,1);
    
    % Store the current pixel in visited_pixels
    visited_pixels( (end+1) , 1:2 ) = current_pixel;
    
    % Remove the top row from the pixels_to_visit and iteration_vector
    % arrays
    if isequal(current_pixel, end_pixel)
        break;
    else 
        pixels_to_visit = pixels_to_visit(2:end,:);
        iteration_vector = iteration_vector(2:end,:);
    end
    
    % This if statement checks to see if there is no path to the end_pixel
    if ~isequal(current_pixel, end_pixel) && isempty(pixels_to_visit)
        error('IT APPEARS THERE IS NO PATH TO THE END PIXEL');
    end
end

% The path length is the tentative_distance at the end_pixel
path_length = tentative_distance(end_pixel(1,1),end_pixel(1,2));

% So, now we have tentative_distance which has all the necessary
% information to develop the shortest path
path = zeros(path_length+1,2);
path(path_length+1,1:2) = end_pixel;
for i = (path_length+1) : -1 : 2
    % This for loop starts at the end_pixel in tentative_distance and works
    % backward to start_pixel. There could be multiple paths that are tied
    % for shortest, so this just finds one of them.
    current_pixel = path(i,1:2); 
    next_value = tentative_distance(current_pixel(1,1),current_pixel(1,2))-1;
    [neighborhood, ~] = GetNeighborhood(tentative_distance,current_pixel,'8',next_value);
    path( (i-1) , 1:2 ) = neighborhood(1,1:2);
end

% disp(tentative_distance);
toc
