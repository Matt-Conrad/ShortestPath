% Matthew Conrad
% Test Script for Homework 2

%% Tests for GetNeighborhood
clear all; clc; 

% Create test inputs
image = [1,2,3,4,5;...
         5,2,4,3,1;...
         1,5,3,4,5;...
         5,3,3,3,1;...
         1,2,3,1,5];
pixel_location = [3,3];
adjacency = '8';
V = [3,4,5];
[neighborhood, neighbor_values] = GetNeighborhood( image, pixel_location, adjacency, V);

%% Test 1 for PathFinder
clear all; clc;
% Create test inputs
image = [3 1 2 1;...
         2 2 0 2;...
         1 2 1 1;...
         1 0 1 2];
V = [0,1];
p = [4,1];
q = [1,4];
adjacency = '8';
% Run the test
[path, path_length] = PathFinder(image,V,p,q,adjacency);

%% Test 2 for PathFinder
clear all; clc;
% Create test inputs
image = [3 1 2 1;...
         2 2 0 2;...
         1 2 1 1;...
         1 0 1 2];
V = [0,1];
p = [4,1];
q = [1,4];
adjacency = '8';
% Run the test
[path, path_length] = PathFinder(image,V,p,q,adjacency);

%% Test 3 for PathFinder
clear all; clc;
% Create test inputs
image = [3 1 2 1;...
         2 2 0 2;...
         1 2 1 1;...
         1 0 1 2];
V = [0,1];
p = [4,1];
q = [1,4];
adjacency = 'm';
% Run the test
[path, path_length] = PathFinder(image,V,p,q,adjacency);

%% Test 4 for PathFinder
clear all; clc;
% Create test inputs
image = [3 1 2 1;...
         2 2 0 2;...
         1 2 1 1;...
         1 0 1 2];
V = [1,2];
p = [4,1];
q = [1,4];
adjacency = '4';
% Run the test
[path, path_length] = PathFinder(image,V,p,q,adjacency);

%% Test 5 for PathFinder
clear all; clc;
% Create test inputs
image = [3 1 2 1;...
         2 2 0 2;...
         1 2 1 1;...
         1 0 1 2];
V = [1,2];
p = [4,1];
q = [1,4];
adjacency = '8';
% Run the test
[path, path_length] = PathFinder(image,V,p,q,adjacency);

%% Test 6 for PathFinder
clear all; clc;
% Create test inputs
image = [3 1 2 1;...
         2 2 0 2;...
         1 2 1 1;...
         1 0 1 2];
V = [1,2];
p = [4,1];
q = [1,4];
adjacency = 'm';
% Run the test
[path, path_length] = PathFinder(image,V,p,q,adjacency);

%% Test 7 for PathFinder
clear all; clc;
% Create test inputs
image = [0 1 2 1;...
         2 1 0 0;...
         1 1 1 1;...
         1 0 1 2];
V = [1,2];
p = [3,3];
q = [1,4];
adjacency = '4';
% Run the test
[path, path_length] = PathFinder(image,V,p,q,adjacency);

%% Test 8 for PathFinder
clear all; clc;
% Create test inputs
image = [0 1 2 1;...
         2 1 0 0;...
         1 1 1 1;...
         1 0 1 2];
V = [1,2];
p = [4,3];
q = [1,4];
adjacency = 'm';
% Run the test
[path, path_length] = PathFinder(image,V,p,q,adjacency);

%% Test 9 for PathFinder
clear all; clc;
% Create test inputs
image = [1 1 1 1 0 1 0;...
         0 1 0 0 0 1 0;...
         1 1 1 1 1 1 1;...
         1 0 1 0 1 1 1];
V = [1];
p = [4,1];
q = [1,6];
adjacency = 'm';
% Run the test
[path, path_length] = PathFinder(image,V,p,q,adjacency);

%% Test real picture
clear all; clc;

% Import image
image = imread('boston.jpg');
image = rgb2gray(image);
imtool(image,[]);

V = 245:255;
p = [72,186];
q = [247,298];
adjacency = '8';
[path, path_length] = PathFinder(image,V,p,q,adjacency);

for i = 1:length(path)
    image(path(i,1),path(i,2)) = 0;
end

imtool(image,[]);
