 include <BOSL2/std.scad>
/*[Hidden]*/
$fn = 192;  

/*[DESIGN ELEMENTS]*/
//adds reeded or fluted edges like a coin
add_coin_reeds=true;
//adds_edge notch colors
add_edge_notches=true;
//adds the ring ot 13 stars around the top rim
add_outer_stars=true;
//adds a keychain cutout suitable for a #5 chain
add_keychain_hole=true;
//rear logo graphic (must be a simple, one color .svg file) 
back_bitmap_graphic="graphic.svg";
//slightly smaller front second color with backing rectangles or larger without
add_backing_rectangles=true;
//top arched text on back - if you use the keychain, you'll need to play with spacing
back_top_text="POST  7116";
//bottom arched text on back
back_bottom_text="SYLVANIA GA";
//have the front text sits above (proud_factor=1  ), slightly above(0.5) or flush(0) with the thumb pocket
proud_factor = 0.030; 

/*[WEIGHT]*/
washer_diameter = 21.21;
washer_thickness = 1.95;

/*[RENDERING]*/
//choices are all, body, decorations, 2ndcolor, bottomtext, bottomlogo
render="all";
//render="all";
//render="body";
//render="decorations";
//render="2ndcolor";
//render="bottomtext";
//render="bottomlogo";
//rendering logic - render each color element as a separate STL
//and combine them in the slicer - I do top and bottom of same color
//separately so I can apply different mods in slicer as well


/*[Hidden]*/
//design elements toggle
add_outer_text_logo_top=false;
add_outer_text_logo_bottom=false;
add_inner_text_logo_top=true;
add_inner_text_logo_top_color2=true;
add_inner_text_logo_bottom=true;
add_wrapped_text_logo_top=false;
add_wrapped_text_logo_bottom=true;
add_bitmap_logo_bottom= true;
//external resources
front_bitmap_graphic="graphic.svg";
//size
//50 cent piece is 30.61mmx2.15
//std casino poker chip is 39mmx3.5mm
//this is just slightly larger to get the design elements separated
chip_diameter = 40;             
chip_thickness = 3.7;           
edge_rounding = 0.6;       
//look and feel
//setting top smaller than bottom creates a frustum
recess_horizontal_shrink_top=6;
recess_horizontal_shrink_bottom=8;
recess_depth=0.4;
inset_depth=0.3;
edge_notches=8;
//right for a #5 chain keychain
keychain_diameter=3.5;
keychain_offset=2.6;
//std washer
//washer_diameter = 20;
//washer_thickness = 1.4;
//US quarter - creates a very thin wall if keychain hole is enabled
//washer_diameter = 24.76;
//washer_thickness = 1.95;
//US nickel
//washer_diameter = 21.21;
//washer_thickness = 1.95;
//a little extra room to make sure the washer doesn't bind
washer_horizontal_tolerance=0.5;
washer_vertical_tolerance=0.2;
//you'll need to push downward to use a coin instead of a washer
//if you're also printing the backing rectangles.
washer_offset = 0.1;

top_z_height = chip_thickness / 2; 
proud_depth=recess_depth*proud_factor;

