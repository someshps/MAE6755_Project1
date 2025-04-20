// Parameters
a = 5;       // Tunnel radius (m)
L = 50;      // Half domain size (domain is 100m x 100m)
cl1 = 0.1;   // Mesh size near tunnel
cl2 = 3.0;   // Mesh size far from tunnel

// Center point (for arcs)
Point(100) = {0, 0, 0, cl1};

// Points for outer square
Point(1) = {-L, -L, 0, cl2};
Point(2) = { L, -L, 0, cl2};
Point(3) = { L,  L, 0, cl2};
Point(4) = {-L,  L, 0, cl2};

// Points for tunnel (circle, 4 points for quadrants)
Point(11) = { a, 0, 0, cl1};
Point(12) = { 0, a, 0, cl1};
Point(13) = {-a, 0, 0, cl1};
Point(14) = { 0,-a, 0, cl1};

// Outer square lines
Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,1};
Line Loop(100) = {1,2,3,4};

// Tunnel circle (4 arcs, use center point 100)
Circle(11) = {11, 100, 12};
Circle(12) = {12, 100, 13};
Circle(13) = {13, 100, 14};
Circle(14) = {14, 100, 11};
Line Loop(200) = {11,12,13,14};

// Plane surface: square with tunnel as hole
Plane Surface(1) = {100,200};

// Physical groups for boundaries (for MOOSE)
Physical Curve("tunnel") = {11,12,13,14};
Physical Curve("right")  = {2};
Physical Curve("top")    = {3};
Physical Curve("left")   = {4};
Physical Curve("bottom") = {1};
Physical Surface("domain") = {1};
