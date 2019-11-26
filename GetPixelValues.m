function [ pixel_value_array ] = GetPixelValues( image, pixel_array )
%GETPIXELVALUES This function returns an array of values corresponding to
%each pixel in pixel_array
%   This function receives an image and an array of pixels, in no
%   particular order, and returns the image values at each of the pixel 
%   locations in the pixel_array.

pixel_value_array = zeros(length(pixel_array(:,1)),1);
for i = 1:length(pixel_value_array)
    try
        pixel_value_array(i,1) = image(pixel_array(i,1),pixel_array(i,2));
    catch
        warning('Possible neighbor at (%d,%d) does not exist', ...
                    possible_neighbors(i,1),possible_neighbors(i,2)); 
    end
end

end

