#include "CylinderSystem.h"

#ifndef __PINPATTERNS__
#define __PINPATTERNS__

#define HIGH 0x1
#define LOW 0x0

CylinderEventDef event1 = {
  50,
  {
    {HIGH,LOW,LOW,LOW,LOW,LOW,LOW,LOW},
    {LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW},
    {LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW},
  }
};


CylinderEventDef event2 = {
  50,
  {
    {LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW},
    {HIGH,LOW,LOW,LOW,LOW,LOW,LOW,LOW},
    {LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW},
  }
};

CylinderEventDef event3 = {
  50,
  {
    {LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW},
    {LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW},
    {HIGH,LOW,LOW,LOW,LOW,LOW,LOW,LOW},
  }
};

CylinderEventDef Events[] = 
{
event1,event2,event3
};


#endif //__PINPATTERNS__
