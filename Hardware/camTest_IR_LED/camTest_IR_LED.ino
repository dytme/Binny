// Uses the Adafruit NeoPixel library by Adafruit Industries (LGPL-3.0)

#include <Adafruit_NeoPixel.h>`
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);
#define trigPin A0  //Sensor Trig pin connected to Arduino pin A0
#define echoPin A1  //Sensor Echo pin connected to Arduino pin A1

long distanceInch;
const int EMPTY_DIST = 17;  // cm
const int FULL_DIST = 5;    // cm
int fullness;
unsigned long lastDistanceUpdate = 0;
const unsigned long distanceInterval = 400;
unsigned long lastFullnessUpdate = 0;
const unsigned long fullnessInterval = 10000;

#define PIN 6
#define NUM_LEDS 35
Adafruit_NeoPixel strip(NUM_LEDS, PIN, NEO_GRB + NEO_KHZ800);

int beam = 5;

int c = 0;                     // brightness
unsigned long lastUpdate = 0;  // timestamp
bool fading = false;           // are we currently fading?
bool holding = false;          //the hold state of the lights before they turn off
int holdingTime = 5000;        //time it takes for the lights to turn off
int fadeSpeed = 2;             //the speed of the fade

int incomingByte;
bool blocked = false;


void setup() {
  Serial.begin(9600);
  pinMode(beam, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
  strip.begin();
  strip.show();
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);



  lcd.init();
  lcd.backlight();
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Binny loading...");
  delay(2000);

  lcd.clear();
  lcd.setCursor(0, 0);     //Set LCD cursor to upper left corner, column 0, row 0
  lcd.print("Distance:");  //Print Message on First Row
  lcd.setCursor(0, 1);
  lcd.print("Fulness:");
}

void loop() {
  //LEDs


  if (Serial.available() > 0) {
    char n = Serial.read();
    if (n == 'H') {
      fading = true;
      holding = false;
      c = 0;
    }
  }
  if (c >= 255) {
    fading = false;
    c = 0;
    holding = true;
  }
  if (fading == true) {
    if (millis() - lastUpdate >= fadeSpeed) {
      lastUpdate = millis();
      c += 1;
      for (int i = 0; i < NUM_LEDS; i++) {
        strip.setPixelColor(i, c, 0, 0);
      }
      strip.show();
    }
  }
  if (holding == true) {
    if (millis() - lastUpdate >= holdingTime) {
      for (int i = 0; i < NUM_LEDS; i++) {
        strip.setPixelColor(i, 0, 0, 0);
      }
      strip.show();
      holding = false;
    }
  }

  //IR beam sensor
  int beamSignal = digitalRead(beam);
  int beam2 = digitalRead(4);
  if (beamSignal == 1 || beam2 == 1) {
    blocked = true;
  } else if ((beamSignal == 0 && beam2 == 0) && blocked == true) {  //basically check if the same item is still blocking or has already pass so count the item only once and doesnt require delay to properly detect second object
    blocked = false;
    Serial.println("1");
  }
  //Serial.println(digitalRead(5));

  //ultrasonic and lcd
  if (millis() - lastDistanceUpdate >= distanceInterval) {
    lastDistanceUpdate = millis();
    long duration, distance;

    digitalWrite(trigPin, LOW);

    //delayMicroseconds(2);

    digitalWrite(trigPin, HIGH);

    //delayMicroseconds(10);

    digitalWrite(trigPin, LOW);

    duration = pulseIn(echoPin, HIGH, 20000);
    distance = (duration / 2) / 29.1;
    distanceInch = duration * 0.0133 / 2;

    if (distance >= EMPTY_DIST) {
      fullness = 0;
    } else if (distance <= FULL_DIST) {
      fullness = 100;
    } else {
      fullness = map(distance, EMPTY_DIST, FULL_DIST, 0, 100);
    }
    

    if (millis() - lastFullnessUpdate >= fullnessInterval) {
      lastFullnessUpdate = millis();
      Serial.print("F");
      Serial.println(fullness);
    }

    lcd.setCursor(9, 0);
    lcd.print("                         ");
    lcd.setCursor(9, 0);
    lcd.print(distance);  //Print measured distance
    lcd.print(" cm");
    lcd.setCursor(9, 1);                     //
    lcd.print("                         ");  //Print blanks to clear the row
    lcd.setCursor(9, 1);
    lcd.print(fullness);
    lcd.print(" %");
  }
}
