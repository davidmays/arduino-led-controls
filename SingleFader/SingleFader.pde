
#define BASEPIN 9
#define GND 8

void setup()
{
  pinMode(GND,OUTPUT);
  digitalWrite(GND,LOW);
  pinMode(BASEPIN,OUTPUT);
}

void loop()
{
  for(int i=5;i<255;i++)
  {
    analogWrite(BASEPIN, i);
    delay(5);
  }
  delay(10);
  for(int i=255;i>=5;i--)
  {
    analogWrite(BASEPIN, i);
    delay(5);
  }
  delay(50);
}


