include <Measured_numbers.scad>

// Threadless M3 screw with hex head
// h: height (length) of the screw
// head_height: for custom head heights. Doesn't affect overall height
// updown: put head at other end
// center: translate cylinder so that mass centrum is in origo
module M3_screw(h, head_height=M3_head_height,
                updown=false, center=false){
  color("grey"){
  if(center){
    translate([0,0,-h/2])
      cylinder(r=M3_diameter/2, h=h);
      if(updown){
        translate([0,0,h/2-head_height])
          cylinder(r=M3_head_diameter/2, h=head_height, $fn=6);
      }else{
        translate([0,0,-h/2])
        cylinder(r=M3_head_diameter/2, h=head_height, $fn=6);
      }
  }else{
      cylinder(r=M3_diameter/2, h=h);
      if(updown){
        translate([0,0,h-head_height])
          cylinder(r=M3_head_diameter/2, h=head_height, $fn=6);
      }else{
        cylinder(r=M3_head_diameter/2, h=head_height, $fn=6);
      }
    }
  }// end of color
}
//M3_screw(10, center=true, updown=true);

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

module Bearing(outer_r, inner_r, h, center=false){
  color("blue")
  difference(){
    cylinder(r=outer_r, h=h, center=center);
    translate([0,0,-3])
      cylinder(r=inner_r, h=h+6, center=center);
  }
}

module Bearing_608(center=false){
  Bearing(Bearing_608_outer_radius, Bearing_608_bore_radius, Bearing_608_width, center=center);
}
//Bearing_608();

module Bearing_623(center=false){
  Bearing(Bearing_623_outer_radius, Bearing_623_bore_radius, Bearing_623_width, center=center);
}
//Bearing_623();

// Used for rendering a shadow of printers outer dimensions
module Meas_cube(){
  translate([-Cube_X_length/2,0,0])
  %cube([Cube_X_length, Cube_Y_length, Cube_Z_length]);
}
//Meas_cube();

// Works with both vector[2] and scalar type of s
module Rounded_square(s, r){
  if(len(s) == undef){
    // The circles
    for(k = [[r,r],[s-r,r],[s-r,s-r],[r,s-r]])
      translate(k)
      circle(r);
    // The squares
    translate([r,0])
      square([s-2*r, s]);
    translate([0,r])
      square([s, s-2*r]);
  }else if(len(s) ==2){
    // The circles
    for(k = [[r,r],[s[0]-r,r],[s[0]-r,s[1]-r],[r,s[1]-r]])
      translate(k)
      circle(r);
    // The squares
    translate([r,0])
      square([s[0]-2*r, s[1]]);
    translate([0,r])
      square([s[0], s[1]-2*r]);
  }
}