//=====================================================================================
//BODY
//=====================================================================================
//Creates the poker chip body
//Removes the interior washer pocket and cuts thumb recesses for the top and bottom
//Also removes all the decorative elements chosen for the body so that there's room
//for them to print without having to make them modifiers when imported into the slicer
module poker_chip() 
{
    diff() 
    {
        //main chip
        cyl(d=chip_diameter, h=chip_thickness, rounding=edge_rounding, center=true) 
        {
            //washer pocket
            tag("remove") down(washer_offset) cyl(d=washer_diameter+washer_horizontal_tolerance, h=washer_thickness+washer_vertical_tolerance, center=true);
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
            if (add_inner_text_logo_top_color2==true)
            {
                if (add_backing_rectangles == true)
                {    
                    tag("remove") inner_text_logo_top_color2(2.5,6.75,6.75); 
                }
                else
                {
                    tag("remove") inner_text_logo_top_color2(3,6,6); 
                }    
            }
            if (add_backing_rectangles==true)
            {    
                tag("remove") backing_rectangles_diff();   
            }
            if (add_outer_text_logo_bottom==true)
            {    
                tag("remove") outer_text_logo_bottom(); 
            }  
            if (add_wrapped_text_logo_bottom==true)
            {    
                tag("remove") wrapped_text_logo_bottom(back_top_text, back_bottom_text); 
            }    
            if (add_outer_stars==true)
            {
                tag("remove") add_stars();
            }
            if (add_bitmap_logo_bottom==true)
            {
                tag("remove") bitmap_logo_bottom();
            }    
        }
    }
}


//======================================================================================
//EDGES
//======================================================================================
//cuts coin like reed edges 
module coin_reeds() 
{
    zrot_copies(n=120, r=chip_diameter/2)
        cyl(d=0.6, h=chip_thickness+0.2, center=true);
}

//adds the other color edge notches to the chip
module decorative_notches() 
{
    up( top_z_height) zrot_copies(n=edge_notches, r=(chip_diameter-3)/2)
         translate([0,0,-chip_thickness/2]) cuboid([3, recess_horizontal_shrink_top/2, chip_thickness],rounding=edge_rounding, edges=[TOP+RIGHT, BOTTOM+RIGHT], anchor=CENTER);  
}


//======================================================================================
//FRONT DESIGN ELEMENTS - PRIMARY COLOR
//======================================================================================
//centered text logo for the top
module inner_text_logo_top() 
{
    up(top_z_height) down(recess_depth-proud_depth) 
    linear_extrude(height=recess_depth) 
    {
        back(0) 
            text("250", size=8, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
            
       /*
        // Moves left by 6.5mm, then draws a 5-point star with a 1.5mm outer radius
            left(12)
               zrot(90) star(n=5, r=1.5, ir=0.6); // n=points, r=outer radius, ir=inner radius
                
            // Star on the Right side
            right(12)
                zrot(90) star(n=5, r=1.5, ir=0.6);
        
        /*fwd(3)//originally 4 
            //text("DAYS", size=2.5, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
       */ 
    }
}

module wrapped_text_logo_top() 
{
    pocket_radius = (chip_diameter - recess_horizontal_shrink_top) / 2; // Outer wall of the recess (15.5mm)
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
            bot_text = "";
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
        top_text = "";
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
        bot_text = "";
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

//adds 5 pointed facing up stars around the outside of the inner rim
module add_stars()
{
    star_count=13;
    star_radius =2;
    star_inner_radius = 0.9;
    circle_radius = (chip_diameter-recess_horizontal_shrink_top)/2-star_radius-0.5;
    
