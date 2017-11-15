//Globals
float maxRadius = 500.0;
float radiusInterval = 1.0;
int maxHue = 130;
int minSaturation = 30;
int maxSaturation = 80;
int maxBrightness = 80;
IntList hueList;

int hueOffset = 0;
int startingHueOffset = 0;
int satOffset = maxSaturation;
int startingSatOffset = 0;
bool satDecreasing = true;
bool startingSatDecreasing = true;

void setup(){
    size(maxRadius, maxRadius);
    colorMode(HSB, maxHue);
    frameRate(90);
    strokeWeight(radiusInterval);

    //initialize hue list to contain list of hue values
    //  with slight randomness introduced into the intervals
    //  to create more dramatic visual effect
    //  instead of cycling through hueList using an static interval
    hueList = new int[maxHue];
    int lastHue = 0;
    for(int i = 0; i < maxHue; i++){
        hueList[i] = (lastHue + (random(10) + 10)) % maxHue;
        lastHue = hueList[i];
    }
    noFill();
}
// In order to achieve the sense of circles flowing inward with each pass
//  offsets are used to keep track of how to paint the hues and saturation.
//
//  The variables "startingSatOffset" and "startingHueOffset" keep track of
//  where to reset the offsets at the beginning of each pass,
//  while "satOffset" and "hueOffset" track the offsets within the current pass.
//
//  For each hue, saturation decreases and then increases to create the effect
//  of each hue having a tube-like shape
void draw(){
    satOffset = startingSatOffset;
    hueOffset = startingHueOffset;
    satDecreasing = startingSatDecreasing;

    for(radius = 1; radius <= maxRadius; radius++){
        if(satDecreasing){
            if(satOffset <= minSaturation){
                satDecreasing = false;
            }  else {
                satOffset-=1;
            }
        } else {
            if(satOffset >= maxSaturation){
                satDecreasing = true;
                if(hueOffset == maxHue - 1) hueOffset = 0; else hueOffset++;
            } else {
                satOffset+=1;
            }
        }
        stroke(hueList[hueOffset], satOffset, 90);
        ellipse( maxRadius/2, maxRadius/2, radius, radius );
    }
    if(startingSatDecreasing){
        if(startingSatOffset <= minSaturation){
            startingSatDecreasing = false;
        } else {
            startingSatOffset-=1;
        }
    } else {
        if(startingSatOffset >= maxSaturation){
            startingSatDecreasing = true;
            if(startingHueOffset == maxHue - 1) startingHueOffset = 0; else startingHueOffset++;
        } else {
            startingSatOffset+=1;
        }
    }
}
