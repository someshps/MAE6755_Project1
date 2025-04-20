SetFactory("OpenCASCADE");  


Point(1) = {-50, -50, 0, 1.0};
Point(2) = {-50, 0, 0, 1.0};
Point(3) = {-50, 50, 0, 1.0};
Point(4) = {0, 50, 0, 1.0};
Point(5) = {50, 50, 0, 1.0};
Point(6) = {50, 0, 0, 1.0};
Point(7) = {50, -50, 0, 1.0};
Point(8) = {0, -50, 0, 1.0};

Point(9) = {-5/Sqrt(2), -5/Sqrt(2), 0, 1.0};
Point(10) = {-5/Sqrt(2), 5/Sqrt(2), 0, 1.0};
Point(11) = {5/Sqrt(2), 5/Sqrt(2), 0, 1.0};
Point(12) = {5/Sqrt(2), -5/Sqrt(2), 0, 1.0};
Point(13) = {-5/Sqrt(2), -5/Sqrt(2), 0, 1.0};
Point(14) = {5/Sqrt(2), 5/Sqrt(2), 0, 1.0};

Point(15) = {0, 0, 0, 1.0};
Point(16) = {0, 0, 0, 1.0};

Point(17) = {-50, -50, 0, 1.0};
Point(18) = {50, 50, 0, 1.0};



Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 5};
Line(5) = {18, 6};
Line(6) = {6, 7};
Line(7) = {7, 8};
Line(8) = {8, 17};
Line(9) = {17, 13};
Circle(10) = {14, 16, 13};
Line(11) = {14, 18};
Line(12) = {5, 11};
Circle(13) = {9, 15, 11};
Line(14) = {9, 1};  

Curve Loop(1) = {1, 2, 3, 4, 12, 13, 14};
Plane Surface(1) = {1};

Curve Loop(2) = {9, 10, 11, 5, 6, 7, 8};
Plane Surface(2) = {2};

Physical Surface("top_rock", 15) = {1};
Physical Surface("bottom_rock", 16) = {2};

Physical Curve("top", 17) = {3, 4};
Physical Curve("right", 18) = {5, 6};
Physical Curve("bottom", 19) = {7, 8};
Physical Curve("left", 20) = {1, 2};


Physical Curve("top_fault", 21) = {12, 13, 14};
Physical Curve("bottom_fault", 22) = {9, 10, 11};


Physical Point("ml", 23) = {2};
Physical Point("mt", 24) = {4};
Physical Point("mr", 25) = {6};
Physical Point("mb", 26) = {8};

















