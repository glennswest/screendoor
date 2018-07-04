
// Design based on
// https://www.youtube.com/watch?v=DhXJiUuMlwY
// Using: Severe Weather 2-in X 4-in x 8-ft Prime Treated Lumber (Common) 1.5-in x 3.5-in x 8-ft (Actual)
//


inch = 25.4;  // 25.4 mm to inch
// door Wood Type
wood_thickness = 1.5 * inch;
wood_width     = 3.5 * inch;


// Parameters for size
door_height = 80 * inch;
door_width  = 35.5 * inch;
actual_height = door_height - (.5 * inch);
actual_width  = door_width - (.25 * inch);
crosspiece_length = actual_width - (2 * wood_width);

dog_door_height = 15.75 * inch;
dog_door_width =  10.875 * inch;

cut_number = 0;

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

module door()
{
    xpos = actual_width  / 2;
    translate([0-xpos+wood_width,0]) rotate([0,90,90]) twobyfour("S1",actual_height);
    translate([xpos,0,0])   rotate([0,90,90]) twobyfour("S1",actual_height);
    translate([0-xpos+wood_width,0,0]) rotate([0,90,0]) twobyfour("B1",crosspiece_length);
    
    
    translate([0,1 * wood_width,0]) dog_cross();
    translate([0,2 * wood_width,0]) dog_cross();
    translate([0,3 * wood_width,0]) dog_cross();
    translate([0,4 * wood_width,0]) dog_cross();
    translate([0,5 * wood_width,0]) dog_cross();
     translate([0+(dog_door_width/2),wood_width*5+1.75*inch,0-wood_thickness]) rotate([0,-90,0]) twobyfourX1p75("X1",dog_door_width);
    %translate([0+(dog_door_width/2),wood_width,0]) rotate([0,90,90]) dog_door();
    translate([0-xpos+wood_width,6 * wood_width,0]) rotate([0,90,0]) twobyfour("B1",crosspiece_length); 
    translate([0-xpos+wood_width,actual_height - wood_width,0]) rotate([0,90,0]) twobyfour("B1",crosspiece_length);
    
}

door();