/* 
 LEDcube Arduino version 
 David Mays 1/17/2009
 */

#include <avr/pgmspace.h>
#include "PinPatterns.h"

#define COLUMNS 8
#define PLANES 3

int outputpins[] = {
  1,2,3,4,5,6,7,8,9,10,11};

int ledpins[] = {
  1,2,3,4,5,6,7,8};
int planepins[] = {
  9,10,11};

typedef void (* SequenceFunc) (int delayafter);


SequenceFunc sequence[5] = 
{
AllOn,AllOff,AllOn,AllOff,AllOn
};

int ResetPlanes()
{
  for (int pIdx=0; pIdx<PLANES; pIdx++) 
  {
    DeactivatePlane(planepins[pIdx]);
  }
}

void ResetPins()
{
  for(int pin=0;pin<COLUMNS;pin++)
  {
    DeactivatePin(ledpins[pin]);
  }
}


// initialization
void setup()
{

  int pin;      // loop counter
  // set up LED pins as output (active HIGH)
  for (pin=0; pin < (PLANES + COLUMNS); pin++) 
  {
    pinMode( outputpins[pin], OUTPUT );
  }

  ResetPins();
  ResetPlanes();

}


void AllOn(int delayafter)
{
    for(int plane=0;plane<PLANES;plane++)
    {
      for(int column=0;column<COLUMNS;column++)
      {
        ActivateLED(planepins[plane],ledpins[column]);
      }      
    }
    delay(delayafter);
}

void AllOff(int delayafter)
{
    ResetPins();
    ResetPlanes();
    delay(delayafter);
}

void DelayMS(int msec)
{
  delay(msec);
}

void loop()
{

  do
  {

    for(int i=0;i<5;i++)
    {
      sequence[i](200);
    }    
    
    AllOff(0);
    delay(500);
    
    for(int plane=0;plane<PLANES;plane++)
    {
      for(int column=0;column<COLUMNS;column++)
      {
        ActivateLED(planepins[plane],ledpins[column]);
      }      
    }

    delay(500);
    ResetPins();
    delay(500);
    ResetPlanes();

    for(int column=0;column<COLUMNS;column++)
    {
      for(int plane=0;plane<PLANES;plane++)
      {
        delay(50);
        ActivateLED(planepins[plane],ledpins[column]);
      }

    }

    delay(500);
    ResetPins();
    delay(500);

    ResetPlanes();

    for(int plane=0;plane<PLANES;plane++)
    {
      
      for(int column=0;column<COLUMNS;column++)
      {
        ActivateLED(planepins[plane],ledpins[column]);
      }
      delay(200);
      DeactivatePlane(planepins[plane]);            
    }

    delay(500);
    ResetPins();
    delay(500);
    ResetPlanes();
    
    for(int plane=0;plane<PLANES;plane++)
    { 
      ActivatePlane(planepins[plane]);
      for(int column=0;column<COLUMNS;column++)
      {
        ActivatePin(ledpins[column]);
        delay(200);
      }  
      delay(200);   
      DeactivatePlane(planepins[plane]); 
      ResetPins();
    }

    delay(500);
    ResetPins();
    delay(500);
    ResetPlanes();


  }
  while(1);
}

void ActivateLED(int plane, int column)
{
  ActivatePlane(plane);
  ActivatePin(column);
}

void DeactivateLED(int plane, int column)
{
  DeactivatePin(column);
}

void ActivatePlane(int pin)
{
  digitalWrite(pin,LOW);
}

void DeactivatePlane(int pin)
{
  digitalWrite(pin,HIGH);
}


void ActivatePin(int pin)
{
  digitalWrite(pin,HIGH);
}

void DeactivatePin(int pin)
{
  digitalWrite(pin,LOW);
}
