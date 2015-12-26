include <Measured_numbers.scad>

module M3_screw(h, updown=false){
  color("grey"){
    cylinder(r=M3_diameter/2, h=h);
    if(updown){
      translate([0,0,h-M3_head_height])
        cylinder(r=M3_head_diameter/2, h=M3_head_height, $fn=6);
    }else{
      cylinder(r=M3_head_diameter/2, h=M3_head_height, $fn=6);
    }
  }
}
//M3_screw(10);

module Nema17_screw_translate(){
  for (i=[0:90:359]){
    rotate([0,0,i+45]) translate([Nema17_screw_hole_width/2,0,0]) children();
  }
}

module Nema17_screw_holes(r, h){
  Nema17_screw_translate() cylinder(r=r, h=h);
}
//Nema17_screw_holes(M3_diameter/2, 15);

module Nema17_screw_holes_2d(r=1.5){
  Nema17_screw_translate() circle(r=r);
}
//Nema17_screw_holes(M3_diameter, 15);

module Nema17(){
  cw = Nema17_cube_width;
  ch = Nema17_cube_height;
  sh = Nema17_shaft_height;
  union(){
    color("black")
    difference(){
      translate([-(cw-0.1)/2,-(cw-0.1)/2,1]) cube([cw-0.1,cw-0.1,ch-2]);
      for (i=[0:90:359]){ // Corner cuts black cube
        rotate([0,0,i+45]) translate([50.36/2,-cw/2,-1]) cube([cw,cw,ch+2]);
      }
    }
    color("silver")
    difference(){
      translate([-cw/2,-cw/2,0]) cube([cw,cw,ch]);
      for (i=[0:90:359]){ // Corner cuts silver cube
        rotate([0,0,i+45]) translate([53.36/2,-cw/2,-1]) cube([cw,cw,ch+2]);
      }
      translate([0,0,ch-5]) Nema17_screw_holes(M3_diameter/2, h=10);
      translate([0,0,-5]) Nema17_screw_holes(M3_diameter/2, h=10);
      translate([-cw,-cw,9]) cube([2*cw,2*cw,ch-18]);
    }
    color("silver")
    difference(){
      cylinder(r=Nema17_ring_radius, h=ch+Nema17_ring_height);
      translate([0,0,1]) cylinder(r=8.76/2, h=ch+Nema17_ring_height);
    }
    color("silver")
      cylinder(r=5/2, h=sh);
  }
}
//Nema17();

module Bearing_608(){
  color("blue")
  difference(){
    cylinder(r=Bearing_608_outer_diameter/2, h=Bearing_608_width);
    translate([0,0,-1])
      cylinder(r=Bearing_608_bore_diameter/2, h=Bearing_608_width+2);
  }
}
//Bearing_608();
