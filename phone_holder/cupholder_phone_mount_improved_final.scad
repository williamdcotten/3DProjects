include <BOSL2/std.scad>
/*[Hidden]*/
$fn=192;
eps=0.01;

//=======================================================
//PART PARAMETERS
//=======================================================
/*[PART PRINTING PARAMETERS]*/
//print the outer sleeve - note: don't print sleeve and body at the same time!
print_outer_sleeve = false;
//print the holder body
print_holder_body = true;

//=======================================================
//CUSTOMIZATION PARAMETERS
//=======================================================
/*[CAR, PHONE CUSTOMIZATION PARAMETERS]*/
//height of car's cupholder in mm
outer_cylinder_height =70;
//width of car's cupholder at bottom in mm
outer_cylinder_base_diameter= 69;
//with of car's cupholder at top in mm
outer_cylinder_top_diameter = 76;
//Phone's width (facing the phone) at the bottom in mm
phone_bottom_width=81;
//Phone's width at the middle of the phone in mm
phone_middle_width=79;
//Phone's front to back depth
phone_depth=14.8;
//additional clearance between phone outer width and holder inner width
clearance = 0.5;


//=======================================================
//DESIGN PARAMETERS
//=======================================================
/*[DESIGN AND AESTHETICS PARAMETERS]*/
//how high the phone stand base extends above the cupholder
inner_cylinder_extended_height = 37;
//back plate height total including z translation
back_plate_height = 105;
//how far up the backplate the phone holder sits 
holder_z_translation=15;
//angle of the phone holder relative to base
holder_tilt_angle = 30;
//holder offset from center of base (forward is negative) from back of baseplate
holder_offset=-15;
//how deeply to embed the holder in the base
holder_embedding_depth=5;
//optionally include side wings above thh side walls
add_side_wings = true;
//how far up (from the phone shelf, not the bottom of the backplate) do the side wings start
side_wing_z = 40;
//how high the side wings extend from their bottom
side_wing_height = 20;
//include the angled front cut for usb strain relief
print_angled_cut = true;
//print the front lip from the beginning of the usb holder to the front edge (otherwise ends halfway from the usb notch
print_full_length_front_edge=true;
//rounding at the top of the outer sleeve
outer_cylinder_top_rounding = 3;
//rounding radius for the top of the inner (base) cylinder
inner_cylinder_top_rounding = 2;
//radius of rounding for backplate top corners
back_plate_rounding_top=10;
//radius of rounding for backplate top corners
back_plate_rounding_bottom=5;
//rounding radius of the lower side walls
side_wall_rounding = 5;
//radius of the rounding for the side wings)
side_wing_rounding = 5;

//=======================================================
//CONSTRUCTION PARAMETERS
//=======================================================
/*[CONSTRUCTION PARAMETERS]*/
//distance between the inner and outer cylinder.
inter_cylinder_clearance=0.4;
//minimum (at the base of the taper) thickness of the 
outer_cylinder_minimum_wall_thickness = 7;
//Gap between inner and outer cylinders for rotation
//thickness of the inner (base) cylinder side walls 
inner_cylinder_wall = 6;
//thickness of the inner (base) cylinder top wall 
inner_cylinder_top_wall = 3;
//back plate thickness
back_plate_thickness = 8;
//thickness of lower walls on the side of the holder
side_wall_thickness = 3;
//height of the lower side walls on the holder
side_wall_height = 20;
//side wing thickness
side_wing_thickness = 3;
//front lip thickness
front_lip_thickness = 3;
//front lip height
front_lip_height=16;
//rounding radius of front lip tops 
front_lip_rounding = 5;
//phone shelf thickness
holder_floor_thickness = 3;
//usb cutout can be eliminated
build_usb_notch=true;
//how deeply into the phone shelf to cut the usb notch
usb_cut_depth =12;
//how far from the left of center to extend the notch
usb_cut_left_width = 7.5;
//how far from the right of center to extend the notch
usb_cut_right_width = 7.5;
//rounding radius for notch (0 is a square cut)
usb_cut_rounding = 3;


//=======================================================
//CALCULATED PARAMETERS
//=======================================================
//outer cyliner
outer_cylinder_cutout_diameter = outer_cylinder_base_diameter-outer_cylinder_minimum_wall_thickness;
/*Inner Base Cylinder*/
inner_cylinder_diameter = outer_cylinder_base_diameter-outer_cylinder_minimum_wall_thickness-inter_cylinder_clearance;
inner_cylinder_height = inner_cylinder_extended_height+outer_cylinder_height;
/*Holder Dimensions*/
holder_inner_width = phone_bottom_width + clearance;
holder_inner_depth = phone_depth + clearance;
holder_width=holder_inner_width+2*side_wall_thickness;
side_wing_clearance = phone_middle_width + clearance;
holder_center_width = side_wing_clearance+2*side_wing_thickness;
holder_total_depth= holder_inner_depth+front_lip_thickness+back_plate_thickness;




