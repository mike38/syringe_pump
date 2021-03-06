//nema_17_mount();

module nema_17_mount()
{
	$fs = 0.1;

	wall_thickness = 5;
	motor_width = 42;
	frame_width = motor_width + (wall_thickness + 1)*2;
	bolt = 4;
	height = 25;
	

	
	//center the whole thing in X
	translate([-frame_width/2, 0, 0])
	{
		difference()
		{
			//build the main unit.
			union()
			{
				//structure
				cube([wall_thickness, frame_width, frame_width]); //front face
				cube([frame_width, wall_thickness, frame_width]); //left face
				translate([frame_width-wall_thickness, 0, 0])     //right face
					cube([wall_thickness, frame_width, frame_width]);
            }

			//nema 17 mount
			rotate([90, 0, 0])
			{
				translate([frame_width/2, height, -wall_thickness])
				{
					translate([15.5, 15.5, 0])
						cylinder(r=bolt/2, h=wall_thickness+1);
					translate([-15.5, 15.5, 0])
						cylinder(r=bolt/2, h=wall_thickness+1);
					translate([15.5, -15.5, 0])
						cylinder(r=bolt/2, h=wall_thickness+1);
					translate([-15.5, -15.5, 0])
						cylinder(r=bolt/2, h=wall_thickness+1);

					cylinder(r=11.5, h=wall_thickness+1);

					translate([-11.5, 0, 0])
						cube([23, frame_width, wall_thickness+1]);
				}
			}

			//back slant cutaway
			translate([0, 0, frame_width+wall_thickness])
				rotate([45, 0, 0])
					translate([-frame_width, 0, -frame_width*2])
						cube(size=[frame_width*4, frame_width*2, frame_width*4]);


			//cutout / tidy up cubes.
			translate([wall_thickness, wall_thickness-0.1, -1])
				cube([frame_width-wall_thickness*2, frame_width-wall_thickness, motor_width*2]);
			translate([-frame_width/2,-frame_width/2, wall_thickness+motor_width])
				cube([frame_width*2, frame_width*2, frame_width]);
			translate([-frame_width/2, -frame_width/2,-frame_width])
				cube([frame_width*2, frame_width*2, frame_width]);
		}
	}
}

