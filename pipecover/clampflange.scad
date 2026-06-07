use <MCAD/2Dshapes.scad>;
include <MCAD/3d_triangle.scad>;
use <MCAD/regular_shapes.scad>;     

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

//clamp body
rotate ([180,0]) 
{
    translate([43,0]) linear_extrude(45) donutSlice(innerSize=58, outerSize=64, start_angle=0, end_angle=180);

    //clamp body w double flange
    //translate([43,0]) linear_extrude(30) donutSlice(innerSize=58, outerSize=64, start_angle=0, end_angle=180);

    //right flange - front       
    difference()
    {
        difference() 
        {
            translate([-50,7, 0])rotate ([90,0]) cube([30,30,7]);
            translate ([-35,15, 15])rotate ([90,0]) cylinder(20, 3,7);
        }
        translate ([-35,11.4, 15])rotate ([90,0]) linear_extrude(height = 8) 
        {
           hexagon(7.5);
        }   
    }
    translate ([-27,5,0]) rotate ([270,270,0]) prism (30,10,15); 
   
    
    //right flange - back
/*    difference()
    {
        difference() 
        {
            translate([-50,7, 15])rotate ([90,0]) cube([30,30,7]);
            translate ([-35,15, 30])rotate ([90,0]) cylinder(20, 3,7);
        }
        translate ([-35,11.4, 30])rotate ([90,0]) linear_extrude(height = 8) 
        {
           hexagon(7.5);
        }        
    }
    translate ([-27,5,15]) rotate ([270,270,0]) prism (30,10,15);
*/    
   
    //left flange - remove for hinged version
    /*difference () 
    {
        translate([106,7])rotate ([90,0]) cube([30,30,7]);
        translate ([120,15, 15])rotate ([90,0]) cylinder(20, 3,7);
    }*/

    //hinge hole
    translate ([101,0]) rotate ([90,0]) cube([15,45,7],0);
    difference() {translate ([117.7,-14,0]) cylinder(45, 12,12); translate ([117.7,-14,-10]) cylinder(200, 7,7);}
    translate ([125,-5,45]) rotate ([0,90, 90]) prism (45,20,12);
}