//=========================================================
//MODULES
//=========================================================
module base_cylinder()
{
    difference()
    {
        cyl(inner_cylinder_height, d=inner_cylinder_diameter, rounding2=inner_cylinder_top_rounding, anchor=BOTTOM);
        cylinder(inner_cylinder_height-inner_cylinder_top_wall, d=inner_cylinder_diameter-inner_cylinder_wall);    
    }
}

module outer_sleeve()
{
    difference()
    {
        cyl(outer_cylinder_height, d1=outer_cylinder_base_diameter, d2=outer_cylinder_top_diameter, anchor=BOTTOM, rounding2=outer_cylinder_top_rounding);
        cylinder(outer_cylinder_height, d = outer_cylinder_cutout_diameter);
    }    
} 

module holder_baseplate()
{
  if (build_usb_notch==true)
        {
            difference()
            {
                union()
                {
                    //floor plate rear
                    rotate ([0,180,180]) translate([0, holder_total_depth/2-back_plate_thickness/2-usb_cut_depth/2,0]) cuboid([holder_width,holder_total_depth-usb_cut_depth, holder_floor_thickness], anchor=BOTTOM);
                    //floor plate right
                    rotate ([0,180,180]) translate ([holder_width/2-(holder_width/2-usb_cut_right_width)/2,holder_total_depth/2-back_plate_thickness/2,0]) cuboid([holder_width/2-usb_cut_right_width,holder_total_depth, holder_floor_thickness], anchor=BOTTOM, rounding = usb_cut_rounding, edges = BACK+LEFT);
                    //front lip plate right
                    if (print_full_length_front_edge==true)
                    {    
                        translate( [holder_width/2-(holder_width/2-usb_cut_right_width)/2,-holder_total_depth+back_plate_thickness/2+front_lip_thickness/2,0]) diff () cuboid([holder_width/2-usb_cut_right_width, front_lip_thickness,front_lip_height], anchor=BOTTOM, rounding=usb_cut_rounding, edges =[FRONT+LEFT]) edge_profile([TOP+LEFT]) mask2d_roundover(r=front_lip_rounding);               
                   }
                   else
                   {
                       translate( [(holder_width/2-(holder_width/2-usb_cut_right_width)/2-(holder_width/2-usb_cut_right_width)/4),-holder_total_depth+back_plate_thickness/2+front_lip_thickness/2,0]) diff () cuboid([(holder_width/2-usb_cut_right_width)/2, front_lip_thickness,front_lip_height], anchor=BOTTOM, rounding=usb_cut_rounding, edges =[FRONT+LEFT]) edge_profile([TOP+LEFT, TOP+RIGHT]) mask2d_roundover(r=front_lip_rounding);   
                         
                   }     
                    //floor plate left
                   rotate ([0,180,180]) translate ([-(holder_width/2-(holder_width/2-usb_cut_left_width)/2),holder_total_depth/2-back_plate_thickness/2,0]) cuboid([holder_width/2-usb_cut_left_width,holder_total_depth, holder_floor_thickness], anchor=BOTTOM, rounding=usb_cut_rounding, edges=[BACK+RIGHT, TOP+RIGHT]) edge_profile([LEFT]) mask2d_roundover(r=1);
                     //front lip plate left
                   if (print_full_length_front_edge==true)
                   {    
                       translate( [-(holder_width/2-(holder_width/2-usb_cut_left_width)/2),-holder_total_depth+back_plate_thickness/2+front_lip_thickness/2,0]) diff() cuboid([holder_width/2-usb_cut_left_width, front_lip_thickness,front_lip_height], anchor=BOTTOM, rounding = usb_cut_rounding, edges=[FRONT+RIGHT])edge_profile([TOP+RIGHT]) mask2d_roundover(r=front_lip_rounding);
                   }
                   else
                   {
                        translate( [-(holder_width/2-(holder_width/2-usb_cut_left_width)/2-(holder_width/2-usb_cut_right_width)/4),-holder_total_depth+back_plate_thickness/2+front_lip_thickness/2,0]) diff() cuboid([(holder_width/2-usb_cut_left_width)/2, front_lip_thickness,front_lip_height], anchor=BOTTOM, rounding = usb_cut_rounding, edges=[FRONT+RIGHT])edge_profile([TOP+RIGHT, TOP+LEFT]) mask2d_roundover(r=front_lip_rounding);
                   }     
                       //translate( [(holder_width/2-(holder_width/2-usb_cut_right_width)/2-(holder_width/2-usb_cut_right_width)/4),-holder_total_depth+back_plate_thickness/2+front_lip_thickness/2,0]) diff () cuboid([(holder_width/2-usb_cut_right_width)/2, front_lip_thickness,front_lip_height], anchor=BOTTOM, rounding=usb_cut_rounding, edges =[FRONT+LEFT]) edge_profile([TOP+LEFT, TOP+RIGHT]) mask2d_roundover(r=front_lip_rounding);   
                         
                   }     

                usb_offset=(usb_cut_left_width-usb_cut_right_width)/2;
                translate([-usb_offset,-(holder_total_depth-back_plate_thickness/2-usb_cut_depth/2-usb_cut_rounding/2),-holder_floor_thickness*2]) cuboid([usb_cut_left_width+usb_cut_right_width, usb_cut_depth+usb_cut_rounding,holder_floor_thickness+front_lip_height], anchor=BOTTOM, rounding=usb_cut_rounding); 
            }    
       }
       else
       {
            //floor plate contininuous
            rotate ([0,180,180]) translate([0, holder_total_depth/2-back_plate_thickness/2,0]) cuboid([holder_center_width,holder_total_depth, holder_floor_thickness], anchor=BOTTOM);
            //front lip plate continuous
            translate([0,-holder_total_depth+back_plate_thickness/2+front_lip_thickness/2,0]) cuboid([holder_width, front_lip_thickness,front_lip_height], anchor=BOTTOM);
       }    
}  

