include <BOSL2/std.scad>
$fn=192;
eps=0.01;

//=======================================================
//PARAMETERS
//=======================================================
/*Outer Holder Cylinder*/
outer_cylinder_height =70;
outer_cylinder_base_diameter= 69;
outer_cylinder_top_diameter = 76;
outer_cylinder_top_rounding = 3;
outer_cylinder_minimum_wall_thickness = 7;
outer_cylinder_cutout_diameter = outer_cylinder_base_diameter-outer_cylinder_minimum_wall_thickness;

/*Phone Values*/
phone_bottom_width=81;
phone_middle_width=79;
phone_depth=14.8;

//CONSTRUCTION PARAMETERS
/*Gap between inner and outer cylinders for rotation*/
cylinder_clearance=0.4;

/*Inner Base Cylinder*/
inner_cylinder_diameter = outer_cylinder_base_diameter-outer_cylinder_minimum_wall_thickness-cylinder_clearance;
//how high the phone stand base extends above the cupholder
inner_cylinder_extended_height = 37;
inner_cylinder_height = inner_cylinder_extended_height+outer_cylinder_height;
inner_cylinder_top_rounding = 2;
inner_cylinder_wall = 6;
inner_cylinder_top_wall = 3;

/*Angled Front Cut*/
cutter_height=80;

/*Holder Values*/
holder_z_translation=15;

//back plate
back_plate_thickness = 8;
back_plate_height = 90;
back_plate_rounding=10;

//side walls
side_wall_thickness = 3;
side_wall_height = 20;
side_wall_rounding = 5;

//side wings
side_wing_z = 40;
side_wing_thickness = 3;
side_wing_height = 20;
side_wing_rounding = 5;


//front lip
front_lip_thickness = 3;
front_lip_height=16;

//floor
holder_floor_thickness = 3;

//holder dimensions
//clearance between phone and holder
clearance = 0.5;
//angle of phone holder relative to base
holder_tilt_angle = 30;
//holder offset from center of base front or back
holder_offset=0;
//how deep to embed the holder
holder_embedding_depth=5;
holder_inner_width = phone_bottom_width + clearance;
holder_inner_depth = phone_depth + clearance;
holder_width=holder_inner_width+2*side_wall_thickness;
side_wing_clearance = phone_middle_width + clearance;
holder_center_width = side_wing_clearance+2*side_wing_thickness;
holder_total_depth= holder_inner_depth+front_lip_thickness+back_plate_thickness;


//usb cutout
usb_cut_depth =12;
usb_cut_left_width = 7.5;
usb_cut_right_width = 7.5;
usb_cut_rounding = 3;

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

/*module angled_front_wall()
{
    cube([holder_width, cutter_depth_cuttern_height])
    
    
} */   

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
                    translate( [holder_width/2-(holder_width/2-usb_cut_right_width)/2,-holder_total_depth+back_plate_thickness/2+front_lip_thickness/2,0]) cuboid([holder_width/2-usb_cut_right_width, front_lip_thickness,front_lip_height], anchor=BOTTOM, rounding=usb_cut_rounding, edges =[TOP+LEFT, FRONT+LEFT]);
                    //floor plate left
                   rotate ([0,180,180]) translate ([-(holder_width/2-(holder_width/2-usb_cut_left_width)/2),holder_total_depth/2-back_plate_thickness/2,0]) cuboid([holder_width/2-usb_cut_left_width,holder_total_depth, holder_floor_thickness], anchor=BOTTOM, rounding=usb_cut_rounding, edges=[BACK+RIGHT, TOP+RIGHT]);
                     //front lip plate right
                    translate( [-(holder_width/2-(holder_width/2-usb_cut_left_width)/2),-holder_total_depth+back_plate_thickness/2+front_lip_thickness/2,0]) cuboid([holder_width/2-usb_cut_left_width, front_lip_thickness,front_lip_height], anchor=BOTTOM, rounding = usb_cut_rounding, edges=[TOP+RIGHT,FRONT+RIGHT ]);
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
        cuboid([holder_width, back_plate_thickness, back_plate_height], anchor = BOTTOM, rounding = back_plate_rounding,edges=[LEFT+TOP, RIGHT+TOP, LEFT+BOTTOM, RIGHT+BOTTOM]);
    translate([0,0,holder_z_translation]) phone_holder_face();  
    }    
}  

module place_holder()
{
    raw_height = inner_cylinder_height+(back_plate_thickness/2*sin(holder_tilt_angle));
        translate([0,0, raw_height-holder_embedding_depth])
    rotate([-holder_tilt_angle,0,0])
        phone_holder(); 
}  

module rotate_about_edge(a, v, edge_point) 
{
    translate(edge_point) 
    rotate(a, v) 
    translate(-edge_point) 
    children();
}

//========================================================
//BUILD
//========================================================
build_usb_notch=true;
add_side_wings = true;

cutter_y=50;
cutter_z=50;
//rotate([-holder_tilt_angle,0,0]) place_holder();
place_holder();
difference()
{
base_cylinder();
translate([0,-cutter_y/2-back_plate_thickness/2,0])rotate_about_edge(a=-holder_tilt_angle, v=[1,0,0],edge_point= [inner_cylinder_diameter, cutter_y, inner_cylinder_height]) cuboid([inner_cylinder_diameter,cutter_y,inner_cylinder_height], anchor=BOTTOM);
}
//place_holder();
//outer_sleeve();



//curved side wing approach
/*if (add_side_wings==true)
        {
            wing_offset=phone_bottom_width-phone_middle_width;
            //right side wing
            difference()
            {
                rotate ([90,0,0]) translate ([holder_width/2-(wing_offset+ side_wing_thickness)/2,side_wing_height/2+side_wing_z,back_plate_thickness/2]) cuboid([side_wing_thickness+wing_offset, side_wing_height, holder_inner_depth+front_lip_thickness], anchor=BOTTOM,rounding = side_wall_rounding, edges=[BACK+TOP,FRONT+TOP]);
                
                rotate ([90,0,0]) translate ([holder_width/2+wing_offset/2,side_wing_height/2+side_wing_z,back_plate_thickness/2]) cuboid([side_wing_thickness+wing_offset, side_wing_height+5, holder_inner_depth+front_lip_thickness+5], anchor=BOTTOM, rounding = wing_offset, edges=BOTTOM+LEFT);
            }    
*/    

//prop for prototype testing
/*h = 40; 
w1 = 30; // Needs to be wider to accommodate a shallow ramp
d = 5;

// Calculate top width for a 30 degree slope relative to the ground
w2 = w1 - (h / tan(60)); 

shift_x = (w1 - w2) / 2;

rotate([0,0,90]) translate ([15.8,20,-4.55]) prismoid(
    size1 = [w1, d], 
    size2 = [w2, d], 
    h = h, 
    shift = [shift_x, 0],
    anchor = BOT
);

rotate([0,0,90]) translate ([15.8,-20,-4.55]) prismoid(
    size1 = [w1, d], 
    size2 = [w2, d], 
    h = h, 
    shift = [shift_x, 0],
    anchor = BOT
);*/


/*translate([0,30,15]) rotate([0,270,90]) prismoid(
    size1 = [50, 50], 
    size2 = [50, 50], 
    h = height, 
    shift = [shift_x, 0]
);*/

//translate([0,30,15]) rotate([0,270,90]) prismoid(size1=[60,60], size2=[0,60], shift=[-30,0], h=30, anchor=BOTTOM);
