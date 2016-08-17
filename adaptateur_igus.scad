

include<./mount.scad>

$fn=60;

lenght_fix_support=74;
depth_fix_support=22;
height_fix_support=40;

height_feet=52;

lenght_carriage=73;
depth_carriage=69;
height_carriage=height_fix_support;

//syringe
diameter_body=22;
diameter_end_body=39;
depth_end_body=3.5;
diameter_plunger_end=24;
depth_plunger_end=2.2;
diameter_plunger=18;


screw_radius=6.4/2;
screw_radius_top=10.5/2;
screw_head_height=6;

m3_radius=3.6/2;

module fix_support() {
    center_pad=3;
   difference(){
       cube([ lenght_fix_support,depth_fix_support,height_fix_support]);
    
       //syringe plunger
       translate ([lenght_fix_support/2,-.1,height_fix_support-diameter_plunger_end/2]) {
            rotate ([-90,0,0])
                cylinder(r=diameter_plunger/2,h=(depth_fix_support-depth_end_body)/2+center_pad+.2);
            translate ([-diameter_plunger/2,0,0])
                cube([diameter_plunger,(depth_fix_support-depth_end_body)/2+center_pad+.2,diameter_plunger_end]);}
   
    //syringe end
        translate ([(lenght_fix_support-diameter_end_body)/2,(depth_fix_support-depth_end_body)/2+center_pad,height_fix_support-diameter_plunger_end])
            cube([diameter_end_body,depth_end_body,diameter_plunger_end+.1]);
            
            
      //syringe body
            translate ([lenght_fix_support/2,(depth_fix_support+depth_end_body)/2+center_pad-.1,height_fix_support-diameter_plunger_end/2]) {
            rotate ([-90,0,0])
                cylinder(r=diameter_body/2,h=(depth_fix_support-depth_end_body)/2+.2);
            translate ([-diameter_body/2,0,0])
                cube([diameter_body,(depth_fix_support-depth_end_body)/2+.2,diameter_plunger_end]);}
                
        // screw
         screw_spacing=40;
         screw_lenght=28;
          
         hole_pad=3;
                
         for (i =[-1,1]) {
             translate([lenght_fix_support/2+i*screw_spacing/2,hole_pad+screw_radius,-0.1]){
             
                     cylinder(r=screw_radius,h=height_fix_support+.2);
                     translate([0,0,screw_lenght-screw_head_height]) cylinder(r=screw_radius_top,h=height_fix_support+.2);
                 
             }}
                
            }
};

module carriage () {
    screw_x_space=60;
    screw_y_space=56;
    screw_lenght=23;
    depth_retainer=depth_carriage-screw_y_space;
    difference () {
        union(){
            cube([lenght_carriage,depth_carriage,screw_lenght]);
            translate([0,screw_y_space,0]) cube([lenght_carriage,depth_retainer, height_carriage]);
        }
        
        //syringe plunger
       translate ([lenght_carriage/2,depth_carriage-depth_retainer/2-.1,height_carriage-diameter_plunger_end/2]) {
            rotate ([-90,0,0])
                cylinder(r=diameter_plunger/2,h=depth_retainer/2+.2);
            translate ([-diameter_plunger/2,0,0])
                cube([diameter_plunger,depth_retainer+.2,diameter_plunger_end]);}
                
        //syringe end
        translate ([(lenght_carriage-diameter_plunger_end)/2,depth_carriage-(depth_retainer+depth_plunger_end)/2,height_carriage-diameter_plunger_end])
            cube([diameter_plunger_end,depth_plunger_end,diameter_plunger_end+.1]);
     
          //hole 
          for (y =[-1,1]) {
              for (x = [-1,1]) {
                    translate([lenght_carriage/2+x*screw_x_space/2,depth_carriage/2+y*screw_y_space/2,-0.1]){
             
                     cylinder(r=screw_radius,h=height_carriage+.2);
                     translate([0,0,screw_lenght-screw_head_height]) cylinder(r=screw_radius_top,h=height_carriage+.2);

    }
}}


}
}

//carriage();

module foot (){
    difference(){
       cube([ lenght_fix_support,depth_fix_support,height_feet]);

// screw
         screw_spacing=60;
         screw_lenght=28;
         M8_radius=8.4/2;
         M8_top_height=8;
         M8_radius_top=13.5/2;
         hole_pad=3;
                
         for (i =[-1,1]) {
             translate([lenght_fix_support/2+i*screw_spacing/2,depth_fix_support/2,-0.1]){
             
                     cylinder(r=M8_radius,h=height_fix_support+.2);
                     translate([0,0,screw_lenght-M8_top_height]) cylinder(r=M8_radius_top,h=height_fix_support+.2);
                 
             }}
  
             
            }
    
};

module front_foot() {
    difference () {
        foot ();
// slant cut
        # translate([-0.1,0,29])    
        rotate ([5,0,0]) cube([ lenght_fix_support+.2,depth_fix_support+2,height_fix_support]);
        
    
}
}


motor_gap=13;
length_motor_support=126;

module rear_foot() {
    height=21; //add from front for 5deg angle
    support_thickness=5;
    
    difference () {
        union() {
            foot ();
            translate([0,depth_fix_support-.1,motor_gap])
            cube ([lenght_fix_support,length_motor_support-depth_fix_support,support_thickness]);
        }
// slant cut
         translate([-0.1,0,29+height])    
        rotate ([5,0,0]) cube([ lenght_fix_support+.2,depth_fix_support+2,height_fix_support]);
        
 // motor fixation
        
        for (x =[5,lenght_fix_support-5]) {
            hull (){
                translate([x,length_motor_support-10-50,motor_gap-.1])
                cylinder(r=m3_radius, h=support_thickness+.2);
                translate([x,length_motor_support-10,motor_gap-.1])
                cylinder(r=m3_radius, h=support_thickness+.2);
            }
        }
        
    
}
}

module rear_foot_print1 () {
    difference () {
        rear_foot();
        translate([-0.1,-0.1,motor_gap-.1])
            cube ([lenght_fix_support+.2,length_motor_support+.2,height_fix_support]);
    }
}
module rear_foot_print2 () {
    difference () {
        rear_foot();
        translate([-0.1,-0.1,-.1])
            cube ([lenght_fix_support+.2,length_motor_support+.2,motor_gap+.1]);
    }
}


module motor () {
    motor_width = 42;
    wall_thickness = 5;
    
    difference () {
    union () {
        nema_17_mount();
        
        //side support
        for (i =[-1,1]){ 
        translate([i*(motor_width/2+1+((lenght_fix_support-motor_width)/2-1)/2),(motor_width+12)/2,wall_thickness/2])
        cube ([(lenght_fix_support-motor_width)/2-1,motor_width+12,wall_thickness],center=true);
        }
    }
        //fixation hole
        
        for (x=[-1,1]){ 
            for (y =[10,motor_width+2]){ 
                translate([x*(lenght_fix_support/2-5),y,-.1])
                    cylinder(r=m3_radius,h=wall_thickness+.2);
            }
        }
    }
}

//motor ();
//front_foot();
//rear_foot_print1();
rear_foot_print2();