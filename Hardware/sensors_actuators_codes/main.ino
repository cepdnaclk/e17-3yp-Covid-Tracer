#include "Secrets.h"
#include <WiFiClientSecure.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>
#include "WiFi.h"
#include "time.h"

#include <LiquidCrystal_I2C.h>
#include <NewPing.h>
#include <Adafruit_MLX90614.h>
#include <Arduino.h>

 
#define AWS_IOT_PUBLISH_TOPIC   "publish_merchant_db"
#define AWS_IOT_SUBSCRIBE_TOPIC "user_covid_result"

#define BUZZER_PIN 23
#define TRIGGER_PIN 26
#define ECHO_PIN 25
#define MAX_DISTANCE 10


WiFiClientSecure net = WiFiClientSecure();
PubSubClient client(net);

LiquidCrystal_I2C lcd(0x27, 16, 2); // I2C address 0x27, 16 column and 2 rows
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);
Adafruit_MLX90614 mlx = Adafruit_MLX90614();

String id_no="";
unsigned int distance=0;
float temp;
String msg="";
byte* buffer;
boolean Rflag=false;
int r_len;

//data from serial port
String id_data="";
//line has arrived
boolean complete=false;
int countstr=0;
//search for ending
unsigned long millisendstr=0;

const char* ntpServer = "pool.ntp.org";
const long gmtOffset_sec = 19800;
const int daylightOffset_sec = 0;
char local_date[11];
char local_time[9];

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

  client.setBufferSize(512);
 
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
 
void publishMessage(String id, float temp)
{
  localDateTime();
  
  StaticJsonDocument<300> doc;

  doc["date"]=local_date;
  doc["time"]=local_time;
  doc["nic"] = id;
  doc["full_name"]=".";
  doc["sex"]=".";
  doc["address"]=".";
  doc["temperature"] = temp;
  
  char out[512];
  serializeJson(doc, out);  
 
  client.publish(AWS_IOT_PUBLISH_TOPIC, out);
  Serial.println("new publish");
}
 
void messageHandler(char* topic, byte* payload, unsigned int length)
{
  Rflag=true; //will use in main loop
  Serial.print("incoming: ");
  Serial.println(topic);

  r_len=length; //will use in main loop
  int i=0;
  for (i;i<length;i++) {
    //buffer[i]=payload[i];
    msg+=(char)payload[i];
    //Serial.print(msg[i]);
  }
  //buffer[i]='\0'; //terminate string
  Serial.println(msg);
  //Serial.println(Rflag);
//  StaticJsonDocument<200> doc;
//  deserializeJson(doc, msg);
  Serial.println(msg.substring(63,75));
  Serial.println(msg.substring(47,48));
  decisions(msg.substring(63,75), msg.substring(47,48));
  //Serial.print(msg.substring(62,74));
  //Serial.println();
  //Serial.print(msg.substring(46,47));
  //Serial.println();
  
}

void decisions(String r_id, String response ){
  int i;
  if(id_no.equalsIgnoreCase(r_id)){
    /*allowed*/
    if(response == "F"){
      Serial.println("ok");
      lcd.clear();
      lcd.setCursor(0,0);   
      lcd.print("OK!"); 
      lcd.setCursor(0,1);   
      lcd.print("ALLOWED!"); 
      
      i = 0;
      do{
        tone(BUZZER_PIN, 450);
        delay(200);
        noTone(BUZZER_PIN);
        delay(200);
        i++;
      }while(i<3); 
    }
    /*not allowed*/
    else{
      Serial.println("not ok");
      lcd.clear();
      lcd.setCursor(0,0);   
      lcd.print("DETECTED!"); 
      lcd.setCursor(0,1);   
      lcd.print("NOT ALLOWED!");
      
      i = 0;
      do{
        tone(BUZZER_PIN, 450);
        delay(500);
        noTone(BUZZER_PIN);
        delay(500);
        i++;
      }while(i<3); 
    }
  }
}

//void decisions(){
//  int i;
//  if(!id_no.equalsIgnoreCase("111111111111")){
//    /*allowed*/ 
//    lcd.clear();
//    lcd.setCursor(0,0);   
//    lcd.print("OK!"); 
//    lcd.setCursor(0,1);   
//    lcd.print("ALLOWED!"); 
//      
//    i = 0;
//    do{
//      tone(BUZZER_PIN, 450);
//      delay(200);
//      noTone(BUZZER_PIN);
//      delay(200);
//      i++;
//    }while(i<3); 
//    
//  /*not allowed*/
//  }else{
//    lcd.clear();
//    lcd.setCursor(0,0);   
//    lcd.print("DETECTED!"); 
//    lcd.setCursor(0,1);   
//    lcd.print("NOT ALLOWED!");
//      
//    i = 0;
//    do{
//      tone(BUZZER_PIN, 450);
//      delay(500);
//      noTone(BUZZER_PIN);
//      delay(500);
//      i++;
//    }while(i<3); 
//  }
//}

