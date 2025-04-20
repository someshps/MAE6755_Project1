SetFactory("OpenCASCADE");

Point(1) = {-50, -50, 0, 1.0};
Point(2) = {-50, -25, 0, 1.0};
Point(3) = {-50, 0, 0, 1.0};
Point(4) = {-50, 0, 0, 1.0};
Point(5) = {-50, 25, 0, 1.0};
Point(6) = {-50, 50, 0, 1.0};
Point(7) = {0, 50, 0, 1.0};
Point(8) = {50, 50, 0, 1.0};
Point(9) = {50, 25, 0, 1.0};
Point(10) = {50, 0, 0, 1.0};
Point(11) = {50, 0, 0, 1.0};
Point(12) = {5, 0, 0, 1.0};
Point(13) = {5, 0, 0, 1.0};
Point(14) = {0, 5, 0, 1.0};
Point(15) = {-5, 0, 0, 1.0};
Point(16) = {-5, 0, 0, 1.0};
Point(17) = {0, -5, 0, 1.0};
Point(18) = {50, -25, 0, 1.0};
Point(19) = {50, -50, 0, 1.0};
Point(20) = {0, -50, 0, 1.0};
Point(21) = {0, 0, 0, 1.0};
Point(22) = {0, 0, 0, 1.0};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {4,5};
Line(4) = {5, 6};
Line(5) = {6, 7};
Line(18) = {7, 8};
Line(6) = {8, 9};
Line(7) = {9, 10};
Line(8) = {10, 12};
Circle(9) = {15, 21, 12}; 
Line(10) = {15, 4}; 
Line(11) = {3, 16}; 
Circle(12) = {13, 22, 16}; 
Line(13) = {13, 11}; 
Line(14) = {11, 18}; 
Line(15) = {18, 19};
Line(16) = {19, 20}; 
Line(17) = {20, 1}; 


Curve Loop(1) = {1, 2, 11, 12, 13, 14, 15, 16, 17};
Plane Surface(1) = {1};

Curve Loop(2) = {3, 4, 5, 18, 6, 7,8, 9, 10};
Plane Surface(2) = {2};


Physical Surface("top_rock", 19) = {2};
Physical Surface("bottom_rock", 20) = {1};

Physical Curve("bottom_left", 21) = {1, 2};
Physical Curve("top_left", 22) = {3, 4};
Physical Curve("top", 23) = {5, 18};
Physical Curve("top_right", 24) = {6, 7};
Physical Curve("bottom_right", 25) = {14, 15};
Physical Curve("bottom", 26) = {16, 17};

Physical Curve("top_fault", 28) = {8, 9, 10};
Physical Curve("bottom_fault", 29) = {11, 12, 13};

Physical Point("mtl", 30) = {5};
Physical Point("mtr", 31) = {9};
Physical Point("mbl", 32) = {2};
Physical Point("mbr", 33) = {18};
Physical Point("mt", 34) = {7};
Physical Point("mb", 35) = {20};











