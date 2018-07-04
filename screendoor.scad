
// Design based on
// https://tombuildsstuff.blogspot.com/2013/06/how-to-build-frameless-base-cabinets.html
// Choosing Slides
// For side-mount and center-mount slides, typically measure the distance from the front
// edge of the cabinet to the inside face of the cabinet back and then subtract 1".
// Example: 10 Pack Promark Full Extension Drawer Slide 14" 100lb Load Rating


inch = 25.4;  // 25.4 mm to inch
// Cabinet Wood Type
wood_thickness = .75 * inch;
// drawer wood
drawer_wood_thickness = .5 * inch;

// Parameters for size
cabinet_height = 29 * inch;
cabinet_depth  = 16 * inch;
// For 16 inch depth = 16 - .75 - 1 = 14.25 = 14 +/-
slide_size = cabinet_depth - wood_thickness - (1 * inch);
cabinet_width  = 24.0 * inch;
external_base  = 0    * inch;
door_thickness = wood_thickness;
strecher_thickness = wood_thickness;
strecher_width = 4 * inch;

cabinet_side_height  = cabinet_height - external_base;
cabinet_side_width   = cabinet_depth - door_thickness;

cabinet_bottom_width = cabinet_depth - wood_thickness - door_thickness;
cabinet_bottom_height = cabinet_width - 2 * door_thickness;
cabinet_back_height = cabinet_height;
cabinet_back_width  = cabinet_width - (2 * wood_thickness);
cut_number = 0;

drawer_fudge = .25 * inch;
drawer_height = (cabinet_height - (2 * strecher_thickness) - (2 * wood_thickness) -  (4 * drawer_fudge)) / 3;
drawer_depth  = cabinet_depth - wood_thickness - (1 * inch);
slide_space = .5 * inch;
drawer_side_height = drawer_height;
drawer_side_width  = drawer_depth;
drawer_width = cabinet_width - (2 * wood_thickness) - (2 * slide_space);
drawer_back_height = drawer_height;
drawer_back_width  = drawer_width - (2 * drawer_wood_thickness);
drawer_bottom_height = drawer_width - (2 * drawer_wood_thickness);
drawer_bottom_width  = drawer_depth - (2 * drawer_wood_thickness);


module panel(thetype, thex,they)
{
        cut_number = cut_number + 1;        
        cube([thex,they,wood_thickness]);
        echo(thetype,thex,they,wood_thickness);
}

module drawer_panel(thetype, thex,they)
{
        cut_number = cut_number + 1;        
        cube([thex,they,drawer_wood_thickness]);
        echo(thetype,thex,they,drawer_wood_thickness); 
    
}


module side_panel()
{
     panel("PS",cabinet_side_height,cabinet_side_width);
}

module back()
{
     panel("PB",cabinet_back_height,cabinet_back_width);
    
}

module bottom()
{
    panel("PL",cabinet_bottom_height,cabinet_bottom_width);    
}

module drawer_side_panel()
{
     drawer_panel("DS",drawer_side_height,drawer_side_width);
}

module drawer_back()
{
     drawer_panel("DB",drawer_back_height,drawer_back_width);
    
}

module drawer_bottom()
{
    drawer_panel("DL",drawer_bottom_height,drawer_bottom_width);    
}

module strecher()
{
     panel("PS",4 * inch,cabinet_back_width);
}

module cabinet()
{
    ypos = cabinet_width  / 2;
    translate([0,0-ypos,0]) rotate([0,90,90]) side_panel();translate([0,ypos-wood_thickness,0])   rotate([0,90,90]) side_panel();
    rotate([0,0,0]) translate([0-wood_thickness,0-ypos+wood_thickness,0])   rotate([0,90,0])   back();
     rotate([180,0,90]) translate([ypos-wood_thickness,0-wood_thickness,0]) rotate([0,0,180]) bottom();
    rotate([0,90,0]) translate([cabinet_height-wood_thickness,0-ypos+wood_thickness,0-wood_thickness-0]) rotate([0,90,0]) strecher();
   // rotate([0,90,0]) translate([cabinet_height-wood_thickness,0-ypos+wood_thickness,0-cabinet_depth+strecher_width+wood_thickness]) rotate([0,90,0]) strecher();
    rotate([0,90,0]) translate([cabinet_height-wood_thickness,0-ypos+wood_thickness,0-cabinet_depth+strecher_width+wood_thickness]) rotate([0,90,0]) strecher();
    
}

module drawer()
{
    ypos = drawer_width  / 2;
    translate([0,0-ypos,0]) rotate([0,90,90]) drawer_side_panel();
    translate([0,ypos-wood_thickness,0])   rotate([0,90,90]) drawer_side_panel();
    rotate([0,0,0]) translate([0-drawer_wood_thickness,0-ypos+drawer_wood_thickness,0])   rotate([0,90,0])   drawer_back();
    rotate([0,0,0]) translate([0-drawer_depth,0-ypos+drawer_wood_thickness,0])   rotate([0,90,0])   drawer_back();
     rotate([180,0,90]) translate([ypos-drawer_wood_thickness,0-drawer_wood_thickness,0]) rotate([0,0,180]) drawer_bottom();
    
    
}

translate([0,0,0]) rotate([180,0,90])  cabinet();
drawer_spacing = drawer_height + wood_thickness + drawer_fudge;
drawer_1_height = cabinet_height - drawer_spacing;
drawer_2_height = drawer_1_height - drawer_spacing;
drawer_3_height = drawer_2_height - drawer_spacing;

translate([0,0 - 1 * inch,drawer_1_height]) rotate([180,0,90]) drawer();
translate([0,0 - 8 * inch,drawer_2_height]) rotate([180,0,90]) drawer();
translate([0,0 - 16 * inch,drawer_3_height]) rotate([180,0,90]) drawer();