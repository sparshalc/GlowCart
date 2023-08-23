
# Ecommerce Integration with Arduino and LED Display

Welcome to the Ecommerce Integration project, a unique and innovative solution that combines the power of Ruby on Rails, Arduino, and LED displays to enhance the shopping experience. This project demonstrates a seamless integration between an online ecommerce platform and a physical 16x2 LED display, along with a corresponding indicator light.

Key Features:

Real-time Product Information: Gain real-time access to product information from your ecommerce website's database and display it on the Arduino-controlled 16x2 LED display. Shoppers can quickly view essential details without the need for a digital screen.

Physical Shopping Indicator: The integration goes beyond the virtual realm by triggering a physical indicator light whenever a new order is placed or a specific event occurs on the website. This provides an interactive and engaging shopping environment.

Ruby on Rails Backend: The project utilizes the robust Ruby on Rails framework for the backend, ensuring smooth data flow between the ecommerce database and the Arduino controller. This allows for easy management of product information and events.

Enhanced Shopping Experience: By merging the digital and physical worlds, this project redefines the shopping experience. Customers can interact with products in a novel way, making shopping not just about transactions but also about engagement and interaction.

How to Use:

1. Clone the repository to your local environment.
2. Set up the Ruby on Rails backend.
3. Connect your Arduino board to the LED display and indicator light.
4. Configure the code in Sketch.
5. Start the Rails server and begin testing the integration.

```sketch
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
        delay(7000);
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
```

<img src="/ui.png" >