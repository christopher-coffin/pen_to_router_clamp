include <BOSL2/std.scad>

include <parametric_clamp.scad>

$fn=120;
ring_inner_dia = 65;
clamp_height = 35;
fudge = 0.01;


module pen_clamp() {
    base_width = 20;
    support_width = 5;
    support_thickness = 6;
    hook_stop_starting_depth = 3;
    triangle_size = 1.0+0.2+fudge;
    union() {
        translate([0, 0, clamp_height/2.0]) 
            clamp(ring_inner_dia=ring_inner_dia, height = clamp_height, screw_count = 2, screw_diameter= 6.4, nut_diameter = 11.55, jaws_width = 15);
        translate([ring_inner_dia/2.0+base_width/2, 0, clamp_height/2.0])
            difference()
            {
                union() {
                    // squarish base
                    cube([20, base_width, clamp_height], center=true);
                    // support - hook stop
                    translate([hook_stop_starting_depth, 0, 0])
                        cube([support_thickness, base_width+support_width*2, clamp_height], center=true);//, rounding=1, edges = ["X", "Y", "Z"]);
                    // rounded edges
                    translate([hook_stop_starting_depth+support_thickness/2.0, 0, 0]) {
                        difference() {
                            union() {
                                translate([0, base_width/2.0+support_width, 0])
                                    cylinder(r=support_thickness, h=clamp_height, center=true);
                                translate([0,-(base_width/2.0+support_width), 0])
                                    cylinder(r=support_thickness, h=clamp_height, center=true);
                            }
                            translate([support_thickness/2.0, 0, 0])
                                cube([support_thickness, base_width+support_width*2+support_thickness*2, clamp_height+fudge], center=true);
                        }
                    }
                }
                // indents for hooking hooks
                color("blue") {
                    translate([0, base_width/2.0+triangle_size*sin(60), 0])
                        translate([triangle_size*sin(30)-fudge,0,0])
                            cylinder(r=triangle_size, h=clamp_height+fudge, center=true, $fn=3);
                    scale([1, -1, 1])
                        translate([0, base_width/2.0+triangle_size*sin(60), 0])
                            translate([triangle_size*sin(30)-fudge,0,0])
                                cylinder(r=triangle_size, h=clamp_height+fudge, center=true, $fn=3);
                }
            }
    }    
}


module band_holder() {
    base_width = 20;
    support_width = 5;
    support_depth = 7;
    support_thickness = 6;
    hook_stop_starting_depth = 3;
    triangle_size = 1.0+fudge;

    translate([ring_inner_dia/2.0+base_width/2, 0, clamp_height/2.0])
        color("blue") 
        {
            union() {
                // support - hook stop
                band_holder_thickness = 3;
                translate([-band_holder_thickness/2.0, base_width/2.0+band_holder_thickness/2.0, 0])
                    cube([band_holder_thickness, band_holder_thickness, clamp_height], center=true);
                translate([-band_holder_thickness/2.0, base_width/2.0+support_width, 0]) {
                    cuboid([band_holder_thickness, support_width*2, clamp_height+4], rounding=1, edges = ["X", "Y", "Z"]);
                    translate([band_holder_thickness/2.0-support_depth/2.0, -support_width+band_holder_thickness/2.0, 0]) 
                        rotate([0,0,90])
                            cuboid([band_holder_thickness, support_depth, clamp_height+4], rounding=1, edges = ["X", "Y", "Z"]);
                    translate([band_holder_thickness/2.0-support_depth/2.0, support_width-band_holder_thickness/2.0, 0]) 
                        rotate([0,0,90])
                            cuboid([band_holder_thickness, support_depth, clamp_height+4], rounding=1, edges = ["X", "Y", "Z"]);
                }
            }
            // indents for hooking hooks
            difference() 
            {
                translate([0, base_width/2.0+triangle_size*sin(60), 0])
                    translate([triangle_size*sin(30)-fudge,0,0])
                cylinder(r=triangle_size, h=clamp_height, center=true, $fn=3);
                cutout_size = 10;
                color("white") {
                    translate([((cutout_size)/2/sin(45)), base_width/2.0+triangle_size*sin(60), -clamp_height/2.0])
                        rotate([0, 45, 0])
                            cube([cutout_size, cutout_size, cutout_size], center=true);
                    translate([((cutout_size)/2/sin(45)), base_width/2.0+triangle_size*sin(60), clamp_height/2.0])
                        rotate([0, 45, 0])
                            cube([cutout_size, cutout_size, cutout_size], center=true);
                }
            }
        }
}


module pen_holder() {
    border = 4;
    plate_width = 20;
    out_scale = 0.8;
    pencil_diameter = [8, 8];// #2 pencil
    pentel_diameter = [9.75, 9.75];// pentel
    sharpie_diameter = [10.5, 11.25]; 
    pen_diameter = sharpie_diameter;
    //cube with cutout and triangle with circle cutout to hold pen
    translate([0, 0, clamp_height/2.0+border/2.0]) {
        difference() {
            union() {
                cube([plate_width+border, 5, clamp_height+border], center=true);
                difference () {
                        //scale([out_scale, out_scale, 1])
                        //    cylinder(r=(plate_width+border)/2, h=clamp_height+border, center=true, $fn=6);
                    translate([0, plate_width/4, 0])
                    cube([pen_diameter[1], plate_width/2.0, clamp_height+border], center=true);
                    translate([0, -10/2, 0])
                        cube([plate_width+border, 10, clamp_height+border+fudge], center=true);
                }
            }
            // pen holder cutout
            translate([0, plate_width/2, 0])
                // v shape
                rotate([0, 0, 45])
                    cube([pen_diameter[1], pen_diameter[1], clamp_height+border+fudge*2], center=true);
                // cylinder shape
                //cylinder(r1=pen_diameter[0]/2.0, r2=pen_diameter[1]/2.0, h=clamp_height+border+fudge, center=true);
            // back cutout
            translate([0, -10/2, border/4])
                cube([plate_width+0.1, 10, clamp_height+border/2.0+fudge], center=true);
        }
    }
}



band_holder();
//pen_clamp();

