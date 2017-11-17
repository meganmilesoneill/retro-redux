//Globals
int maxSize = 200;
int cellTypeCount = 10;
int[] rows = new int[maxSize];
int[] calcRows = new int[maxSize];
int[] colors = {#FF0000, #CC0000, #FFFF00, #CCCC00, #FF9816, #00DE00, #00DEFF, #0000FF, #CC00CC, #FF00FF};

void setup(){
    size(maxSize, maxSize);
    //create and seed rows and calcRows
    int seedColor;
    for (int r = 0; r < maxSize; r++){
        rows[r] = new int[maxSize];
        calcRows[r] = new int[maxSize];
        for (int c = 0; c < maxSize; c++){
            seedColor = int(random(cellTypeCount));
            rows[r][c] = seedColor;
            calcRows[r][c] = seedColor;
        }
    }
    renderCells();
    frameRate(10);
}

void copyCellValues(source, destination){
    for (int r = 0; r < maxSize; r++){
        for (int c = 0; c < maxSize; c++){
            destination[r][c] = source[r][c];
        }
    }
}
void renderCells(){
    for (int r = 0; r < maxSize; r++){
        for (int c = 0; c < maxSize; c++){
            stroke(colors[rows[r][c]]);
            point(c, r);
        }
    }
}

//at each iteration, determine new neighbor values
//draw new neighbors
//replace old neighborhood with new neighborhood
void draw(){
    //calculate new neighbors
    int currentValue;
    int consumeValue;
    for (int r = 0; r < maxSize; r++){
        for (int c = 0; c < maxSize; c++){
            currentValue = rows[r][c];
            consumeValue = (currentValue == 0) ? cellTypeCount - 1: currentValue - 1;
            //check north neighbor
            int north = (r == 0) ? maxSize - 1 : (r - 1);
            if(rows[north][c] == consumeValue) {
                calcRows[north][c] = currentValue;
            }
            //check west neighbor
            int west = (c == 0) ? maxSize - 1 : (c - 1);
            if(rows[r][west] == consumeValue){
                calcRows[r][west] = currentValue;
            }
            //check south neighbor
            int south = (r == maxSize - 1) ? 0 : (r + 1);
            if(rows[south][c] == consumeValue){
                calcRows[south][c] = currentValue;
            }
            //check east neighbor
            int east = (c == maxSize - 1) ? 0 : (c + 1);
            if(rows[r][east] == consumeValue){
                calcRows[r][east] = currentValue;
            }
        }
    }

    copyCellValues(calcRows, rows);
    renderCells();
}
