/*
SparkFun Cellular Shield - Pass-Through Sample Sketch
 SparkFun Electronics
 Written by Ryan Owens
 3/8/10
 
 Description: This sketch is written to interface an Arduino Duemillanove to a  Cellular Shield from SparkFun Electronics.
 The cellular shield can be purchased here: http://www.sparkfun.com/commerce/product_info.php?products_id=9607
 In this sketch serial commands are passed from a terminal program to the SM5100B cellular module; and responses from the cellular
 module are posted in the terminal. More information is found in the sketch comments.
 
 An activated SIM card must be inserted into the SIM card holder on the board in order to use the device!
 
 This sketch utilizes the NewSoftSerial library written by Mikal Hart of Arduiniana. The library can be downloaded at this URL:
 http://arduiniana.org/libraries/NewSoftSerial/
 
 This code is provided under the Creative Commons Attribution License. More information can be found here:
 http://creativecommons.org/licenses/by/3.0/
 
 (Use our code freely! Please just remember to give us credit where it's due. Thanks!)
 */

#include <NewSoftSerial.h>  //Include the NewSoftSerial library to send serial commands to the cellular module.
#include <TinyGPS.h>
#include <string.h>         //Used for string manipulations

char incoming_char=0;      //Will hold the incoming character from the Serial Port.

TinyGPS gps;
NewSoftSerial gps_recv(6,7);  //Create a 'fake' serial port. Pin 2 is the Rx pin, pin 3 is the Tx pin.

void setup()
{
  //Initialize serial ports for communication.
  Serial.begin(4800);
  gps_recv.begin(4800);

  //Let's get started!
  Serial.println("Starting...");
}

void loop()
{
  while (gps_recv.available())
  {
    int c = gps_recv.read();
    if (gps.encode(c))
    {
      long lat, lon;
      unsigned long fix_age, time, date, speed, course;
      unsigned long chars;
      unsigned short sentences, failed_checksum;

      // retrieves +/- lat/long in 100000ths of a degree
      gps.get_position(&lat, &lon, &fix_age);

      if (fix_age == TinyGPS::GPS_INVALID_AGE)
        Serial.println("No fix detected");
      else if (fix_age > 5000)
        Serial.println("Warning: possible stale data!");
      else
        Serial.println("Data is current.");

      // time in hhmmsscc, date in ddmmyy
      gps.get_datetime(&date, &time, &fix_age);

      // returns speed in 100ths of a knot
      speed = gps.speed();

      // course in 100ths of a degree
      course = gps.course();

      Serial.println("Lat: " + lat);
    }
    else{

      //      gps.stats(&chars, &sentences, &failed_checksum);
    }
  }
}




