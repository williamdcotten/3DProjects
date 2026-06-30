//washer foot for tpu print:
include <BOSL2/std.scad>
/*[Hidden]*/
$fn=196;
/*[Which Feet To Print - Front Or Back]*/
//if this is true, it generates the front foot model
//if this is false, it generates the back foot
print_front_feet=true;

//front feet are 33mm to accomodate a larger metal stud (prevents tearing):
if (print_front_feet==false)
{    
    difference()
    {
        //solid component, base plus lip
        union ()
        {
            cyl(d=31, h=6, rounding1=2.0, anchor=BOTTOM);
            translate([0,0,6]) cylinder(d1=31, d2=24, h= 5); 
        }
        union()
        {
              
            //back feet dimensions
            translate ([0,0,6]) cylinder(d=21.8, h=2.8, center=false);
            translate ([0,0,8.8]) cylinder(d=18.5,h=0.5, center=false);
            translate ([0,0,9.3]) cylinder(d1=18.5, d2=21.8, h=1.8, center=false);
        }    
    }  
}
else
{    
//back feet have a slightly smaller base:
//*
     difference()
    {
        union()
        {
            cyl(d=33.2, h=6, rounding1=2.0, anchor=BOTTOM);
            translate([0,0,6]) cylinder(d1=33.2, d2=28, h=5);
        }
        union()
        {
            translate([0,0,6])  cylinder(d=27.1, h=2.8, center=false);
            translate([0,0,8.8]) cylinder(d=21.1, h=0.5, center=false);
            translate([0,0,9.3]) cylinder(d1=21.1, d2=24.1, h=1.8, center=false);
        }
    }
}

//Print with TPU95A - pause at 6mm to load TPU90A

/*Wall Generator Arachne
Wall Loop Order Outer/Inner
Top Surface Flow Ratio = 0.95 (requires Develop checked in Preferences)



STRENGTH [TOP FITTING]
Wall Loops = 4
Top Shell Layers 6
Top Shell Thickness 1.2mm
Bottom Shell Layers 5
Bottom Shell Thickness 1mm
(Bottom and Top Pattern = Default:Monotonic Line)
Internal Solid infill pattern = Concentric
Sparse Infil Density = 40
Sparse Infil Pattern = Gyroid

STRENGTH [FOOT BASE]
Wall Loops = 6
Top Shell Layers 6
Top Shell Thickness 1.2mm
Bottom Shell Layers 5
Bottom Shell Thickness 1mm
(Bottom and Top Pattern = Default:Monotonic Line)
Internal Solid infill pattern = Concentric
Sparse Infil Density = 95
Sparse Infil Pattern = Rectilinear
Out wall = 30mm/s
Inner Wall = 40mm/s
Sparse Infil = 40 mm/s
Internal Solid Infil = 40 mm/s
Top Surface=30mm/s
//Height Modifier at 6mm
Wall Loops = 4
Sparse Infil Density = 15%
Sparse Infil Pattern = Concentric

SUPPORT
Enable
On Build Plate Only
Organic / Tree Support
Brim Type = No Brim
Skirt Loops = 3
Skirt Distance from Object = 2.5mm

FILAMENT/FILAMENT
Nozzle 1st Layer =230
Nozzle other layer = 225
Textured PEI Plate 45/45

FILAMENT / COOLING
1st 3 layers, Fan Speed 0
Min fan speed threshold 30 min layer time 20
Max fan speed threshold 45 layer time 4WashingMachineFeetTPU
Aux fan speed 0
*/
    