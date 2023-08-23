#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);

const int ledPin = 13;

void setup() {
  lcd.init();
  lcd.backlight();
  lcd.setCursor(0, 0);
  lcd.print("----GlowCart----");
  lcd.setCursor(0, 1);
  lcd.print("----Welcome-----");

  pinMode(ledPin, OUTPUT); // Set the built-in LED pin as OUTPUT

  Serial.begin(9600);
}

void loop() {
  // Read input from Serial and act accordingly
  if (Serial.available() > 0) {
    String inputText = Serial.readStringUntil('\n'); // Read until newline character
    Serial.println(inputText);

    updateLCD(inputText); // Call the function with the received text
    
    char command = Serial.read();
    if (command == '1') {
      digitalWrite(ledPin, HIGH); // Turn on the built-in LED
      delay(3000);
      digitalWrite(ledPin, LOW); // Turn off the built-in LED
    }
  }
}

void updateLCD(String text) {
  lcd.clear();
  lcd.setCursor(0, 1);
  lcd.print("added to cart!");
  lcd.setCursor(0, 0);
  lcd.print(text);
  delay(4000);
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Add More product");
  lcd.setCursor(0, 1);
  lcd.print("to display!");
}
