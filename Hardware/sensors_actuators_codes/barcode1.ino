//int count = 0;

void setup() {
  Serial.begin(115200);
}

void loop() {
  if(Serial.available()){
    //count = 0;
    while(Serial.available()){
      char input = Serial.read();
      Serial.print(input);
      //count++;
      delay(5);
    }
    Serial.println();
  }
}




