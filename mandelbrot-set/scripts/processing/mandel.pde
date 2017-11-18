//Globals
float minX = -2, minY = -2, maxX = 2, maxY = 2;
float sizeX, sizeY, gap;
int picWidth, picHeight;

int maxIterations = 200;

//mouse variables
float startX, startY, currentX, currentY;
boolean mouseBeingDragged = false;
boolean setRendered = false;

void setup(){
    size(400, 400);
    frameRate(15);
    background(#FFFFFF);
    colorMode(HSB, 255);
}

float[] getComplexNumber(x, y){
    float[] complexNumber = new float[2];
    complexNumber[0] = x*gap + minX;
    complexNumber[1] = y*gap + minY;
    return complexNumber;
}

float[] getPoint(r, i){
    float[] coords = new float[2];
    coords[0] = int((r - minX) / gap);
    coords[1] = picHeight - int((i - minY) / gap);
    return coords;
}

float[] calculateZ(zValue, cValue){
    float[] newZ = {0, 0};
    newZ[0] = sq(zValue[0]) - sq(zValue[1]) + cValue[0];
    newZ[1] = 2 * zValue[0] * zValue[1] + cValue[1];
    return newZ;
}

void plotSet(){
    for(int x = 0; x < picWidth; x++){
        for(int y = 0; y < picHeight; y++){

            int iteration = 0;
            float[] cValue = getComplexNumber(x, y);
            if(x == 100 && y == 100){
                println("cValue: (" + cValue[0] + ", " + cValue[1] + ")");
            }
            float[] nextValue = {0, 0};

            for(iteration = 0; iteration < maxIterations; iteration++){
                nextValue = calculateZ(nextValue, cValue);

                //if nextValue is out of bounds, stop iterating and plot the point
                if(nextValue[0] < -2 || nextValue[0] > 2 || nextValue[1] < -2 || nextValue[1] > 2){
                    break;
                }
            }
            if(iteration == maxIterations){
                stroke(0, 0, 0);
            }
            else{
                stroke(int(iteration - 1), 255, 255);
            }
            point(x, y);
        }
    }

}

void plotIterations(cValue){
    float[] nextValue = {0, 0};
    float[] lastValue = {0, 0};
    for (int iteration = 0; iteration < maxIterations; iteration++){
        lastValue = nextValue;
        nextValue = calculateZ(nextValue, cValue);
        float[] lastCoords = getPoint(lastValue[0], lastValue[1]);
        float[] nextCoords = getPoint(nextValue[0], nextValue[1]);
        //point(coords[0], coords[1]);
        line(lastCoords[0], lastCoords[1], nextCoords[0], nextCoords[1]);
    }
}

void mousePressed(){
    loadPixels();
    startX = mouseX;
    startY = mouseY;
}
void mouseDragged(){
    currentX = mouseX;
    currentY = mouseY;
    mouseBeingDragged = true;
}
void mouseReleased(){
    mouseBeingDragged = false;
    setRendered = false;
    float startComplex = getComplexNumber(startX, currentY);
    float endComplex = getComplexNumber(currentX, startY);
    minX = startComplex[0];
    minY = endComplex[1];
    maxX = endComplex[0];
    maxY = startComplex[1];
}

void draw(){
    if(!setRendered){
        sizeX = maxX - minX;
        sizeY = maxY - minY;
        picWidth = 400;
        gap = sizeX / picWidth;
        picHeight = sizeY / gap;
        plotSet();
        setRendered = true;
    }
    if(mouseBeingDragged){
        //background(140);
        updatePixels();
        fill(100, 100, 100, 50);
        line(startX, startY, currentX, startY);
        line(startX, startY, startX, currentY);
        line(currentX, startY, currentX, currentY);
        line(startX, currentY, currentX, currentY);
        rect(startX, startY, (currentX-startX), (currentY-startY));
    }
    else{
        currentX = mouseX;
        currentY = mouseY;
    }
}
