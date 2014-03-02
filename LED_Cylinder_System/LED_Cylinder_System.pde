/* 
LEDcube Arduino version 
David Mays 1/17/2009
*/

#include <avr/pgmspace.h>
#include "PinPatterns.h"

int ResetPlanes()
{
      Serial.print("Resetting Planes");
      for (int plane=0; plane<HEIGHT; plane++) 
      {
        // turn previous plane off
        if (plane==0) {
          digitalWrite( PlanePin[HEIGHT-1], HIGH );
        } else {
          digitalWrite( PlanePin[plane-1], HIGH );
        }
      }
}


int WriteEventToPins(CylinderEventDef event)
{
  Serial.println("Writing Event");
  
  for (int plane=0; plane<HEIGHT; plane++) 
  {
        Serial.print("Plane:");
        Serial.println(plane);
        
        // load current plane pattern data into ports
        for (int X=0; X<PLANESIZE; X++) 
        {
            int pin = X+1;

            Serial.print("Pin:");
            Serial.println(pin);

            byte state = event.Plane[plane].Ring[X];

            Serial.print("State:");
            Serial.println(state);
            
            digitalWrite(pin , state);
          }
        } 

        // turn current plane on
        Serial.print("Activating Plane:");
        Serial.println(plane);

        digitalWrite( PlanePin[plane], LOW );
        delayMicroseconds( PLANETIME );
  }

  return 0;
}


// initialization
void setup()
{
  int pin;      // loop counter
  // set up LED pins as output (active HIGH)
  for (pin=0; pin<HEIGHT; pin++) 
  {
    pinMode( LEDPin[pin], OUTPUT );
  }
  // set up plane pins as outputs (active LOW) 
  for (pin=0; pin<PLANESIZE; pin++) 
  {
    pinMode( PlanePin[pin], OUTPUT );
  }
}


void loop()
{

  byte DisplayTime;        // time*100ms to display pattern
  unsigned long EndTime;


  do
  {
    EndTime = millis() + ((unsigned long) DisplayTime) * TIMECONST;
      
    while(millis() < EndTime)
    {
      for(int eventIdx=0;eventIdx<sizeof(Events);eventIdx++)
      {
        ResetPlanes();
        WriteEventToPins(Events[eventIdx]);
      }
    }
      

  }
  while(DisplayTime > 0);
}
