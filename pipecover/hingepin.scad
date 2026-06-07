include <BOSL2/std.scad>
include <BOSL2/threading.scad>



cylinder(180, 6.7,6.7);
translate ([0,0,-10]) cylinder(10,12,12);
translate ([0,0,185])threaded_rod(d=12.4, l=15, end_len2=5, pitch=1.5, $fn=64, bevel = true);

