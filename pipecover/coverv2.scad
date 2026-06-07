use <MCAD/2Dshapes.scad>;

module prism(l, w, h)
{
    polyhedron(points=[[0,0,0], [0,w,h], [l,w,h], [l,0,0], [0,w,0], [l,w,0]],
               // top sloping face (A)
               faces=[[0,1,2,3],
               // vertical rectangular face (B)
               [2,1,4,5],
               // bottom face (C)
               [0,3,5,4],
               // rear triangular face (D)
               [0,4,1],
               // front triangular face (E)
               [3,2,5]]
               );
}



//cover body
//translate([43,0]) linear_extrude(180) donutSlice(innerSize=58, outerSize=64, start_angle=0, end_angle=180);
difference() {
difference() 
{   translate([43,0]) linear_extrude(180) donutSlice(innerSize=58, outerSize=64, start_angle=0, end_angle=180);
    translate ([115,0,45]) rotate ([0,90,90])cube ([90,30,7]);
}
translate ([115,0,225]) rotate ([0,90,90]) cube ([90,30,7]); 
}



//test component
/*difference() {translate([43,0]) linear_extrude(60) donutSlice(innerSize=58, outerSize=64, start_angle=0, end_angle=180);
translate ([115,0,30]) rotate ([0,90,90])cube ([90,15,7]);}*/

//right side fastening flanges    
difference() 
{
    translate([-50,7, 0])rotate ([90,0]) cube([30,30,7]);
    translate ([-35,15, 15])rotate ([90,0]) cylinder(20, 2,7);
}
translate ([-30,5,0]) rotate ([270,270,0]) prism (30,12,10);

difference () 
{
    translate([-50,7,150])rotate ([90,0]) cube([30,30,7]);
    translate ([-35,15, 165])rotate ([90,0]) cylinder(20, 3,7);
}
translate ([-30,5,150]) rotate ([270,270,0]) prism (30,12,10);

//left side fastening flanges
/*difference () 
{
    translate([106,7])rotate ([90,0]) cube([30,30,7]);
    translate ([120,15, 15])rotate ([90,0]) cylinder(20, 3,7);
}

difference ()
{
    translate([106,7,150])rotate ([90,0]) cube([30,30,7]);
    translate ([120,15, 165])rotate ([90,0]) cylinder(20, 3,7);
}
*/

//hinge hole
difference() {translate ([117.7,14,45]) cylinder(90, 12,12); translate ([117.7,14,-10]) cylinder(200, 7,7);}
//test
//difference() {translate ([117.7,14,30]) cylinder(30, 12,12); translate ([117.7,14,-10]) cylinder(200, 7,7);}

//hinge brace assembly
translate ([102,10,45]) rotate ([90,0,90]) cube([8,90,8],0);
translate ([115,2.5,135]) rotate ([0,90, 90]) prism (90,12,16);
translate ([100,13,135]) rotate ([90,90, 90]) prism (90,12,16);

/*
//test
translate ([102,10,30]) rotate ([90,0,90]) cube([8,30,8],0);
translate ([115,2.5,60]) rotate ([0,90, 90]) prism (30,12,16);
translate ([100,13,60]) rotate ([90,90, 90]) prism (30,12,16);*/