module phone_holder_face()
{
    union()
    {
        rotate ([90,0,0]) translate ([holder_width/2-side_wall_thickness/2,side_wall_height/2,back_plate_thickness/2]) cuboid([side_wall_thickness, side_wall_height, holder_inner_depth+front_lip_thickness], anchor=BOTTOM,rounding = side_wall_rounding, edges=BACK+TOP);
        //left side plate
        rotate ([90,0,0]) translate ([-holder_width/2+side_wall_thickness/2,side_wall_height/2,back_plate_thickness/2]) cuboid([side_wall_thickness, side_wall_height, holder_inner_depth+front_lip_thickness], anchor=BOTTOM, rounding = side_wall_rounding, edges=BACK+TOP);
       if (add_side_wings==true)
       {
            rotate ([90,0,0]) translate ([holder_center_width/2-side_wing_thickness/2,side_wing_height/2+side_wing_z,back_plate_thickness/2]) cuboid([side_wing_thickness, side_wing_height, holder_inner_depth+front_lip_thickness], anchor=BOTTOM,rounding = side_wall_rounding, edges=[BACK+TOP,FRONT+TOP]);

            //left side wing
            rotate ([90,0,0]) translate ([-holder_center_width/2+side_wing_thickness/2,side_wing_height/2+side_wing_z,back_plate_thickness/2]) cuboid([side_wing_thickness, side_wing_height, holder_inner_depth+front_lip_thickness], anchor=BOTTOM,rounding = side_wall_rounding, edges=[BACK+TOP,FRONT+TOP]);
       } 
       //baseplate with front lip and usb_cutout
       holder_baseplate();   
   }   
}    

module phone_holder()
{
    union()
    {
        //back plate
        diff() cuboid([holder_width, back_plate_thickness, back_plate_height], anchor = BOTTOM, rounding = back_plate_rounding_bottom,edges=[LEFT+BOTTOM, RIGHT+BOTTOM]) edge_profile([LEFT+TOP, RIGHT+TOP]) mask2d_roundover(r=back_plate_rounding_top);
    translate([0,0,holder_z_translation]) phone_holder_face();  
    }    
}  

module place_holder()
{
    raw_height = inner_cylinder_height+(back_plate_thickness/2*sin(holder_tilt_angle));
    translate([0, holder_offset, raw_height-holder_embedding_depth])
        rotate([-holder_tilt_angle,0,0])
            phone_holder(); 
}  


module angled_wall()
{
    // Tilted slab - same transform chain as place_holder()
    intersection()
    {
        cyl(inner_cylinder_height*4, d=inner_cylinder_diameter, anchor=CENTER);
        translate([0, holder_offset, inner_cylinder_height+(back_plate_thickness/2*sin(holder_tilt_angle))-holder_embedding_depth])
            rotate([-holder_tilt_angle, 0, 0])
                translate([0, -back_plate_thickness/2 + inner_cylinder_wall, holder_z_translation])
                    cuboid([inner_cylinder_diameter+2, inner_cylinder_wall, inner_cylinder_height],
                           anchor=TOP+BACK);
    }
}

module front_opening_cutter()
{
    cutter_height=2*inner_cylinder_height;
    translate([0, holder_offset, inner_cylinder_height+(back_plate_thickness/2*sin(holder_tilt_angle))-holder_embedding_depth])
        rotate([-holder_tilt_angle, 0, 0])
            translate([0, -back_plate_thickness/2, holder_z_translation - cutter_height])
                cuboid([inner_cylinder_diameter+2,
                        inner_cylinder_diameter+2,
                        cutter_height],
                       anchor=BOTTOM+BACK);
}

//========================================================
//BUILD
//========================================================
 
if (print_holder_body==true)
{
    if (print_angled_cut==true)
    {
        union()
        {   
            union()
            {
                difference()
                {
                    union()
                    {
                        base_cylinder();
                        angled_wall();
                    }
                    front_opening_cutter();
                }
            place_holder();
            }
        }
    } 
    else
    {
        union()
        {
            place_holder();
            base_cylinder();
        }    
    }    
}

if (print_outer_sleeve==true)
{
    outer_sleeve();
}    

