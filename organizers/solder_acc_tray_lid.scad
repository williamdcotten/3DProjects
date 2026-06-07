 include <BOSL2/std.scad>
 
 translate([0,0,32.5])
 {
 difference(){
    difference()
    {
        difference() 
        {
            //basic shape
            cuboid([175,225,35], rounding=6);
            //cut the top open
            translate ([0,0,25]) cuboid ([175,225,30]);
        }
        //hollow the interior
        cuboid ([165,215,30], rounding = 6);
    }
    //lip - the extra 0.25mm is "slop" so that the top lip will fit over the bottom
    translate ([0,0,5]) cuboid ([170.25,220.25,12], rounding = 6, edges="Z");
}
}

