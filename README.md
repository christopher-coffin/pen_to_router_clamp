# Clamp to attach a pen (drawing tool) to a CNC router
3d model of a clamp to attach a pen to a router for drawing with a CNC

This is inspired by the Shapeoko Quick Draw CNC Pen Holder https://shop.carbide3d.com/collections/accessories/products/quickdraw. I wanted something to help with the squaring of my CNC, figuring that if I could draw lines on paper, that would be easier than measuring out distances from some point on the machine itself. Carbide is a great company and I love their tools, but I wasn't willing to pay $20 for a plastic tool, plus shipping.

The normal V-shaped base works well for most drawing implements, but I wanted something that would allow custom attachments for angled drawing tools to still be vertically aligned. In theory, this should also allow for uniformity in the centerpoint of multiple writing tools. This means you should be able to swap out writing tools between parts of your drawing, even if the drawing tools are of different types or manufacturers.

I designed the band holders to swap in and out while still attached to the machine. The writing tool holders are meant to slide up slightly to allow for pressure without breaking the writing tool. You should be able to snap writing tools into the specific pen holders and they'll hold them well enough to allow you to attach the rubber bands.

I revised my original build with the following updates:
* moved the clamp screws to the side. 
* I also added a band hook that allows you to wrap up a rubber band, in case you need to adjust the tension.
* added hooks to the left side, to reduce the number of things you have to hold at the same time when swapping out pens
* added alignment guides to keep the band holders evenly placed.

I use a version of the parametric clamp scad: https://www.thingiverse.com/thing:31982#google_vignette. I simply added the ability to rotate the base relative to the screws to make access easier on the shapeoko.

I also use a version of the BOSL2 toolset: https://github.com/BelfrySCAD/BOSL2