    up(top_z_height) down (recess_depth-proud_depth) 
    zrot(75) 
    zrot_copies(n=star_count, r=circle_radius)
            zrot(-($idx * (360 / star_count)) + 90)
            linear_extrude(height=recess_depth)
                star(n=5, r=star_radius, ir=star_inner_radius);
}    

//these two add primary color backing rectangles for the second color text
//to provide contrast
module backing_rectangles_diff()
{
    up(top_z_height) down(recess_depth + inset_depth)
    linear_extrude(height=inset_depth+recess_depth)
    {
        back(6.75)  rect([18, 4], anchor=CENTER);
        fwd(6.75)   rect([18, 4], anchor=CENTER);
    }
}    
module backing_rectangles()
{
    up(top_z_height) down (recess_depth + inset_depth)
    linear_extrude(height=inset_depth+recess_depth-proud_depth)
    {
        //square([30,30], center=true);
        back(6.75)  rect([17.5, 4], anchor=CENTER);
        fwd(6.75)   rect([17.5, 4], anchor=CENTER);
    }
}

//=======================================================================================
//FRONT DESIGN ELEMENTS - SECONDARY COLOR
//=======================================================================================
module inner_text_logo_top_color2(fontsize=2.5, back_offset=6.75, forward_offset=6.75) 
{
    up(top_z_height) down(recess_depth- proud_depth) 
    linear_extrude(height=recess_depth) 
    {
        back(back_offset) //center is 3
            text("AMERICA", size=fontsize, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
        
        fwd(forward_offset)//originally 4 
            text("1776-2026", size=fontsize, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
    }
}

module bitmap_logo_top() 
{
    // Millimeter size you want the image to occupy on the chip face
    target_width = 10; 
    target_length = 20;
    translate([0, 0, top_z_height - recess_depth]) 
    {
         linear_extrude(height=recess_depth)
        {  
            back(0.5)
            resize([target_width, target_length])
                offset(r=-0.01) 
                    offset(r=0.01)
                        import(front_bitmap_graphic, center=true);
        }    
    }    
}

//=======================================================================================
//BACK DESIGN ELEMENTS
//=======================================================================================
module inner_text_logo_bottom() 
{
    translate([0,0,-top_z_height]) mirror([1,0,0])
    linear_extrude(height=recess_depth) 
    {
        back(0) 
            text("", size=9, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
        
        fwd(4) 
            text("", size=4, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
    }
}


module wrapped_text_logo_bottom(toptext="YOUR  TEXT", bottomtext="GOES HERE") 
{
    pocket_radius = (chip_diameter - recess_horizontal_shrink_top) / 2; // Outer wall of the recess (15.5mm)
    font_safety_buffer = 2.3;            // Distance away from the rim edge
    
    translate([0,0,-top_z_height]) mirror([1,0,0])
    {
        // --- 1. TOP CURVED TEXT ---
        linear_extrude(height=recess_depth) 
        {
            top_text = toptext;
            top_size = 2.5;
            top_radius = pocket_radius - (top_size / 2) - font_safety_buffer; 
            for (i = [0 : len(top_text)-1]) {
                angle = (i - (len(top_text)-1)/2) * 12;//10.5; 
                rotate([0, 0, -angle + 90]) 
                    translate([top_radius, 0, 0]) 
                        rotate([0, 0, -90]) 
                            text(top_text[i], size=top_size, font="Liberation Sans:style=Bold", halign="center", valign="center");
            }
        }
            
        // --- 2. BOTTOM CURVED TEXT ---
        linear_extrude(height=recess_depth) 
        {
            bot_text = bottomtext;
            bot_size = 2.5;
            bot_radius = pocket_radius - (bot_size / 2) - font_safety_buffer; 
            
            for (i = [0 : len(bot_text)-1])
            {
                angle = (i - (len(bot_text)-1)/2) * 12; //9.5; 
                rotate([0, 0, angle - 90]) 
                    translate([bot_radius, 0, 0]) 
                        rotate([0, 0, 90]) 
                            text(bot_text[i], size=bot_size, font="Liberation Sans:style=Bold", halign="center", valign="center");
            }
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
        top_text = "";
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
        bot_text = "";
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


//=======================================================================================
//BACK DESIGN ELEMENTS - 2ND COLOR
//=======================================================================================
module bitmap_logo_bottom() 
{
    // Millimeter size you want the image to occupy on the chip face
    target_width = 20; 
    target_length = 9;
    
    translate([0, 0, -top_z_height]) mirror([1, 0, 0]) //rotate([0,0,180])
    { 
        linear_extrude(height=recess_depth)
        {  
            back(0.5)
            resize([target_width, target_length])
                offset(r=-0.01) 
                    offset(r=0.01)
                        import(back_bitmap_graphic, center=true);
        }    
    }
}



module builder()
{
   if (render=="all" || render=="body")
    {   
        
        color ("blue")poker_chip();
    }
    if (render=="all" || render=="decorations")
    {    
        if(add_edge_notches==true)
        {    
            color ("white") decorative_notches();
        }
        if (add_inner_text_logo_top==true)
        {    
            color("white") inner_text_logo_top();
        }
        
        if (add_wrapped_text_logo_top==true)
        {    
            color("white") wrapped_text_logo_top();
        }
        if (add_outer_stars==true)
        {
            color("white") add_stars();    
        }    
        if (add_backing_rectangles==true)
        {
            diff()
            {
                color ("white") backing_rectangles();   
                tag ("remove") inner_text_logo_top_color2(2.5,6.75,6.75);        
            }    
           
        }    
    }  
    if (render == "all" || render=="bottomtext")
    {
        if (add_inner_text_logo_bottom==true)
        {    
            color("white") inner_text_logo_bottom();
        }
        if (add_wrapped_text_logo_bottom==true)
        {    
            color("white") wrapped_text_logo_bottom(back_top_text, back_bottom_text);
        }    
        if(add_outer_text_logo_bottom==true)
        {    
            color("white") outer_text_logo_bottom();
        }
    }
    if (render == "all" || render=="bottomlogo")
    {
        if (add_bitmap_logo_bottom==true)
        {    
        color("red") bitmap_logo_bottom(); 
        }
    }    
    if (render=="all" || render=="2ndcolor")
    {
        if (add_inner_text_logo_top_color2==true)
        {   
           if (add_backing_rectangles == true)
           {    
            color("red") inner_text_logo_top_color2(2.5,6.75,6.75); 
           }
       else
       {
            color("red") inner_text_logo_top_color2(3,6,6); 
       }    
        }   
    } 
}    

//==================================================================
///BUILD
//==================================================================
//difference()
//{
difference()
{
    builder();
    if (add_keychain_hole==true)
    {    
    translate([0,(chip_diameter-recess_horizontal_shrink_top-keychain_offset)/2,0]) cyl(d=keychain_diameter, h=chip_thickness*10, center=true);
    }    
}
//translate([0,0,-20]) cube([50,50,50]);
//}

/*SLICER SETTINGS GLOBAL
[QUALITY]
Line Width Initial Layer=0.35
Ironing Type Top Surfaces
Ironing Speed 15mm/s
Ironing Flow 6
Ironing Line Spacing 0.1
Wall Generator Arachne
Order of Walls Outer/Inner
Only One Wall on first layer=not applied
Avoid Crossing Walls-checked; max detour length = 0
[STRENGTH]
Wall Loops 4
Bottom Surface Pattern Concentric //Monotonic if usng text/graphics
Internal Solid Infill Pattern Aligned Rectilinear

Sparse Infll Density 100
Sparse Infill Pattern Rectilinear
[SPEED]
Initial Layer = 15mm/s
Initial Infil = 25mm/s
Outer Wall = 50mm/s
Inner Wall = 100mm/s
Top Surface = 15mm/s
Initial Layer Acceleration = 300 mm/s500
Top Surface Acceleration = 300mm/s
[OTHER]
G-Code -> Uncheck Reduce Infill Retraction
[PLATE SETTINGS - small hex nut to right of plate in Studio]
First Layer Filament Sequence=Lighter Color First
[FILAMENT SETTINGS] - 3 dots to right of filaments] 
-initial layer: white red blue; 
- all others: blue red white
Reduce flow ratio to 0.95 for blue and red filament only
Foreground colors:
- Z hop when retract 0.4mm; Z hop type spiral
SLICER SETTINGS PER OBJECT
[HEIGHT MODIFIER 3.1mm-4mm (above the top to not confuse the slicer]
Layer Height = 0.1
Line Width Top Surface=0.35
Wall Loops = 1
[PER OBJECT SETTING: BOTTOMLOGO, BOTTOMTEXT]
Wall Loops=1

*/