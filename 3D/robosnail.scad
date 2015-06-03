$fn=128;
include <legoplate.scad>

color([1,0,0,1]) GridTranslate([-1, -1, 0]) Brick([2,4,3]);

rotate([0,90,0]) {
eye();
}

module snail() {
    translate([0, -gridSpacing.y/2, 3*gridSpacing.z]) {
        translate([-gridSpacing.x/2, 0, 0]) rotate([0,0,-15])
            eye();
        translate([gridSpacing.x/2, 0, 0]) rotate([0,0,15])
            eye();
    }
}

module eye() {
    bendRadius = 20;
    bendAngle = 60;
    
    difference() {
        color([1,1,1,1]) union() {
            bendPipe(1.5, bendRadius, 0, bendAngle);
            sphere(3.8);
        };
    
        GridTranslate([-1/2,-1/2,-3]) Brick([1,1,3]);
    };
    
    eyeRadius = 3.5;
    translate([0, -bendRadius, 0])
    rotate([bendAngle + eyeRadius,0,0])
    translate([0, bendRadius, 0])
        color([1,1,1,1]) sphere(eyeRadius);
    
    pupilRadius = 2;
    translate([0, -bendRadius, 0])
    rotate([bendAngle + 2*eyeRadius + pupilRadius,0,0])
    translate([0, bendRadius, 0])
        color([0,0,0,1]) sphere(pupilRadius);
    
}


module bendPipe(radius, bendRadius, angle1, angle2) {
    // bend
    rotate([90,0,90]) translate([-bendRadius-radius,0,0]) difference() {
        // torus
        rotate_extrude()
            translate([bendRadius + radius, 0, 0])
            circle(r=radius);
        // lower cutout
        rotate([0, 0, angle1])
            translate([-50 * (((angle2 - angle1) <= 180)?1:0), -100, -50])
            cube([100, 100, 100]);
        // upper cutout
        rotate([0, 0, angle2])
            translate([-50 * (((angle2 - angle1) <= 180)?1:0), 0, -50])
            cube([100, 100, 100]);
    }
}