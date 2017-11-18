//Globals
float minX = -2, minY = -2, maxX = 2, maxY = 2;
float sizeX, sizeY, gap;
int picWidth, picHeight;

int maxIterations = 100;

void setup(){
    sizeX = maxX - minX;
    sizeY = maxY - minY;
    picWidth = 400;
    gap = sizeX / picWidth;
    picHeight = sizeY / gap;

    frameRate(15);
    noLoop();
    background(#FFFFFF);
    colorMode(HSB, 100);
    size(picWidth, picHeight);
    //println("width: " + picWidth + ", height: " + picHeight + ", gap: " + gap);
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
            float[] nextValue = {0, 0};

            for(iteration = 0; iteration < maxIterations; iteration++){
                nextValue = calculateZ(nextValue, cValue);

                //if nextValue is out of bounds, stop iterating and plot the point
                if(nextValue[0] < minX || nextValue[0] > maxX || nextValue[1] < minY || nextValue[1] > maxY){
                    break;
                }
            }
            if(iteration == maxIterations){
                iteration = 0;
            }
            stroke(iteration, 150, 100);
            point(x, y);
        }
    }

}

void plotIterations(cValue){
    float[] nextValue = {0, 0};
    float[] lastValue = {0, 0};
    //println("zValue: (" + nextValue[0] + ", " + nextValue[1] + "), cValue: (" + cValue[0] + ", " + cValue[1] + ")");
    for (int iteration = 0; iteration < maxIterations; iteration++){
        lastValue = nextValue;
        nextValue = calculateZ(nextValue, cValue);
        float[] lastCoords = getPoint(lastValue[0], lastValue[1]);
        float[] nextCoords = getPoint(nextValue[0], nextValue[1]);
        //point(coords[0], coords[1]);
        line(lastCoords[0], lastCoords[1], nextCoords[0], nextCoords[1]);
    }
}

void draw(){
    /*
    stroke(#000000);
    strokeWeight(3);
    float[] testValue = {0.5, 0.5};
    plotIterations(testValue);
    */
    plotSet();
}
