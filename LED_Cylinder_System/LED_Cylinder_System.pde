/* 
 LEDcube Arduino version 
 David Mays 1/17/2009
 */

#include <avr/pgmspace.h>
#include "PinPatterns.h"

int ResetPlanes()
{
  Serial.println("Resetting Planes");
  for (int pIdx=0; pIdx<HEIGHT; pIdx++) 
  {
    // turn previous plane off
    if (pIdx==0) {
      digitalWrite( PlanePin[HEIGHT-1], HIGH );
    } 
    else {
      digitalWrite( PlanePin[pIdx-1], HIGH );
    }
  }
}


int WriteEventToPins(CylinderEventDef event)
{
  Serial.println("Writing Event");

  for (int planeIdx=0; planeIdx<HEIGHT; planeIdx++) 
  {
    Serial.print("Plane:");
    Serial.println(planeIdx);

    // load current plane pattern data into ports
    for (int X=0; X<PLANESIZE; X++) 
    {

      Serial.print("Pin:");
      Serial.print(X);

      prog_uint8_t state = event.Plane[planeIdx].Ring[X];

      Serial.print(" State:");
      Serial.print(state);

      digitalWrite(X , state);
    }


    // turn current plane on
    Serial.print("Activating Plane");

    digitalWrite( PlanePin[planeIdx], LOW );
    delayMicroseconds( PLANETIME );
  }

  return 0;
}


// initialization
void setup()
{
  Serial.begin(38400);
  Serial.println("setup");

  int pin;      // loop counter
  // set up LED pins as output (active HIGH)
  for (pin=0; pin<PLANESIZE; pin++) 
  {
    Serial.print("led:");
    Serial.println(LEDPin[pin]);

    pinMode( LEDPin[pin], OUTPUT );
  }
  // set up plane pins as outputs (active LOW) 
  for (pin=0; pin<HEIGHT; pin++) 
  {
    Serial.print("plane:");
    Serial.println(PlanePin[pin]);
    pinMode( PlanePin[pin], OUTPUT );
  }
}


void loop()
{
  Serial.println("loop");

  while(millis() < 100000000)
  {
    for(int eventIdx=0;eventIdx < sizeof(Events);eventIdx++)
    {
      ResetPlanes();
      WriteEventToPins(Events[eventIdx]);
    }
  }


}
