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
 
difference()
{
    difference() 
    {
        translate([-50,7, 15])rotate ([90,0]) cube([30,30,7]);
        translate ([-35,15, 30])rotate ([90,0]) cylinder(20, 3,7);
    }
 
   translate ([-35,4.4, 30])rotate ([90,0]) linear_extrude(height = 8) {
    hexagon(7.5);
}
}
//translate ([-30,5,15]) rotate ([270,270,0]) prism (30,12,10);
