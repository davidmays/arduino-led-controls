/*
Cube System definition file
David Mays
3/17/2009

Structs used to define the dimensions of the cylinder
Arrays to define the pins on the Arduino board

*/

#define HEIGHT 3
#define PLANESIZE 8
#define PLANETIME 3333          // time each plane is displayed in us -> 100 Hz refresh
#define TIMECONST 100          // multiplies DisplayTime to get ms - why not =100?


//Defines a structure for a layer of LEDs in a cylinder
typedef struct {
  prog_uint8_t PROGMEM Ring[PLANESIZE];
} PlaneDef;

//Defines a structure for an event on the Cube
//Duration is in milliseconds
//Array of Planes that represent the stacked layers of the cube
typedef struct{
  prog_int8_t PROGMEM Duration;
  PlaneDef PROGMEM Plane[HEIGHT];
} CylinderEventDef;


int LEDPin[] = {0,1,2,3,4,5,6,7};
int PlanePin[] = {8,9,10};



