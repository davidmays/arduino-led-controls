#include "CubeSystem.h"

#define HIGH 0x1
#define LOW 0x0

CubeEventDef event1 = {
  500,
  {
    {
    HIGH,LOW,HIGH,LOW,
    LOW,HIGH,LOW,HIGH,
    HIGH,LOW,HIGH,LOW,
    LOW,HIGH,LOW,HIGH
    },
    {
    LOW,HIGH,LOW,HIGH,
    HIGH,LOW,HIGH,LOW,
    LOW,HIGH,LOW,HIGH,
    HIGH,LOW,HIGH,LOW  
    },
    {
    HIGH,LOW,HIGH,LOW,
    LOW,HIGH,LOW,HIGH,
    HIGH,LOW,HIGH,LOW,
    LOW,HIGH,LOW,HIGH
    },
    {
    LOW,HIGH,LOW,HIGH,
    HIGH,LOW,HIGH,LOW,
    LOW,HIGH,LOW,HIGH,
    HIGH,LOW,HIGH,LOW  
    }   
  }
};

CubeEventDef event2 = {
  500,
{
  {
  LOW,HIGH,LOW,HIGH,
  HIGH,LOW,HIGH,LOW,
  LOW,HIGH,LOW,HIGH,
  HIGH,LOW,HIGH,LOW  
  },     
  {
  HIGH,LOW,HIGH,LOW,
  LOW,HIGH,LOW,HIGH,
  HIGH,LOW,HIGH,LOW,
  LOW,HIGH,LOW,HIGH
  },
  {
  LOW,HIGH,LOW,HIGH,
  HIGH,LOW,HIGH,LOW,
  LOW,HIGH,LOW,HIGH,
  HIGH,LOW,HIGH,LOW  
  },
  {
  HIGH,LOW,HIGH,LOW,
  LOW,HIGH,LOW,HIGH,
  HIGH,LOW,HIGH,LOW,
  LOW,HIGH,LOW,HIGH
  }
}
};

CubeEventDef Events[] = 
{
event1
};
