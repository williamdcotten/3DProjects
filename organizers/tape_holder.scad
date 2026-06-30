include <BOSL2/std.scad>

$fn = 196;
R = 39.5;      // main channel radius
r = 1.0;    // lip roundover radius
block = [200, 90, R+5];
inner_shift = 6;

//FUNCTIONS FOR CUTTING SEMI-CIRCLE CHANNEL
//WITH ROUNDED LIPS
function arc(c, rad, a1, a2, n=16) =
    [for (i=[0:n])
        let(a = a1 + (a2-a1)*i/n)
        [c[0] + rad*cos(a), c[1] + rad*sin(a)]
    ];

module rounded_half_channel_profile(R, r) 
{
    cx = sqrt(R*R + 2*R*r);

    // Tangency point between main circle and lip fillet circle
    tx = R * cx / (R + r);
    ty = -R * r / (R + r);

    theta = atan2(-ty, tx);
    phi   = atan2(ty + r, tx - cx);

    polygon(points = concat(
        // right lip fillet: top face to main circle
        arc([cx, -r], r, 90, phi, 12),

        // main bottom semicircle
        arc([0, 0], R, -theta, -180 + theta, 48),

        // left lip fillet: main circle back to top face
        arc([-cx, -r], r, 180 - phi, 90, 12)
    ));
}

module rounded_channel_cutter(R, r, len) 
{
    rotate([90,0,270])
    linear_extrude(height=len, center=true)
        rounded_half_channel_profile(R, r);
}


difference() 
{
    cuboid(block, anchor=BOTTOM, rounding = 2);
    
    translate([block[0]/2-35.5,0,block[2]])
        rounded_channel_cutter(39.5, r, 65);
    
    translate([-34, 15, block[2]])
        rounded_channel_cutter(24.5, r, 125);
    
    rotate (90)translate([-27.5,32.5,block[2]+20]) 
        rounded_channel_cutter(60, r, 25);
}



