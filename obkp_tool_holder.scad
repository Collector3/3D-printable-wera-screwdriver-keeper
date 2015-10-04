// Openbeam Kossel Pro tool holder
// Mount for the included wera drivers
// License: CC1.0 Universal

$fn=50;

plate_length = 76;
plate_height = 20;

plate_width  = 20;
plate_thickness = 2;

num_drills = 3;
inset_depth = 1.5;
drill_depth = 4;

module openbeam() {
    linear_extrude(rotate = 90, height = 100, center = true, convexity = 10) import (file = "openbeam.dxf");
}


module inset_drills(distance, drill_size, inset_depth) {
    translate([0, distance*20, -drill_depth]) cylinder(r=drill_size/2, h=drill_depth);
    translate([0, distance*20, -1]) cylinder(r=drill_size/1.2, h=inset_depth);
}

module plate() {
    difference() {
      union() {
        // Interface plate (to extrusion)
        cube([plate_thickness, plate_length, plate_height]);
        
        // Bottom plate
        cube([plate_width, plate_length, plate_thickness]);
        
        // Top 'ceiling' wall  
        translate([-17, 0, 10]) cube([18, plate_length, plate_height - 10]); 
          
        // Bottom 'floor' wall
        translate([-17, 0, 0]) cube([18, plate_length, plate_height - 10]);    
      }
    
      // Mounting plate drills
      translate([2,  -2, 10]) rotate([0,90,0]) inset_drills(2, 3.75, 2);
      
      // Driver drills
      for ( i = [ 1 : num_drills ] ) {
        translate([13, -2, 2]) translate([0, i*20, -3]) cylinder(r=4.5/2, h=9);
      }
      
      #translate([-15, 0, 2]) cube([15, plate_length, 16]);
      #translate([-18, 0, 4]) cube([4, plate_length, 12]);
    }
}
rotate([0, 0, 90]) translate([8, -35, -10]) plate();
rotate([0, 90, 180]) translate([0, 0, 0]) openbeam();