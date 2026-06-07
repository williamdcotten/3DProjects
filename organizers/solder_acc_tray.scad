include <BOSL2/std.scad>


difference(){

//box
translate([0,0,32.5])
    {
    difference()
    { 
        difference() 
        {
            //basic shape
            cuboid([175,225,65], rounding=6);
            //cut the top open
            translate ([0,0,55]) cuboid ([175,225,60]);
        }
        //hollow the interior
        cuboid ([165,215,60], rounding = 6);
    }
    
    
    //divider
    translate([15,-108,-30]) cube([5, 219, 53]);
    
    //iron tip holders
    translate ([-32.5,82,-15]) difference()
    {
        cuboid ([100,55,30], rounding = 6, edges=[TOP+FRONT]);
        translate([34,0,-4])cylinder(20,4,4);
        translate([17,0,-4])cylinder(20,4,4);
        translate([0,0,-4])cylinder(20,4,4);
        translate([-17,0,-4])cylinder(20,4,4);
        translate([-34,0,-4])cylinder(20,4,4);
        
    } 
}
//lid definition
rotate([0,180,0]) translate([0,0,-72.5]) 
    difference(){
        difference()
        {
            difference() 
            {
                //basic shape
                cuboid([175,225,65], rounding=6);
                //cut the top open
                translate ([0,0,55]) cuboid ([175,225,60]);
            }
            //hollow the interior
            cuboid ([165,215,60], rounding = 6);
        }
        translate ([0,0,20]) cuboid ([170,220,12], rounding = 6, edges="Z");
    }
}