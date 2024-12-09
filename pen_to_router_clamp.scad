include <BOSL2/std.scad>
include <parametric_clamp.scad>

$fn=120;
// clamp parameters
ring_inner_dia = 65;
clamp_height = 35;
fudge = 0.01;
base_width = 20;
base_depth = 20;
support_width = 5;
support_thickness = 6;
hook_stop_starting_depth = 3;
triangle_size = 1.0+0.2+fudge;

// parameters for pen holder
plate_connector_depth = 8;
base_grip_border_size = 4;
base_grip_inset = 6;
base_grip_distance = 2;
base_grip_center_depth = 3;
// parameters for pen cutout
pen_cutout_depth = 15;//needs to be a fixed distance for all pens
pen_extra_clasp_width = 1.5;//extra width beyond max pen diameter

fit_dist = 0.2;


pencil_diameter = [8, 8];// #2 pencil
pentel_diameter = [9.75, 9.75];// pentel
sharpie_diameter = [10.3, 11.15];//[10.5, 11.25] //fine point sharpie


module pen_clamp() {
    band_support_depth = base_width*0.4;
    difference() {
        union() {
            // clamp
            translate([0, 0, clamp_height/2.0]) 
                clamp(ring_inner_dia=ring_inner_dia, 
                        height = clamp_height, 
                        base_thickness=base_depth, 
                        base_angle=-90, 
                        screw_count = 2, 
                        screw_diameter= 6.4, // add in some fudge for fit
                        nut_thickness = 5, 
                        nut_diameter = 11.55, 
                        jaws_width = 15, 
                        jaws_thickness=8);
            // band holder supports
            translate([0,-ring_inner_dia/2.0-band_support_depth, clamp_height/2.0])
                difference()
                {
                    union() {
                        // support - hook stop
                        translate([0,-hook_stop_starting_depth, 0])
                            cube([base_width+support_width*2, support_thickness, clamp_height], center=true);//, rounding=1, edges = ["X", "Y", "Z"]);
                        // rounded edges
                        translate([0, -(hook_stop_starting_depth+support_thickness/2.0), 0]) {
                            difference() {
                                union() {
                                    translate([base_width/2.0+support_width, 0, 0])
                                        cylinder(r=support_thickness, h=clamp_height, center=true);
                                    translate([-(base_width/2.0+support_width), 0, 0])
                                        cylinder(r=support_thickness, h=clamp_height, center=true);
                                }
                                translate([0,-support_thickness/2.0, 0])
                                    cube([base_width+support_width*2+support_thickness*2, support_thickness, clamp_height+fudge*2], center=true);
                            }
                        }
                    }
                    // indents for hooking hooks
                    color("blue") {
                        translate([base_width/2.0+triangle_size*sin(60), 0, 0])
                            rotate([0, 0, -90])
                                translate([triangle_size*sin(30)-fudge, 0, 0])
                                    cylinder(r=triangle_size, h=clamp_height+fudge*2, center=true, $fn=3);
                        scale([-1, 1, 1])
                            translate([base_width/2.0+triangle_size*sin(60), 0, 0])
                                rotate([0, 0, -90])
                                    translate([triangle_size*sin(30)-fudge, 0, 0])
                                        cylinder(r=triangle_size, h=clamp_height+fudge*2, center=true, $fn=3);
                    }
                }
        }
        // cutout inset for grips
        color("blue")  {
            front_of_band_support = -ring_inner_dia/2.0-band_support_depth-support_thickness/2.0-hook_stop_starting_depth;            
            translate([base_width/2.0, front_of_band_support, clamp_height/2.0]) {
                translate([-base_grip_inset/4.0,-base_grip_center_depth/2.0-fit_dist, 0])
                    cube([base_grip_inset/2.0+fudge+fit_dist, base_grip_center_depth+fit_dist*2, clamp_height+fudge*2], center=true);
                translate([0,-base_grip_center_depth-base_grip_center_depth/2.0-fit_dist, 0])
                    cube([fudge+fit_dist, base_grip_center_depth+fit_dist*2, clamp_height+fudge*2], center=true);
            }
            scale([-1,1,1])
                translate([base_width/2.0, front_of_band_support, clamp_height/2.0]) {
                    translate([-base_grip_inset/4.0,-base_grip_center_depth/2.0-fit_dist, 0])
                        cube([base_grip_inset/2.0+fudge+fit_dist, base_grip_center_depth+fit_dist*2, clamp_height+fudge*2], center=true);
                    translate([0,-base_grip_center_depth-base_grip_center_depth/2.0-fit_dist, 0])
                        cube([fudge+fit_dist, base_grip_center_depth+fit_dist*2, clamp_height+fudge*2], center=true);
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


module pen_holder(fn, pen_diameter, pen_grip_percent=0.3) {
    max_pen_diameter = max(pen_diameter[0], pen_diameter[1]);
    pen_grip_depth = max_pen_diameter*pen_grip_percent;
    slide_in_cutout_depth = pen_cutout_depth+(max_pen_diameter*0.7)/2.0;
    
    translate([0, 0, clamp_height/2.0+base_grip_border_size/2.0]) {
        difference() {
            union() {
                // large backing
                translate([0, plate_connector_depth/2.0, 0])
                    cube([base_width+base_grip_border_size, plate_connector_depth, clamp_height+base_grip_border_size], center=true);
                // pen bump
                translate([0, plate_connector_depth+(pen_cutout_depth-plate_connector_depth)/2, 0])
                    cube([max_pen_diameter+pen_extra_clasp_width, pen_cutout_depth-plate_connector_depth, clamp_height+base_grip_border_size], center=true);
            }
            // pen holder cutout
            translate([0, pen_cutout_depth, 0])
                cylinder(r1=pen_diameter[0]/2.0, r2=pen_diameter[1]/2.0, h=clamp_height+base_grip_border_size+fudge*2, center=true, $fn=fn);
            // back grip cutout
            color("blue")
                translate([0, base_grip_distance/2.0, base_grip_border_size/4+fudge])
                    cube([base_width-base_grip_inset, base_grip_distance+fudge, clamp_height+base_grip_border_size/2.0+fudge*2], center=true);
            // back middle cutout
            translate([0, base_grip_distance+base_grip_center_depth/2.0, base_grip_border_size/4])
                cube([base_width+0.1, base_grip_center_depth+fudge, clamp_height+base_grip_border_size/2.0+fudge*2], center=true);
        }
        difference() {
            union() {
                // pen bump
                // distance from half of backing to pen_clasp_overhang percent of pen diameter
                translate([0, pen_cutout_depth+pen_grip_depth/2, 0])
                    cube([max_pen_diameter+pen_extra_clasp_width, pen_grip_depth, clamp_height+base_grip_border_size], center=true);
            }
            // pen holder cutout
            translate([0, pen_cutout_depth, 0])
                scale([1, 0.9, 1])
                    cylinder(r1=pen_diameter[0]/2.0, r2=pen_diameter[1]/2.0, h=clamp_height+base_grip_border_size+fudge*2, center=true, $fn=fn);
            // slide in cutout, angled cutout to allow for pens to snap in easily
            translate([0, slide_in_cutout_depth, 0])
                cylinder(r=(max_pen_diameter+pen_extra_clasp_width)/2.0, h=clamp_height+base_grip_border_size+fudge*2, center=true, $fn=6);
        }
    }
}


module all_the_pens() {
    translate([0, 100, 0]) {
        spacing = 30;
        pen_holder(fn=4, pen_diameter=sharpie_diameter, pen_grip_percent=0);// triagle
        translate([spacing, 0, 0]) pen_holder(fn=120, pen_diameter=sharpie_diameter);//fine point sharpie
        translate([-spacing, 0, 0]) pen_holder(fn=120, pen_diameter=pentel_diameter);// pentel rsvp
        translate([0, spacing, 0]) pen_holder(fn=6, pen_diameter=pencil_diameter);//#2 pencil
    }
}

module reference_pen_holder() {
    translate([0,-ring_inner_dia/2.0-base_width+base_grip_distance+base_grip_center_depth-0.1, clamp_height+base_grip_border_size/2.0])
        scale([1,-1,-1])
            color("purple")
                pen_holder(fn=4, pen_diameter=sharpie_diameter, pen_grip_percent=0);// triagle
}
//band_holder();
pen_clamp();
//reference_pen_holder();
//all_the_pens();

// reference pen hoilder with clamp
/*
*/
