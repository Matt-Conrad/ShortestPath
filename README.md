# Shortest Path Between 2 Pixels

This project is a Matlab program that will calculate and visualize the shortest path between 2 pixels in a grayscale image. This project was one of the problems in a problem set for my ECE558 Imaging Systems class. I wrote the program using a 100% original algorithm without inspiration from any other algorithms like Dijkstra's algorithm. An application of this program is GPS navigation as you can see in SampleOutput.jpg. PathFinder.m is the main function and it utilizes the other 2 m-files. Here's a short description of each file in this project.

* boston.jpg: grayscale map of Boston, used as input to the function
* GetN4.m: Returns the 4 pixel locations in the "cross" around the pixel
* GetNeighborhood.m: This function returns the neighborhood around a pixel
* GetPixelValues.m: This function returns an array of values corresponding to each pixel in pixel_array
* PathFinder.m: This function maps a path from point p to q
* SampleOutput.jpg: The output when you input boston.jpg into PathFinder.m. Run the code at the bottom of TestScript.m if you want to see
* TestScript.m: Various tests run with a variety of matrices used to test the PathFinder function
