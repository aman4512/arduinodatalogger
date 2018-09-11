int ldrPin = A0;
int ldrValue = 0;
int tempPin = A1;
int tempValue = 0;
float tempC = 0.0;
unsigned long currentdelay;
unsigned long previousdelay;
int led = LED_BUILTIN;           // the pin that the LED is attached to
int brightness = 0;    // how bright the LED is
int fadeAmount = 5;    // how many points to fade the LED by


void setup()
{
  pinMode(LED_BUILTIN, OUTPUT);
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
analogWrite(led, ldrValue/4);


}
