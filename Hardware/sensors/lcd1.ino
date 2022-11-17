//#include <LiquidCrystal_I2C.h>
//
//LiquidCrystal_I2C lcd(0x27, 16, 2); // I2C address 0x27, 16 column and 2 rows
//
//void setup() {
//  lcd.init(); // initialize the lcd
//  lcd.clear();
//  lcd.backlight();
//
//  lcd.setCursor(0, 0);      // move cursor to   (0, 0)
//  lcd.print("Hello");       // print message at (0, 0)
//  lcd.setCursor(2, 1);      // move cursor to   (2, 1)
//  lcd.print("esp32io.com"); // print message at (2, 1)
//}
//
//void loop() {
//}




#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 16, 2); // I2C address 0x27, 16 column and 2 rows

void setup()
{
  Wire.begin();
  Serial.begin(115200);

  lcd.init(); // initialize the lcd
  lcd.clear();
  lcd.backlight();


  lcd.setCursor(2,0);   //Set cursor to character 2 on line 0
  lcd.print("Hello world!");
  
  lcd.setCursor(2,1);   //Move cursor to character 2 on line 1
  lcd.print("LCD Tutorial");
}

void loop()
{
  int error;
  int address;
  int devices = 0;

  Serial.println("Devices found:");

  for(address = 1; address < 127; address++ ) 
  {
    Wire.beginTransmission(address);
    error = Wire.endTransmission();

    if (error == 0)
    {
      Serial.print("0x");
      if (address<16) 
        Serial.print("0");
      Serial.println(address,HEX);
      devices++;
    }
    
    else if (error==4) 
    {
      Serial.print("Unknown error at address 0x");
      if (address<16) 
        Serial.print("0");
      Serial.println(address,HEX);
    }    
  }
  
  if (devices == 0)
    Serial.println("No I2C devices found");

  delay(5000);           
}

