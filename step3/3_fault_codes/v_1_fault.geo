SetFactory("OpenCASCADE");

Point(1) = {-50, -50, 0, 1.0};
Point(2) = {-50, 0, 0, 1.0};
Point(3) = {-50, 50, 0, 1.0};
Point(4) = {0, 50, 0, 1.0};
Point(5) = {50, 50, 0, 1.0};
Point(6) = {50, 0, 0, 1.0};
Point(7) = {50, -50, 0, 1.0};
Point(8) = {0, -50, 0, 1.0};

Point(9) = {0, -50, 0, 1.0};
Point(10) = {0, 50, 0, 1.0};

Point(11) = {0, 0, 0, 1.0};

Point(12) = {-5, 0, 0, 1.0};
Point(13) = {0, 5, 0, 1.0};
Point(14) = {5, 0, 0, 1.0};
Point(15) = {0, -5, 0, 1.0};

Point(16) = {0, 5, 0, 1.0};
Point(17) = {0, -5, 0, 1.0};


Point(18) = {-25, 50, 0, 1.0};
Point(19) = {25, 50, 0, 1.0};
Point(20) = {-25, -50, 0, 1.0};
Point(21) = {25, -50, 0, 1.0};
Point(22) = {0, 0, 0, 1.0}; 


Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 18};
Line(4) = {18, 4};
Line(5) = {4, 16};
Circle(6) = {17, 11, 16};
Line(7) = {17, 8};
Line(8) = {8, 20};
Line(9) = {20, 1};

Line(10) = {7, 21};
Line(11) = {21, 9};
Line(12) = {9, 15};
Circle(13) = {13, 22, 15};
Line(14) = {13, 10};
Line(15) = {10, 19};
Line(16) = {19, 5};
Line(17) = {5, 6};
Line(18) = {6, 7};




Curve Loop(1) = {8, 9, 1, 2, 3, 4, 5, 6, 7};
Plane Surface(1) = {1};

Curve Loop(2) = {12, 13, 14, 15, 16, 17, 18, 10, 11};
Plane Surface(2) = {2};


Physical Surface("right_rock", 19) = {2};
Physical Surface("left_rock", 20) = {1};

Physical Curve("top_left", 21) = {3, 4};
Physical Curve("top_right", 22) = {15, 16};
Physical Curve("right", 23) = {17, 18};
Physical Curve("left", 24) = {1, 2};
Physical Curve("bottom_left", 25) = {8, 9};
Physical Curve("bottom_right", 26) = {11, 10};

Physical Curve("left_fault", 28) = {5, 6, 7};
Physical Curve("right_fault", 29) = {12, 13, 14};

Physical Point("mtl", 30) = {18};
Physical Point("mtr", 31) = {19};
Physical Point("mbl", 32) = {20};
Physical Point("mbr", 33) = {21};
Physical Point("ml", 34) = {2};
Physical Point("mr", 35) = {6};




