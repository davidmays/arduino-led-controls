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



int ResetPlanes()
{
  for (int pIdx=0; pIdx<PLANES; pIdx++) 
  {
    digitalWrite( planepins[pIdx], HIGH);
  }
}

void ResetPins()
{
  for(int pin=0;pin<COLUMNS;pin++)
  {
    digitalWrite(ledpins[pin],LOW);
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


void loop()
{

  do
  {

    for(int plane=0;plane<PLANES;plane++)
    {
      ActivatePlane(planepins[plane]);

      for(int column=0;column<COLUMNS;column++)
      {
        ActivatePin(ledpins[column]);
        delay(20);
        DeactivatePin(ledpins[column]);
        delay(20);
      }
      DeactivatePlane(planepins[plane]);      
    }


  }
  while(1);
}


void ResetPreviousPlane(int pin)
{
  if(pin==9)
  {
    digitalWrite(11,HIGH);
  }
  else
  {
    digitalWrite(pin-1,HIGH);
  }

}


void ResetPreviousPin(int pin)
{
  if(pin==0)
  {
    digitalWrite(9,LOW);
  }
  else
  {
    digitalWrite(pin-1,LOW);
  }
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
