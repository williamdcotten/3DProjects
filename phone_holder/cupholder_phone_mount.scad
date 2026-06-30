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
phone_width=81;
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
//back plate
back_plate_thickness = 10;
back_plate_height = 90;
back_plate_rounding=10;

//side walls
side_wall_thickness = 3;
side_wall_height = 60;
side_wall_rounding = 5;

//front lip
front_lip_thickness = 3;
front_lip_height=16;

//floor
holder_floor_thickness = 3;

//holder dimensions
//clearance between phone and holder
clearance = 0.5;
holder_inner_width = phone_width + clearance;
holder_inner_depth = phone_depth + clearance;
holder_width=holder_inner_width+2*side_wall_thickness;
holder_total_depth= holder_inner_depth+front_lip_thickness+back_plate_thickness;
holder_tilt_angle = 30;



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

//========================================================
//BUILD
//========================================================

cuboid([holder_width, back_plate_thickness, back_plate_height], anchor = BOTTOM, rounding = back_plate_rounding,edges=[LEFT+TOP, RIGHT+TOP]);
rotate ([90,0,0]) translate ([holder_width/2-side_wall_thickness/2,side_wall_height/2,back_plate_thickness/2]) cuboid([side_wall_thickness, side_wall_height, holder_inner_depth+front_lip_thickness], anchor=BOTTOM,rounding = side_wall_rounding, edges=BACK+TOP);
rotate ([90,0,0]) translate ([-holder_width/2+side_wall_thickness/2,side_wall_height/2,back_plate_thickness/2]) cuboid([side_wall_thickness, side_wall_height, holder_inner_depth+front_lip_thickness], anchor=BOTTOM, rounding = side_wall_rounding, edges=BACK+TOP);
rotate ([0,180,180]) translate ([0,holder_total_depth/2-back_plate_thickness/2,0]) cuboid([holder_width,holder_total_depth, holder_floor_thickness], anchor=BOTTOM);
translate([0,-holder_total_depth+back_plate_thickness/2+front_lip_thickness/2,0]) cuboid([holder_width, front_lip_thickness,front_lip_height], anchor=BOTTOM);
//base_cylinder();
//outer_sleeve();




