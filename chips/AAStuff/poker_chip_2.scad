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
add_coin_reeds=true;
add_edge_notches=false;
edge_notches=8;
add_outer_text_logo_top=true;
add_outer_text_logo_bottom=true;

//std washer
//washer_diameter = 20;
//washer_thickness = 1.4;

//US quarter - creates a very thin wall if keychain hole is enabled
//washer_diameter = 24.76;
//washer_thickness = 1.95;

//US nickel
washer_diameter = 21.21;
washer_thickness = 1.95;

washer_horizontal_tolerance=0.5;
washer_vertical_tolerance=0.2;

top_z_height = chip_thickness / 2; 
add_keychain_hole=true;
keychain_diameter=3.5;
keychain_offset=4+keychain_diameter/2;
render="all";
//render="body";
//render="decorations";

module poker_chip() 
{
    diff() 
    {
        //main chip
        cyl(d=chip_diameter, h=chip_thickness, rounding=edge_rounding, center=true) 
        {
            //washer pocket
            tag("remove") cyl(d=washer_diameter+washer_horizontal_tolerance, h=washer_thickness+washer_vertical_tolerance, center=true);
            //top and bottom thumb recesses
            tag("remove") attach([TOP, BOTTOM]) cyl(d1=chip_diameter-recess_horizontal_shrink_top, d2=chip_diameter-recess_horizontal_shrink_bottom, h=recess_depth, center=false);
            // add fluted edges like a coin
            if (add_coin_reeds==true)
            {
                tag("remove") coin_reeds();
            }    
            //make room for decorative edges 
            if (add_edge_notches==true)
            {    
                tag("remove") attach(TOP) zrot_copies(n=edge_notches, r=(chip_diameter)/2)
                    translate([0,0,-chip_thickness/2]) cuboid([3, recess_horizontal_shrink_top/2, chip_thickness], anchor=CENTER);  
            }
            if (add_outer_text_logo_top==true)
            {    
                tag("remove") outer_text_logo_top(); 
            }
            if (add_outer_text_logo_bottom==true)
            {    
                tag("remove") outer_text_logo_bottom(); 
            }    
            if (add_keychain_hole==true)
            {    
                tag("remove") back ((chip_diameter-recess_horizontal_shrink_top-4)/2) cyl(d=keychain_diameter, h=chip_thickness*10, center=true);        
            }    
        }
    }
}

module coin_reeds() 
{
    zrot_copies(n=120, r=chip_diameter/2)
        cyl(d=0.6, h=chip_thickness+0.2, center=true);
}
module decorative_notches() 
{
    up( top_z_height) zrot_copies(n=edge_notches, r=(chip_diameter-3)/2)
         translate([0,0,-chip_thickness/2]) cuboid([3, recess_horizontal_shrink_top/2, chip_thickness],rounding=edge_rounding, edges=[TOP+RIGHT, BOTTOM+RIGHT], anchor=CENTER);  
}

