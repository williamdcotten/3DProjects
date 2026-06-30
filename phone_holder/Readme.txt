Improved Cupholder Cell Phone Mount
I just got a car, and while it has many redeeming features, a place to put my cellphone was not among them. The dash and console design are sleek and modern, which leaves a dearth of potential attachment points, so I was looking for a phone holder that would fit in the cupholder of my car. I found this one: 
https://makerworld.com/en/models/2346555-mobile-phone-cup-holder-generator#profileId-2565675 

which is a great design and really close to what I wanted (and will work for most people with less complication, so unless you see something specific you like here, I really would recommend that one instead. This one is inspired by that design, with all-original code (because both the comments and the geometry in the original are in German - elegant, precise, and very hard to understand), and with significant changes that probably won't matter to most people, but were important to me because:
- My frequent passenger often wants to see the phone. Since my cupholder has fins, a one-piece base was difficult to impossible to rotate in the holder.
- I use a USB cable with a long connector, and it bent on the side of the cylinder base, which would have eventually led to cable failure (probably at the worst possible time).
- I printed one for a friend who has a side mounted USB connector and required an asymmetrical USB cut, with more room on the right than on the left.
- Even with the fins (or maybe because of the fins) the straight cylinder tended to rattle around in the cupholder.
- My phone case is wider at the base (to protect the corners) than it is in the middle - even with higher wall, the phone didn't feel secure in the holder.
- Aesthetically, I prefer to carry the rounding motif into the USB cutout instead of having a square cut

So, this design is a more or less standard angled cellphone holder that fits in a cupholder, but it:
- Has a tapered outer sleeve that fits snugly into a tapered cupholder without rattling around.
- Has an outer sleeve and separate cylinder base for snug fit and easy rotation of the phone holder.
- Allows for a angled cut that follows the phone holder smoothly down the cylinder base to keep a longer USB connector from binding.
- Adds optional side wings in addition to the side walls. You can either use them to save printing by having sides at the top and bottom, or if you have a flared cellphone protective case, you can position the wings closer together than the lower side walls.
- Allows for different lengths for the left and right sides of the USB cutout for side mounted USB connectors.
- Allows for rounding of the USB cutout channel.

How to print it:
A lot of customization options. The important, must fill in ones are the phone and cupholder dimensions. Getting the bottom dimension of the cupholder can be tricky, and you may need to print some sizing rings (you can just slice the bottom 20mm or so off of the bottom of the outer sleeve) to get a snug fit without being so big the outer sleeve won't reach the bottom.

Some aesthetic juggling to do with the inner cylinder extended height, holder tilt angle, holder offset, holder z translation, and backplate height, especially if you use the angled cut to give a USB connector more clearance. The further back the holder offset is (back is positive, forward is negative), the further down the angled cut goes, and for crumbs and the like, you probably want it above the top of the outer sleeve. The further up the extended height goes (that is, how far it sticks above the cupholder, the more tilt angle you're probably going to want. You can set the phone holder an arbitrary distance above the backplate, but the default value seems to be fine for everything from a phone to a tablet. A backplate height of half the phone's height plus the holder offset seems to work best.  Side wings look better to me than high walls, even if you don't have an issue with a flared case, but you have the option to use them or not. You can choose to have the front lip at the bottom extend all the way from the USB cutout to the side walls (my preference) or have them extend halfway and be rounded on both sides. You can also choose not to include the angled cut if your USB cable doesn't need it. 

You'll want to print this out of PETG or the like (ASA, ABS). At least where I live, the PLA prototypes lasted less than two days before giving in to the heat. You'll also want to print the outer sleeve and the base/holder separately. Much more than 0.4mm clearance between cylinders, and they don't feel snug and wobble a bit when you rotate the phone, but PETG needs at least 0.6mm not to bind during printing. There's plenty of room to put both STLs on the same plate anyway. Unless you don't want the rotation feature - in that case, just set the inter_cylinder_clearance to 0 and have at it.

Customization, not Commercialization
Why no commercial license option? - mostly, so I don't annoy printers who might try to sell it. Getting the phone dimensions right took a pair of calipers, and getting the cupholder dimensions right took printing 3 different sizing test rings to confirm the bottom measurement, and two PLA prints before finally printing in PETG. (I considered cutting some grooves in the outer sleeve and some TPU expansion rings, deliberately leaving a little room between the sleeve and cupholder wall, and letting the TPU take on the task of providing a tight fit, but I got a snug fit after several tries without that.)  

You can read about our development of the cupholder here: https://spinningjennymfg.com/projects-automotive-bracket


This is a somewhat parametric America250 (celebrating the United States' 250th year since Independence) commemorative poker chip designed for patriotic and civic organizations. It's semi-parametric in the sense that, if you like the front design as is, and only want to choose between the backing rectangle design or the plain face design on the front face, and you have some relatively short text that you want to wrap around a logo that renders well in a 20wx9h space, then it's completely parametric. You can also choose whether or not to have the contrasting edge notches, whether you want to coin reeds or smooth sides, and whether to include a keychain hole. You can also raise the top design slightly instead of leaving it flush for a more "presentation" feel, I like the flush appearance better, but feel free to try it both ways. If you do raise it, a factor of 0.25 or 0.5 works best - more than that and the printing isn't reliable. If you want to make more changes than that, then it's not parametric. Color selection is entirely on the slicer - it renders as 5 separate STL files that you can colorize the way you want (so the white background one is from the same rendering as one of the blue background chips.) My favorite is the flush, blue background with white rectangles backing the red text - the red straight on the blue background tends to look a little washed out, and - as was pointed out to me - the white looks more like a Christmas snowflake than the 4th of July.

Spinning Jenny is not at all about commemoratives, memorabilia, or even items requiring much artistic talent (for one thing, our CEO only sees in gray scale). But we got asked to create a poker chip for a friend, and someone saw it and asked if we could do something for their organization, so here it is. I'ts an excerpt of a pretty robust customizable poker chip printing program that grew out of the project and that I'll publish soon.

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



