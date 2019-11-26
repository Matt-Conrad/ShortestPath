function [neighborhood, neighbor_values] = GetNeighborhood(image, ...
    pixel_location, adjacency_type, V)
%GETNEIGHBORHOOD This function returns the neighborhood around a pixel
%   This function will return an n by 2 array of pixel locations that are in the
%   neighborhood of the current pixel. This function is required because
%   we cannot attempt to access pixels around the current pixel unless we
%   know they exist. For example, a corner pixel would not have two
%   4-neighbors it could not access because they would be out of bounds
%   and must be handled carefully.
%   Params:
%   image          = an array of the image of interest values
%   pixel_location = a 1x2 int array that contains coordinates of the pixel
%   adjacency_type = the type of adjacency 
%   V              = the pixel values that define the path, necessary for
%                    m-adjacency
%   neighborhood   = an n-by-2 array that contains the coordinates of valid
%                    neighbors whose values are in V
%   neighbor_values = an n-by-1 array that contains the values from the
%                    corresponding coordinates in the neighborhood variable

pixel_row = pixel_location(1,1);
pixel_col = pixel_location(1,2);

% Create a list of possible neighbors to cycle through
switch adjacency_type % Must have different lists for different adjacencies
    case '4'
        possible_neighbors = [ (pixel_row-1),pixel_col ; pixel_row,(pixel_col+1) ; ...
           (pixel_row+1),pixel_col ; pixel_row,(pixel_col-1) ];
    case {'8','m'} % The set for 'm' is a subset of '8', so they are grouped here
        possible_neighbors = [ (pixel_row-1),pixel_col ; (pixel_row-1),(pixel_col+1) ; ...
            pixel_row,(pixel_col+1) ; (pixel_row+1),(pixel_col+1) ; (pixel_row+1),pixel_col ; ...
            (pixel_row+1),(pixel_col-1) ; pixel_row,(pixel_col-1) ; (pixel_row-1),(pixel_col-1) ];
    otherwise 
        error('Unacceptable path type. Please enter 4, 8, or m');
end 

% Cycle through possible_neighbors to get all valid neighbors
num_of_neighbors = 0;
for i = 1:length(possible_neighbors) 
    try
        % Attempt to get the pixel value at the possible location 
        neighbor_values(num_of_neighbors+1) = image(possible_neighbors(i,1),possible_neighbors(i,2)); 
        % If access is successful, remaining code in this block will execute
        
        % Store the coordinates of the valid neighbor
        neighborhood(num_of_neighbors+1,1:2) = possible_neighbors(i,1:2);
        % Increment the num_of_neighbors counter
        num_of_neighbors = num_of_neighbors + 1;
    catch
        % This block will execute if the possible_neighbor doesn't exist
        warning('Possible neighbor at (%d,%d) does not exist', ...
                    possible_neighbors(i,1),possible_neighbors(i,2)); 
    end
end

% If '4' or '8', the neighborhood must be further processed so only values
% that are in V remain in the neighborhood
if adjacency_type == '4' || adjacency_type == '8'
    % Check which neighbors have a value in V
    logical_array = ismember(neighbor_values,V);
    % Filter out pixels from the 8-adjacent neighborhood that do not have
    % values in V
    neighbor_values = neighbor_values(logical_array); 
    neighborhood = neighborhood(logical_array,:);
end

% If 'm', the neighborhood must be further processed 
if adjacency_type == 'm'
    % Check which neighbors have a value in V
    logical_array = ismember(neighbor_values,V); 
    % Filter out pixels from the 8-adjacent neighborhood that do not have
    % values in V
    neighbor_values = neighbor_values(logical_array); 
    neighborhood = neighborhood(logical_array,:);
    
    new_neighbor_count = 0;
    center_pixel_N4 = GetN4([pixel_row,pixel_col]); % This is used later in the else statement
    for i = 1:length(neighbor_values) % Cycle through remaining pixels 
        % If the neighbor is in N4(p) of pixel_location, then it is automatically in 'm'
        if neighborhood(i,1) == pixel_row || neighborhood(i,2) == pixel_col
            new_neighborhood(new_neighbor_count+1,1:2) = neighborhood(i,1:2);
            new_neighbor_values(new_neighbor_count+1) = neighbor_values(i);
            new_neighbor_count = new_neighbor_count + 1;
        else % If the neighbor is in the diagonal
            % Get the N4 for the diagonal
            diag_pixel_N4 = GetN4(neighborhood(i,1:2)); 
            % Find which pixels are shared in N4(p) AND N4(q)
            logical_array = ismember(diag_pixel_N4,center_pixel_N4,'rows'); 
            shared_pixels = diag_pixel_N4(logical_array,:);
            % Check to see if the shared pixel values are in V
            shared_pixel_values = GetPixelValues(image,shared_pixels);
            logical_array = ismember(shared_pixel_values,V);
            if sum(logical_array) == 0 % if the N4s do not contain a similar pixel location
                new_neighborhood(new_neighbor_count+1,1:2) = neighborhood(i,1:2);
                new_neighbor_values(new_neighbor_count+1) = neighbor_values(i);
                new_neighbor_count = new_neighbor_count + 1;
            end
        end
    end
    
    neighborhood = new_neighborhood;
    neighbor_values = new_neighbor_values;
end

end

