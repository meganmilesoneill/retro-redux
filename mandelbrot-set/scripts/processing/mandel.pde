//Globals
int minRange = -2;
int maxRange = 2;
float[] bottomLeftValues = {minRange, maxRange};
float gap = 0.0;
int picSize = 400;
int maxIterations = 100;

void setup(){
    frameRate(15);
    noLoop();
    background(#FFFFFF);
    colorMode(HSB, 100);
    size(picSize, picSize);

    gap = 4/picSize;
}

float[] getComplexNumber(x, y){
    float[] complexNumber = new float[2];
    complexNumber[0] = x*gap + bottomLeftValues[0];
    complexNumber[1] = bottomLeftValues[1] - y*gap;
    return complexNumber;
}

float[] getPoint(r, i){
    float[] coords = new float[2];
    coords[0] = int((r - bottomLeftValues[0]) / gap);
    coords[1] = int((bottomLeftValues[1] - i) / gap);
    return coords;
}

float[] calculateZ(zValue, cValue){
    float[] newZ = {0, 0};
    newZ[0] = sq(zValue[0]) - sq(zValue[1]) + cValue[0];
    newZ[1] = 2 * zValue[0] * zValue[1] + cValue[1];
    return newZ;
}

void plotSet(){
    for(int x = 0; x < picSize; x++){
        for(int y = 0; y < picSize; y++){

            int iteration = 0;
            float[] cValue = getComplexNumber(x, y);
            float[] nextValue = {0, 0};

            for(iteration = 0; iteration < maxIterations; iteration++){
                nextValue = calculateZ(nextValue, cValue);

                //if nextValue is out of bounds, stop iterating and plot the point
                if(nextValue[0] < minRange || nextValue[0] > maxRange || nextValue[1] < minRange || nextValue[1] > maxRange){
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
    println("zValue: (" + nextValue[0] + ", " + nextValue[1] + "), cValue: (" + cValue[0] + ", " + cValue[1] + ")");
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
