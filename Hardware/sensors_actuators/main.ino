#include <NewPing.h>
#include <Wire.h>
#include <Adafruit_MLX90614.h>
#include <LiquidCrystal_I2C.h>
 
#define TRIGGER_PIN 4
#define ECHO_PIN 2
#define MAX_DISTANCE 10
#define BUZZER_PIN 11

// NewPing setup of pins and maximum distance
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); 

Adafruit_MLX90614 mlx = Adafruit_MLX90614();

LiquidCrystal_I2C lcd(0x27, 16, 2); // I2C address 0x27, 16 column and 2 rows

String id;
unsigned int distance;
float temp;

void setup(){
  Serial.begin(115200);  

  mlx.begin();

  Wire.begin();

  lcd.init(); // initialize the lcd
  lcd.clear();
  lcd.backlight();


  lcd.setCursor(2,0);   //Set cursor to character 2 on line 0
  lcd.print("Hello!");
  
  lcd.setCursor(2,1);   //Move cursor to character 2 on line 1
  lcd.print("Welcome!");
}

void loop(){
  if(Serial.available()){
    id = Serial.readStringUntil('\n');

    delay(50);
    distance = sonar.ping_cm();
    
    if(distance>0){
      temp = mlx.readObjectTempC();
      delay(1000);

      if(temp > 38.0){
        /*not allowed*/
        int i = 0;
        do{
          tone(BUZZER_PIN, 450);
          delay(500);
          noTone(BUZZER_PIN);
          delay(500);
        }while(i<3);

        lcd.setCursor(2,1);   //Move cursor to character 2 on line 1
        lcd.print("NOT ALLOWED!");
      }
      else{
        /*publish*/
        /*response returns*/
        /*take decisions*/ 
      }
    }
  }
}
