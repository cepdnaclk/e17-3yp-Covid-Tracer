#define BUZZER_PIN 11

void setup() {
  
}

void loop() {
  //short 
  int i = 0;
  do{
    tone(BUZZER_PIN, 450);
    delay(200);
    noTone(BUZZER_PIN);
    delay(200);
  }while(i<3);

  delay(3000);

  //long
  tone(BUZZER_PIN, 450);
  delay(500);
  noTone(BUZZER_PIN);
  delay(500);
}
