This is a somewhat parametric America250 (celebrating the United States' 250th year since Independence) commemorative poker chip designed for patriotic and civic organizations. Spinning Jenny is not at all about commemoratives, memorabilia, or even items requiring much artistic talent (for one thing, our CEO only sees in gray scale). But we got asked to create a poker chip for a friend, and someone saw it and asked if we could do something for their organization, so here it is. 

The chip is an excerpt of a pretty robust customizable poker chip printing program that grew out of the project and that I'll publish soon.

It's parametric in the sense that, if you like the front design as is, and only want to choose between the backing rectangle design or the plain face design on the front face, whether you want stars or not, and if you have some relatively short text that you want to wrap around a logo that renders well in a 20wx9h space, then it's completely parametric. Otherwise, the code is "extensible" as they say. 

You can also choose whether or not to have the contrasting edge notches, whether you want to coin reeds or smooth sides, and whether to include a keychain hole. And you can also raise the top design slightly instead of leaving it flush for a more "presentation" feel, I like the flush appearance better, but feel free to try it both ways. If you do raise it, a factor of 0.25 or 0.5 works best - more than that and the printing isn't reliable. If you want to make more changes than that, then it's not parametric. Color selection is entirely on the slicer - it renders as 5 separate STL files that you can colorize the way you want (so the white background one is from the same rendering as one of the blue background chips.) My favorite is the flush, blue background with white rectangles backing the red text - the red straight on the blue background tends to look a little washed out, and - as was pointed out to me - the white looks more like a Christmas snowflake than the 4th of July. The raised looks a little ornate but some people prefer that look.

I've included a bash script that renders each element in turn, unless you enjoy sitting in front of OpenSCAD for a couple of hours waiting for it to render - If you're using the Makerworld customizer, maybe it will render faster than OpenSCAD on my computer.

Printing came out well for me using a 0.4mm nozzle, after much experimentation and swearing. Everything in the picture is from the 0.4; I'm going to try printing with a 0.2 this weekend. Lot's of adjustments were required to get a clean print, here's what worked for me (mostly slowing down the print speed):
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
Bottom Surface Pattern Concentric //Monotonic if using text/graphics on bottom
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

You can add a washer or a US coin for weight. If you do, the quarter is really close if you add the keychain hole; I'd recommend the nickel. A standard washer fits nicely, but is a little light, the nickel works really well. If you add the weight, you need to add a pause at Layer (washer) or layer 15 (coin). Even if you add the weights, if you print more than one on a bed at a time, you really need to do it by object (which means a pause about 2 hours apart for the weight), but by layer strings as the nozzle zips to the next object.