//void reconnect() {
//  // Loop until we're reconnected
//  while (!client.connected()) {
//    Serial.print("Attempting MQTT connection...");
//    // Attempt to connect
//    if (client.connect("ESP32Client")) {
//      Serial.println("connected");
//      // Subscribe
//      client.subscribe(AWS_IOT_SUBSCRIBE_TOPIC);
//    } else {
//      Serial.print("failed, rc=");
//      Serial.print(client.state());
//      Serial.println(" try again in 5 seconds");
//      // Wait 5 seconds before retrying
//      delay(5000);
//    }
//  }
//}

void serialScannerEvent(){
  if (Serial2.available()>0) {
    //get the new byte
    char inChar = (char)Serial2.read();
    //add it to the input string
    id_data += inChar;
    countstr++;
    millisendstr=millis();
  }
  else{
    if(millis()-millisendstr>1000 && countstr>0) {
      id_data.trim();
      complete=true;
    }
  }
}
void localDateTime(){
  struct tm timeinfo;
  if(!getLocalTime(&timeinfo)){
    Serial.println("Failed to obtain time");
    return;
  }
  strftime(local_date,11, "%F", &timeinfo);
  strftime(local_time,9, "%T", &timeinfo);
}

void setup()
{
  Serial.begin(115200);
  connectAWS();

  Serial2.begin(9600);
  id_data.reserve(50);

  lcd.init(); // initialize the lcd
  lcd.clear();
  lcd.backlight();

  mlx.begin();

  configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);
}
 
void loop()
{
//   if (!client.connected()) {
//    reconnect();
//  }
  client.loop();
  
  lcd.clear();
  lcd.setCursor(0,0);   //Set cursor to character 0 on line 0
  lcd.print("HELLO!");
  lcd.setCursor(0,1);   //Move cursor to character 0 on line 1
  lcd.print("SCAN NIC!");

  while(!Serial2.available()){}
  
  while(true){
    serialScannerEvent();
    if (complete) {
      id_no="";
      id_no = id_no + id_data;
      Serial.println(id_no);
      id_data="";
      complete=false; 
      countstr=0;
      break;
    }
  }
    
  delay(1000);  
    
  lcd.clear();
  lcd.setCursor(0,0);   
  lcd.print("Temp Sensing");

  delay(1000);
  
  while(true){
    distance = sonar.ping_cm();
    temp = mlx.readObjectTempC();
    Serial.print(distance);
    Serial.print("  ");
    Serial.println(temp);
    if(distance>0){
      tone(BUZZER_PIN, 450);
      delay(500);
      noTone(BUZZER_PIN);
      break;
    }
  }
  delay(1000);
  
  /*publish id and temp*/
  publishMessage(id_no, temp);
  //Serial.println("New publish");
  lcd.clear();
  lcd.setCursor(0,0);   
  lcd.print(id_no);
  lcd.setCursor(0,1);   
  lcd.print(temp);
  delay(4000);
      
  if(temp>40.0){
    /*not allowed*/
    lcd.clear();
    lcd.setCursor(0,0);   
    lcd.print("HIGH Temp!"); 
    lcd.setCursor(0,1);   
    lcd.print("NOT ALLOWED!");
        
    int i = 0;
    do{
      tone(BUZZER_PIN, 450);
      delay(500);
      noTone(BUZZER_PIN);
      delay(500);
      i++;
    }while(i<3);     
  }
  else{
    lcd.clear();
    lcd.setCursor(0,0);   
    lcd.print("Wait!");
    /*subscribe response*/
    /*take decisions*/
    delay(1000);
  //  while(true){
  //    if(Rflag){
  //      Serial.println("in");
        //StaticJsonDocument<200> doc;
//        deserializeJson(doc, msg);
//        decisions(doc["nic"], doc["under_quarantine"]);
      //  Rflag = false;
     //   break;
      //} 
    //}
    //decisions();
    //Serial.println(msg);
  } 
//  WiFi.disconnect();
//  connectAWS();
  delay(5000);
}
