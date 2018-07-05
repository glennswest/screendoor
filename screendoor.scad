
// Design based on
// https://www.youtube.com/watch?v=DhXJiUuMlwY
// Using Door: Severe Weather 2-in X 4-in x 8-ft Prime Treated Lumber (Common) 1.5-in x 3.5-in x 8-ft (Actual)
// Using Screen: Severe Weather (Common: 1-in X 6-in x 6-ft; Actual: 0.75-in x 5.5-in x 6-ft) Ecolife Treated Lumber


inch = 25.4;  // 25.4 mm to inch
// door Wood Type
wood_thickness = 1.5 * inch;
wood_width     = 3.5 * inch;

screen_wood_thickness = .25 * inch;
screen_wood_width     = 1.5 * inch;

// Parameters for size
door_height = 80 * inch;
door_width  = 35.5 * inch;
actual_height = door_height - (.5 * inch);
actual_width  = door_width - (.25 * inch);
crosspiece_length = actual_width - (2 * wood_width);

dog_door_height = 15.75 * inch;
dog_door_width =  10.875 * inch;
door_half_height = (actual_height - 9 * wood_width + .5 * inch);
cut_number = 0;

screen_width = actual_width - (2 * wood_width) ;
screen_height = actual_height - door_half_height - (1 * wood_width) - screen_wood_thickness;

module dog_door()
{
    cube([wood_thickness,dog_door_width,dog_door_height]);
    
}

module twobyfour(thetype, thelength)
{
    cut_number = cut_number + 1;
    cube([wood_thickness,wood_width,thelength]);
    echo(thetype,thelength);
}

module ptwofivebyonepfive(thetype, thelength)
{
    cut_number = cut_number + 1;
    cube([screen_wood_thickness,screen_wood_width,thelength]);
    echo(thetype,thelength);
}

module miter_ptwofivebyonepfive(thetype,thelength,mdir)
{
   
    difference(){
       ptwofivebyonepfive(thetype,thelength);
       if (mdir == -1){
           translate([0,0,-19.05]) rotate([-45*mdir,0,0]) translate([-.2,0,-100]) cube([screen_wood_thickness+.5,screen_wood_width+.5,thelength+.5]);
           translate([0,0,thelength+19.05]) rotate([45*mdir,0,0]) translate([-.2,0,-100]) cube([screen_wood_thickness+.5,screen_wood_width+.5,thelength+.5]);
          } else {
          translate([0,0,0]) rotate([-45*mdir,0,0]) translate([-.2,0,-100]) cube([screen_wood_thickness+.5,screen_wood_width+.5,thelength+.5]);
          translate([0,0,thelength]) rotate([45*mdir,0,0]) translate([-.2,0,-100]) cube([screen_wood_thickness+.5,screen_wood_width+.5,thelength+.5]);    
          }
       }
}

module twobyfourX1p75(thetype, thelength)
{
    cut_number = cut_number + 1;
    cube([wood_thickness,1.75*inch,thelength]);
    echo(thetype,thelength);
}


module dog_cross()
{
    xpos = actual_width  / 2;
    dogdoor_cross = (crosspiece_length - dog_door_width) / 2;
    dogdoor2_xpos = 0 - xpos + dogdoor_cross + dog_door_width;
    translate([0-xpos+wood_width,0,0]) rotate([0,90,0]) twobyfour("B2",dogdoor_cross);
    translate([0-xpos+wood_width+dogdoor_cross+dog_door_width,0,0]) rotate([0,90,0]) twobyfour("B2",dogdoor_cross);
}

module screen_frame()
{
    xpos = screen_width / 2;
    translate([0-xpos,0,0]) rotate([0,90,90]) miter_ptwofivebyonepfive("F1",screen_height,-1);
    translate([xpos+screen_wood_width,0,0]) rotate([0,90,90]) miter_ptwofivebyonepfive("F1",screen_height,1);
    
    translate([0-xpos-screen_wood_width,0,0]) rotate([0,90,0]) miter_ptwofivebyonepfive("F2",screen_width+(2*screen_wood_width),+1);
    translate([0-xpos-screen_wood_width,0+screen_height-screen_wood_width,0]) rotate([0,90,0]) miter_ptwofivebyonepfive("F2",screen_width+(2 * screen_wood_width),-1);
}

module door()
{
    xpos = actual_width  / 2;
    translate([0-xpos+wood_width,0]) rotate([0,90,90]) twobyfour("S1",actual_height);
    translate([xpos,0,0])   rotate([0,90,90]) twobyfour("S1",actual_height);
    translate([0-xpos+wood_width,0,0]) rotate([0,90,0]) twobyfour("B1",crosspiece_length);
    translate([0-xpos+wood_width,actual_height - wood_width,0]) rotate([0,90,0]) twobyfour("B1",crosspiece_length);
    
    
    translate([0,1 * wood_width,0]) dog_cross();
    translate([0,2 * wood_width,0]) dog_cross();
    translate([0,3 * wood_width,0]) dog_cross();
    translate([0,4 * wood_width,0]) dog_cross();
    translate([0,5 * wood_width,0]) dog_cross();
     translate([0+(dog_door_width/2),wood_width*5+1.75*inch,0-wood_thickness]) rotate([0,-90,0]) twobyfourX1p75("X1",dog_door_width);
    %translate([0+(dog_door_width/2),wood_width,0]) rotate([0,90,90]) dog_door();
    translate([0-xpos+wood_width,6 * wood_width,0]) rotate([0,90,0]) twobyfour("B1",crosspiece_length); 
    translate([0-xpos+wood_width,door_half_height,0]) rotate([0,90,0]) twobyfour("B1",crosspiece_length);
    
    
    //%translate([0-xpos+wood_width-screen_wood_width/2,door_half_height-screen_wood_width+wood_width ,0-wood_thickness+20]) cube([screen_width,screen_height,wood_thickness]);
    
    //%translate([0-xpos+wood_width-screen_wood_width/2,door_half_height-screen_wood_width+wood_width - (8 * wood_width) ,0-wood_thickness+20]) cube([screen_width,screen_height,wood_thickness]);
    
    translate([0,door_half_height-screen_wood_width+wood_width,screen_wood_thickness]) screen_frame();
    translate([0,6.5 * wood_width,screen_wood_thickness]) screen_frame();
    
}

door();
