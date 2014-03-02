#include "CylinderSystem.h"

#define HIGH 0x1
#define LOW 0x0

CylinderEventDef event1 = {
  500,
  {
    {HIGH,LOW,LOW,LOW,LOW,LOW,LOW,LOW},
    {LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW},
    {LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW},
  }
};


CylinderEventDef Events[] = 
{
event1
};
