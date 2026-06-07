//washer foot for tpu print:
include <BOSL2/std.scad>
$fn=128;
difference()
{
    //solid component, base plus lip
    union ()
    {
        cyl(d=45, h=10, rounding1=2.0, anchor=BOTTOM);
        //replaced with BOSL2 cylinder to allow rounding
        //cylinder(d=45, h=10);
        translate([0,0,10]) cylinder(d1=45, d2=31.5, h= 4); 
    }
    union()
    {
        /* front feet dimensions are larger than back feet 
        translate ([0,0,10]) cylinder(d=27, h=2.8, center=false);
        translate ([0,0,12.8]) cylinder(d=24,h=0.5, center=false);
        translate ([0,0,13.3]) cylinder(d1=22, d2=24, h=1.5, center=false);
        */
        //back feet dimensions
        translate ([0,0,10]) cylinder(d=21.8, h=2.8, center=false);
        translate ([0,0,12.8]) cylinder(d=21.8,h=0.5, center=false);
        translate ([0,0,13.3]) cylinder(d1=13.9, d2=21.8, h=1.5, center=false);
    }    
} 
/*Wall Generator Arachne
Wall Loop Order Outer/Inner
Top Surface Flow Ratio = 0.95 (requires Develop checked in Preferences)

STRENGTH
Wall Loops = 4
Top Shell Layers 6
Top Shell Thickness 1.2mm
Bottom Shell Layers 5
Bottom Shell Thickness 1mm
(Bottom and Top Pattern = Default:Monotonic Line)
Internal Solid infill pattern = Concentric
Sparse Infil Density = 40
Sparse Infil Pattern = Gyroid

SPEED
Out wall = 30mm/s
Inner Wall = 40mm/s
Sparse Infil = 40 mm/s
Internal Solid Infil = 40 mm/s
Top Surface=30mm/s

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
    