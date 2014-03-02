/*
Cube System definition file
David Mays
3/17/2009

Structs used to define the shape of the cube
Arrays to define the pins on the Arduino board

*/

#define CUBESIZE 4
#define PLANESIZE CUBESIZE*CUBESIZE
#define PLANETIME 3333          // time each plane is displayed in us -> 100 Hz refresh
#define TIMECONST 100          // multiplies DisplayTime to get ms - why not =100?


//Defines a structure for a layer of LEDs in a cube Really, just a simple 2D array
typedef struct {
  prog_uint8_t PROGMEM Grid[CUBESIZE][CUBESIZE];
} PlaneDef;

//Defines a structure for an event on the Cube
//Duration is in milliseconds
//Array of Planes that represent the stacked layers of the cube
typedef struct{
  prog_int8_t PROGMEM Duration;
  PlaneDef PROGMEM Plane[CUBESIZE];
} CubeEventDef;


int LEDPin[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
int PlanePin[] = {16,17,18,19};