module inner_text_logo_top() 
{
    up(top_z_height) down(recess_depth) 
    linear_extrude(height=recess_depth) 
    {
        back(5) //center is 3
            text("24", size=9, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
        
        fwd(3)//originally 4 
            text("DAYS", size=2.5, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
    }
}

module inner_text_logo_bottom() 
{
    translate([0,0,-top_z_height]) mirror([1,0,0])
    linear_extrude(height=recess_depth) 
    {
        back(3) 
            text("24", size=9, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
        
        fwd(4) 
            text("HOURS", size=2.5, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
    }
}

module wrapped_text_logo() 
{
    pocket_radius = (chip_diameter - 8) / 2; // Outer wall of the recess (15.5mm)
    font_safety_buffer = 2.3;            // Distance away from the rim edge
    
    up(top_z_height) 
    down(recess_depth) 
    {
        // --- 1. TOP CURVED TEXT ---
        linear_extrude(height=recess_depth) 
        {
            top_text = "";
            top_size = 2.0;
            top_radius = pocket_radius - (top_size / 2) - font_safety_buffer; 
            for (i = [0 : len(top_text)-1]) {
                angle = (i - (len(top_text)-1)/2) * 10.5; 
                rotate([0, 0, -angle + 90]) 
                    translate([top_radius, 0, 0]) 
                        rotate([0, 0, -90]) 
                            text(top_text[i], size=top_size, font="Liberation Sans:style=Bold", halign="center", valign="center");
            }
        }
            
        // --- 2. BOTTOM CURVED TEXT ---
        linear_extrude(height=recess_depth) 
        {
            bot_text = "I CAN DO ONE MORE DAY";
            bot_size = 1.8;
            bot_radius = pocket_radius - (bot_size / 2) - font_safety_buffer; 
            
            for (i = [0 : len(bot_text)-1])
            {
                angle = (i - (len(bot_text)-1)/2) * 9.5; 
                rotate([0, 0, angle - 90]) 
                    translate([bot_radius, 0, 0]) 
                        rotate([0, 0, 90]) 
                            text(bot_text[i], size=bot_size, font="Liberation Sans:style=Bold", halign="center", valign="center");
            }
        }
    }    
}


module outer_text_logo_top()
{
    // find the exact centerline of the outer rim ring
    rim_outer_r = chip_diameter / 2;
    rim_inner_r = (chip_diameter - recess_horizontal_shrink_top-2) / 2;
    rim_center_r = (rim_outer_r + rim_inner_r) / 2; 
    
    //TOP TEXT
    up(top_z_height) down(recess_depth) 
    linear_extrude(height=recess_depth) 
    {
        top_text = "I CAN DO";
        top_size = 2.0;
        for (i = [0 : len(top_text)-1]) 
        {
            angle = (i - (len(top_text)-1)/2) * 7.5; 
            rotate([0, 0, -angle + 90]) 
                translate([rim_center_r, 0, 0]) 
                    rotate([0, 0, -90]) 
                        text(top_text[i], size=top_size, font="Liberation Sans:style=Bold", halign="center", valign="center");
        }
    }
    
    //BOTTOM TEXT
    up(top_z_height) down(recess_depth)
    linear_extrude(height=recess_depth) 
    {
        bot_text = "ONE MORE DAY";
        bot_size = 1.8;
        
        for (i = [0 : len(bot_text)-1]) 
        {
            angle = (i - (len(bot_text)-1)/2) * 6.8; 
            rotate([0, 0, angle - 90]) 
                translate([rim_center_r, 0, 0]) 
                    rotate([0,0,90] ) 
                        text(bot_text[i], size=bot_size, font="Liberation Sans:style=Bold", halign="center", valign="center");
        }
    }
}

module outer_text_logo_bottom()
{
    // find the exact centerline of the outer rim ring
    rim_outer_r = chip_diameter / 2;
    rim_inner_r = (chip_diameter - recess_horizontal_shrink_top-2) / 2;
    rim_center_r = (rim_outer_r + rim_inner_r) / 2; 
    
    //TOP TEXT
    translate([0,0,-top_z_height]) mirror([1,0,0])
    linear_extrude(height=recess_depth) 
    {
        top_text = "I CAN DO";
        top_size = 2.0;
        for (i = [0 : len(top_text)-1]) 
        {
            angle = (i - (len(top_text)-1)/2) * 7.5; 
            rotate([0, 0, -angle + 90]) 
                translate([rim_center_r, 0, 0]) 
                    rotate([0, 0, -90]) 
                        text(top_text[i], size=top_size, font="Liberation Sans:style=Bold", halign="center", valign="center");
        }
    }
    
    //BOTTOM TEXT
    translate([0,0,-top_z_height]) mirror([1,0,0])
    linear_extrude(height=recess_depth) 
    {
        bot_text = "ONE MORE HOUR";
        bot_size = 1.8;
        
        for (i = [0 : len(bot_text)-1]) 
        {
            angle = (i - (len(bot_text)-1)/2) * 6.8; 
            rotate([0, 0, angle - 90]) 
                translate([rim_center_r, 0, 0]) 
                    rotate([0,0,90] ) 
                        text(bot_text[i], size=bot_size, font="Liberation Sans:style=Bold", halign="center", valign="center");
        }
    }
}

//==================================================================
///BUILD
//==================================================================

//difference(){
if (render=="all" || render=="body")
{    
    color ("black")poker_chip();
}
if (render=="all" || render=="decorations")
{    
    if(add_edge_notches==true)
    {    
        color ("gold") decorative_notches();
    }
    color("gold") inner_text_logo_top();
    color("gold") inner_text_logo_bottom();
    color("gold") wrapped_text_logo();
    if(add_outer_text_logo_top==true)
    {    
        color("gold") outer_text_logo_top();
    }
    if (add_outer_text_logo_bottom==true)
    {
        color("gold") outer_text_logo_bottom();    
    }    
}    
//translate([0,-25,-5]) cube([50,50,50]);
//}


/*SLICER SETTINGS
[QUALITY]
Ironing Type Topmost Surfaces Only
Ironing Flow 8
Wall Generator Arachne
Order of Walls Outer/Inner
Avoid Crossing Walls-checked; max detour length = 0
[STRENGTH]
Wall Loops 4
Bottom Surface Pattern Concentric
Sparse Infll Density 100
Sparse Infill Pattern Rectilinear
[PLATE SETTINGS - small hex nut to right of plate in Studio]
First Layer Filament Sequence=Lighter Color First
[FILAMENT SETTINGS - 3 dots to right of filaments]
Reduce flow ratio to 0.95 for darker filament only


*/