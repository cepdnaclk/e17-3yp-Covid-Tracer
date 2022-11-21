#include "Secrets.h"
#include <WiFiClientSecure.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>
#include "WiFi.h"

#include <LiquidCrystal_I2C.h>
#include <NewPing.h>
#include <Adafruit_MLX90614.h>

 
#define AWS_IOT_PUBLISH_TOPIC   "publish_merchant_db"
#define AWS_IOT_SUBSCRIBE_TOPIC "user_covid_result"

#define BUZZER_PIN 11
#define TRIGGER_PIN 4
#define ECHO_PIN 2
#define MAX_DISTANCE 10


WiFiClientSecure net = WiFiClientSecure();
PubSubClient client(net);

LiquidCrystal_I2C lcd(0x27, 16, 2); // I2C address 0x27, 16 column and 2 rows
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);
Adafruit_MLX90614 mlx = Adafruit_MLX90614();

String id="";
unsigned int distance;
float temp;

 
void connectAWS()
{
  WiFi.mode(WIFI_STA);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
 
  Serial.println("Connecting to Wi-Fi");
 
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.println("not connected yet");
  }
 
  // Configure WiFiClientSecure to use the AWS IoT device credentials
  net.setCACert(AWS_CERT_CA);
  net.setCertificate(AWS_CERT_CRT);
  net.setPrivateKey(AWS_CERT_PRIVATE);
 
  // Connect to the MQTT broker on the AWS endpoint we defined earlier
  client.setServer(AWS_IOT_ENDPOINT, 8883);
 
  // Create a message handler
  client.setCallback(messageHandler);
 
  Serial.println("Connecting to AWS IOT");
 
  while (!client.connect(THINGNAME))
  {
    Serial.println("Connecting to Thing");
    delay(100);
  }
 
  if (!client.connected())
  {
    Serial.println("AWS IoT Timeout!");
    return;
  }
 
  // Subscribe to a topic
  client.subscribe(AWS_IOT_SUBSCRIBE_TOPIC);
 
  Serial.println("AWS IoT Connected!");
}
 
void publishMessage()
{
  
  char jsonBuffer[512]="This is the publishing messge";
 
  client.publish(AWS_IOT_PUBLISH_TOPIC, jsonBuffer);
}
 
void messageHandler(char* topic, byte* payload, unsigned int length)
{
  Serial.print("incoming: ");
  Serial.println(topic);
 
  StaticJsonDocument<200> doc;
  deserializeJson(doc, payload);
  const char* message = doc["message"];
  Serial.println(message);

  decisions(doc["id"], doc["response"]);
}

void decisions(String r_id, String response ){
  if(id.equalsIgnoreCase(r_id)){
    /*not allowed*/
    int i = 0;
    do{
      tone(BUZZER_PIN, 450);
      delay(500);
      noTone(BUZZER_PIN);
      delay(500);
    }while(i<3);

    lcd.clear();
    lcd.setCursor(0,0);   
    lcd.print("HIGH Temp!"); 
    lcd.setCursor(0,1);   
    lcd.print("NOT ALLOWED!");
  }
}

void setup()
{
  Serial.begin(115200);
  connectAWS();

  Serial2.begin(115200); // RX-16, TX-17 (for barcode reader)

  lcd.init(); // initialize the lcd
  lcd.clear();
  lcd.backlight();

  mlx.begin();
}
 
void loop()
{

//  Serial.println("New publish");
// 
//  publishMessage();
//  client.loop();
//  delay(1000);
  
  lcd.setCursor(0,0);   //Set cursor to character 0 on line 0
  lcd.print("HELLO!");
  lcd.setCursor(0,1);   //Move cursor to character 0 on line 1
  lcd.print("WELCOME!");
  
  if(Serial2.available()){ // Check if there is Incoming Data in the Serial Buffer.
    tone(BUZZER_PIN, 450);
    delay(200);
    noTone(BUZZER_PIN);

    lcd.clear();
    lcd.setCursor(0,0);   
    lcd.print("WAIT!");
    
    delay(20);  // just wait a little bit for more characters to arrive
    while (Serial2.available()){ // Keep reading Byte by Byte from the Buffer till the Buffer is empty
      id.concat(Serial2.read()); // Read 1 Byte of data and append it to a String variable
      delay(5); // A small delay
    }
    
    lcd.clear();
    lcd.setCursor(0,0);   
    lcd.print("Temp Sensing");

    delay(500);
    distance = sonar.ping_cm();
    delay(500);

    if(distance>0){
      temp = mlx.readObjectTempC();
      delay(500);

      /*publish id and temp*/
      Serial.println("New publish");
      publishMessage();
      delay(1000);
      
      if(temp>38.0){
        /*not allowed*/
        int i = 0;
        do{
          tone(BUZZER_PIN, 450);
          delay(500);
          noTone(BUZZER_PIN);
          delay(500);
        }while(i<3);

        lcd.clear();
        lcd.setCursor(0,0);   
        lcd.print("HIGH Temp!"); 
        lcd.setCursor(0,1);   
        lcd.print("NOT ALLOWED!");     
      }
      else{
        /*subscribe response*/
        /*take decisions*/
        client.loop();
         
      }
    }
    else{
      tone(BUZZER_PIN, 450);
      delay(1000);
      noTone(BUZZER_PIN);
      
      lcd.clear();
      lcd.setCursor(0,0);   
      lcd.print("NOT SENSED!"); 
    } 
  }
}
