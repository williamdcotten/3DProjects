include <BOSL2/std.scad>
$fn = 192;
cube_x=90;
cube_y=35;
cube_z=2.5;
cube_rounding = 6;
cube_smoothing=1;
recess_depth=0.6;
recess_horizontal_shrink=6;
//right for a chain keychain
keychain_diameter=3.5;
keychain_offset=7.5;//4+keychain_diameter/2;

//render="all";
//render="body";
//render="top"render="bottom";

module key_body()
{
    diff()
    {
        cuboid ([cube_x, cube_y, cube_z], rounding = cube_rounding, edges="Z", anchor=BOTTOM) edge_profile([TOP, BOTTOM]) mask2d_roundover(r=cube_smoothing);
        
            
            //align(TOP, inside=true, shiftout=0.01) cuboid([cube_x-recess_horizontal_shrink, cube_y-recess_horizontal_shrink, recess_depth]);
            tag("remove") text_top(); 
            tag("remove") text_bottom();
            tag("remove") left ((cube_x/2)-keychain_offset) cyl(d=keychain_diameter, h=cube_y*10, center=true);        
    }    
}

module text_top() 
{
    up(cube_z) down(recess_depth) 
    linear_extrude(height=recess_depth) 
    {
        back(12) //center is 3
            text("May I be filled with loving kindness", size=3.5, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
        
        back(6) //center is 3
            text("May I be strong", size=3.5, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
        
        //back(3) 
           text("May I be well", size=3.5, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
        fwd(6)
            text("May I be grateful", size=3.5, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
        
        fwd(12)
            text("May I know peace", size=3.5, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
    }
}

module text_bottom() 
{
    /*translate([0,0,-cube_y])*/ mirror([1,0,0]) rotate([0,0,180])
    linear_extrude(height=recess_depth) 
    {
        back(4) 
            text("I have been given", size=6, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
        
        fwd(4) 
            text("a new life", size=6, font="Liberation Sans:style=Bold", 
                 halign="center", valign="center");
    }
}


//==============================================================================
//BUILD
//==============================================================================
if (render == "all" || render == "body")
{
        color ("blue") key_body();
}    
if (render=="all" || render == "top")
{
    color ("white") text_top();
}    
if (render=="all" || render =="bottom")
{    
    color ("white") text_bottom();
}