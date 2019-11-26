function [ N4Array ] = GetN4( pixel )
%GETN4 Returns the 4 pixel locations in the "cross" around the pixel
%   Given a pixel, this function will return an array of pixel locations
%   of the N4(pixel) adjacency subset. This function does not check whether
%   the N4 pixels exist in the image, or if the locations are valid.
%   pixel = 1x2 array of the center pixel coordinates
%   N4Array = a 4x2 array of pixel locations that are in the N4 subset

pixel_row = pixel(1,1);
pixel_col = pixel(1,2);

N4Array = [ (pixel_row-1),pixel_col ; pixel_row,(pixel_col+1) ; ...
           (pixel_row+1),pixel_col ; pixel_row,(pixel_col-1) ];

end

