// Openbeam Kossel Pro tool holder
// Mount for the included wera drivers
// License: CC1.0 Universal

$fn=50;

plate_length = 76;
plate_height = 18;

plate_width  = 20;
plate_thickness = 2;

num_drills = 3;
inset_depth = 1.5;
drill_depth = 4;

module inset_drills(drill_size, inset_depth) {
	for ( i = [ 1 : num_drills ] ) {
		translate([0, i*20, -drill_depth]) cylinder(r=drill_size/2, h=drill_depth);
		translate([0, i*20, -1]) cylinder(r=drill_size/1.2, h=inset_depth);
	}
}

// Top plate
difference() {
	union() {
		// Mounting plate -- at 2mm plate_thickness, the printer will continually sit around drawing
		// thin outer perimeters which are slow. So reduce perimeter counts when slicing or increase 
       // plate_thickness individually here for faster performance.
		cube([plate_thickness, plate_length, plate_height]);

		// Bottom plate
		cube([plate_width, plate_length, plate_thickness]);
		for ( i = [ 1 : num_drills ] ) {
			translate([13, -2, 2]) translate([0, i*20, 0]) cylinder(r=4.5/1.2, h=5);
		}
	}

	// Mounting plate drills
	translate([2,  -2, 10]) rotate([0,90,0]) inset_drills(3.75, 2);
	// Driver drills
	for ( i = [ 1 : num_drills ] ) {
		translate([13, -2, 2]) translate([0, i*20, -3]) cylinder(r=4.5/2, h=9);
		
	}	
}