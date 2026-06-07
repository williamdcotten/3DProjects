include <BOSL2/std.scad>

//difference(){

union()
{
    difference()
    {
        //box
        translate([0,0,30])
        {
            difference()
            { 
                difference() 
                {
                    //basic shape
                    cuboid([166,206,60], rounding=6);
                    //cut the top open
                    translate ([0,0,55]) cuboid ([166,206,60]);
                }
                //hollow the interior
                cuboid ([160,200,56], rounding = 6);
            }
        }   
    }
    //divider
    translate([-4,-100,2]) cube([4, 200, 52]);
    rotate ([00,0,90]) translate([40,0,2]) cube ([4,80,52]);
}

//rotate ([0,0,90]) translate([85,-160,2]) cube([400,400,200]);
//}
//lid definition
/*rotate([0,180,0]) translate([0,0,-72.5]) 
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
}*/