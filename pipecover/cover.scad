use <MCAD/2Dshapes.scad>;



translate([100,0]) linear_extrude(180) donutSlice(innerSize=115, outerSize=121, start_angle=0, end_angle=180);
        
difference() 
{
    translate([-50,7])rotate ([90,0]) cube([30,30,7]);
    translate ([-35,15, 15])rotate ([90,0]) cylinder(20, 7,7);
}

difference () 
{
    translate([-50,7,150])rotate ([90,0]) cube([30,30,7]);
    translate ([-35,15, 165])rotate ([90,0]) cylinder(20, 7,7);
}

difference () 
{
    translate([215,7])rotate ([90,0]) cube([30,30,7]);
    translate ([232,15, 15])rotate ([90,0]) cylinder(20, 7,7);
}

difference ()
{
    translate([215,7,150])rotate ([90,0]) cube([30,30,7]);
    translate ([232,15, 165])rotate ([90,0]) cylinder(20, 7,7);
}    

//rounded_square(10, 10);