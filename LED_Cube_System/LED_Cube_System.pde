/* 
LEDcube Arduino version 
David Mays 1/17/2009
*/

#include <avr/pgmspace.h>
#include "PinPatterns.h"

int ResetPlanes()
{
    Serial.print("Resetting Planes");
      for (int plane=0; plane<CUBESIZE; plane++) 
      {
        // turn previous plane off
        if (plane==0) {
          digitalWrite( PlanePin[CUBESIZE-1], HIGH );
        } else {
          digitalWrite( PlanePin[plane-1], HIGH );
        }
      }
}


int WriteEventToPins(CubeEventDef event)
{
  Serial.println("Writing Event");
  
  for (int plane=0; plane<CUBESIZE; plane++) 
  {
        Serial.print("Plane:");
        Serial.println(plane);
        
        // load current plane pattern data into ports
        for (int X=0; X<CUBESIZE; X++) 
        {
          for (int Y=0; Y<CUBESIZE; Y++) 
          {              
            int pin = (X+1 * Y+1)-1;

            Serial.print("Pin:");
            Serial.println(pin);

            byte state = event.Plane[plane].Grid[X][Y];

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
  
  Serial.begin(9600);
  int pin;      // loop counter
  // set up LED pins as output (active HIGH)
  for (pin=0; pin<PLANESIZE; pin++) 
  {
    pinMode( PlanePin[pin], OUTPUT );
  }
  // set up plane pins as outputs (active LOW) 
  for (pin=0; pin<CUBESIZE; pin++) 
  {
    pinMode( LEDPin[pin], OUTPUT );
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




// display pattern in table until DisplayTime is zero (then repeat)
/*
void loop()
{
  // declare variables
  byte PatternBuf[ PLANESIZE ];      // saves current pattern from PatternTable
  int PatternIdx;
  byte DisplayTime;        // time*100ms to display pattern
  unsigned long EndTime;
  int plane;      // loop counter for cube refresh
  int patbufidx;   // indexes which byte from pattern buffer
  int ledrow;    // counts LEDs in refresh loop
  int ledcol;    // counts LEDs in refresh loop
  int ledpin;    // counts LEDs in refresh loop

  // Initialize PatternIdx to beginning of pattern table
  PatternIdx = 0;
  // loop over entries in pattern table - while DisplayTime>0
  do {
    // read pattern from PROGMEM and save in array
    memcpy_P( PatternBuf, Patterns+PatternIdx, PLANESIZE );
    PatternIdx += PLANESIZE;
    // read DisplayTime from PROGMEM and increment index
    //DisplayTime = pgm_read_byte_near( PatternTable + PatternIdx++ );    
    // compute EndTime from current time (ms) and DisplayTime
    EndTime = millis() + ((unsigned long) DisplayTime) * TIMECONST;

    // loop while DisplayTime>0 and current time < EndTime
    while ( millis() < EndTime ) {
      patbufidx = 0;    // reset index counter to beginning of buffer
      // loop over planes
      for (plane=0; plane<CUBESIZE; plane++) {
        // turn previous plane off
        if (plane==0) {
          digitalWrite( PlanePin[CUBESIZE-1], HIGH );
        } else {
          digitalWrite( PlanePin[plane-1], HIGH );
        }

        // load current plane pattern data into ports
        ledpin = 0;
        for (ledrow=0; ledrow<CUBESIZE; ledrow++) {
          for (ledcol=0; ledcol<CUBESIZE; ledcol++) {
            digitalWrite( LEDPin[ledpin++], PatternBuf[patbufidx] & (1 << ledcol) );
          }
          patbufidx++;
        } 

        // turn current plane on
        digitalWrite( PlanePin[plane], LOW );
        // delay PLANETIME us
        delayMicroseconds( PLANETIME );
      }    // for plane
    }    // while <EndTime
  } while (DisplayTime > 0);        // read patterns until time=0 which signals end
}
*/
