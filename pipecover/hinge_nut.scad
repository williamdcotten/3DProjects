include <BOSL2/std.scad>
include <BOSL2/threading.scad>

threaded_nut(
    id = 12.4,
    h = 15,
    pitch = 1.5,
    nutwidth = 24, // Across flats
    bevel = true,
    $slop = 0.2
);

