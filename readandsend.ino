int ldrPin = A0;
int ldrValue = 0;
int tempPin = A1;
int tempValue = 0;
float tempC = 0.0;
unsigned long currentdelay;
unsigned long previousdelay;

void setup()
{
  //analogReference(INTERNAL1V1);
  Serial.begin(9600);
}

void loop()
{
  currentdelay = millis();

  unsigned int minute = 1000;
  
  if (currentdelay - previousdelay >= minute) 
  {
    // save the last time you blinked the LED
    previousdelay = currentdelay;

    ldrValue = analogRead(ldrPin);
    tempValue = analogRead(tempPin);

    tempC = (tempValue*500.0)/1024;

    Serial.print(ldrValue);
    Serial.print(",");
    Serial.println(tempC);
  }
}
