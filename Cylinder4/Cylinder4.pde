/* 
 LEDcube Arduino version 
 David Mays 1/17/2009
 */

#include <avr/pgmspace.h>

#define COLUMNS 8
#define PLANES 8
#define DELAYBETWEEN 500

int outputpins[] = {
  3,4,5,6,7,8,9,10,
  11,12,13,14,15,16,17,18};

int ledpins[] = {
  3,4,5,6,7,8,9,10};

int planepins[] = {
  11,12,13,14,15,16,17,18};

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
  for (int pin=0; pin < (PLANES + COLUMNS); pin++) 
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

void IntervalClear(int delaybefore)
{
  delay(delaybefore);
  ResetPins();
  ResetPlanes();
}


void loop()
{

  randomSeed(analogRead(0));

  do
  {

    //play sequence from array (blink on 3 times)
    for(int i=0;i<(sizeof(sequence)/sizeof(int));i++)
    {
      sequence[i](200);
    }    

    IntervalClear(DELAYBETWEEN);


    //light all planes by columns, one by one
    for(int column=0;column<COLUMNS;column++)
    {
      for(int plane=0;plane<PLANES;plane++)
      {
        ActivateLED(planepins[plane],ledpins[column]);
      }
      delay(50);
    }

    IntervalClear(DELAYBETWEEN);
    BypassRings();
    BypassRings();
    BypassRings();
    IntervalClear(DELAYBETWEEN);

    for(int plane=0;plane<PLANES;plane++)
    {
      for(int column=0;column<COLUMNS;column++)
      {
        ActivatePin(ledpins[column]);
      }
      ActivatePlane(planepins[plane]);
      delay(200);
      DeactivatePlane(planepins[plane]);            
    }

    IntervalClear(DELAYBETWEEN);

    //spiral up
    for(int plane=0;plane<PLANES;plane++)
    { 
      ActivatePlane(planepins[plane]);
      for(int column=0;column<COLUMNS;column++)
      {
        ActivatePin(ledpins[column]);
        delay(75);
      }  
      //delay(10);   
      DeactivatePlane(planepins[plane]); 
      ResetPins();
    }

    ResetPins();
    ResetPlanes();

    //spiral down
    for(int plane=PLANES-2;plane>=0;plane--)
    { 
      ActivatePlane(planepins[plane]);
      for(int column=0;column<COLUMNS;column++)
      {
        ActivatePin(ledpins[column]);
        delay(75);
      }  
      //delay(10);   
      DeactivatePlane(planepins[plane]); 
      ResetPins();
    }

    IntervalClear(DELAYBETWEEN);


    RainDrops(100,800);
    IntervalClear(DELAYBETWEEN);
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

void BypassRings()
{
  int i,j;
  for(i=0,j=PLANES-1;i<PLANES,j>=0;i++,j--)
  {
    for(int column=0;column<COLUMNS;column++)
    {
      ActivatePin(ledpins[column]);
    }
    ActivatePlane(planepins[i]);
    ActivatePlane(planepins[j]);
    delay(200);
    DeactivatePlane(planepins[i]); 
    DeactivatePlane(planepins[j]); 

  }  
}


void RainDrops(int count, int fallMsec)
{
 
  int delayTime = fallMsec/PLANES;
  
  for(int i=0;i<count;i++)
  {
    int howmanydrops = random(0,COLUMNS);
    int drop[howmanydrops];
    for(int d=0;d<howmanydrops;d++)
    {
      drop[d] = random(0, COLUMNS);
    }

    for(int plane=PLANES-1;plane>=0;plane--)
    {
      for(int x=0;x<howmanydrops;x++)
      {
        ActivatePin(ledpins[drop[x]]); 
      }

      ActivatePlane(planepins[plane]);
      delay(delayTime);
      DeactivatePlane(planepins[plane]); 
    }

    ResetPins();
  }

}





