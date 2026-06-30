include <BOSL2/std.scad>

$fn = 192;  
//50 cent piece is 30.61mmx2.15
chip_diameter = 39;             
chip_thickness = 3.5;           
edge_rounding = 0.6;       
//setting top smaller than bottom creates a frustum
recess_horizontal_shrink_top=6;
recess_horizontal_shrink_bottom=8;
recess_depth=0.4;

edge_notches=8;
washer_diameter = 20;
washer_horizontal_tolerance=0.5;
washer_thickness = 1.4;
washer_vertical_tolerance=0.2;

top_z_height = chip_thickness / 2; 
add_keychain_hole=true;
keychain_diameter=3.5;
keychain_offset=4;
der="all";
//render="body";
render="decorations";

module poker_chip() 
{
    diff() 
    {
        //main chip
        cyl(d=chip_diameter, h=chip_thickness, rounding=edge_rounding, center=true) 
        {
            //washer pocket
            tag("remove") cyl(d=washer_diameter+washer_horizontal_tolerance, h=washer_thickness+washer_vertical_tolerance, center=true);
            //top and bottom recesses
            tag("remove") attach([TOP, BOTTOM]) cyl(d1=chip_diameter-recess_horizontal_shrink_top, d2=chip_diameter-recess_horizontal_shrink_bottom, h=recess_depth, center=false);
         //make room for decorative edges   
         tag("remove") attach(TOP) zrot_copies(n=edge_notches, r=(chip_diameter)/2)
                    translate([0,0,-chip_thickness/2]) cuboid([3, recess_horizontal_shrink_top/2, chip_thickness], anchor=CENTER);  
    tag("remove") back ((chip_diameter-recess_horizontal_shrink_top-4)/2) cyl(d=keychain_diameter, h=chip_thickness*10, center=true);        
        }
    }
    
}

module decorative_notches() 
{
    up( top_z_height) zrot_copies(n=edge_notches, r=(chip_diameter-3)/2)
         translate([0,0,-chip_thickness/2]) cuboid([3, recess_horizontal_shrink_top/2, chip_thickness],rounding=edge_rounding, edges=[TOP+RIGHT, BOTTOM+RIGHT], anchor=CENTER);  
}

module text_logo() {
    up(top_z_height) down(recess_depth) 
    linear_extrude(height=recess_depth) 
    {
        back(3) 
            text("24", size=9, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
        
        fwd(4) 
            text("DAYS", size=2.5, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
    }
}
//difference(){
if (render=="all" || render=="body")
{    
    color ("black")poker_chip();
}
if (render=="all" || render=="decorations")
{    
    color ("gold") decorative_notches();
    color("gold") text_logo();
}    
//translate([0,-25,-5]) cube([50,50,50]);
//}