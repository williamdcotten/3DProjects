include <BOSL2/std.scad>
$fn=128;

difference()
{
union() 
{
     translate ([18.45, 0, 0])
            cuboid([30.4,30.4,45], anchor=BOTTOM, rounding=2, except=BOTTOM);
     cuboid([8.9, 24.7, 80], anchor=BOTTOM, rounding=1, except=BOTTOM);
} 
     translate ([18.45, 0, 0])
            cuboid([28.1,28.1,47], anchor=BOTTOM);
     translate([0,0,5]) cuboid ([6.4, 22.2, 82], anchor=BOTTOM);
}

