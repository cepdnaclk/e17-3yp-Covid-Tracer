#include <Wire.h>
#include <Adafruit_MLX90614.h>
 
Adafruit_MLX90614 mlx = Adafruit_MLX90614();
 
void setup(){
  Serial.begin(115200);
  mlx.begin();
}
 
void loop(){
  Serial.print(mlx.readObjectTempC());
  Serial.println("*C");

  delay(1000);
}
