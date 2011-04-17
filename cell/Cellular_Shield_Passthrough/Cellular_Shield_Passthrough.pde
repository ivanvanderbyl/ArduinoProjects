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
#include <string.h>         //Used for string manipulations

char incoming_char=0;      //Will hold the incoming character from the Serial Port.
char* incoming;

NewSoftSerial cell(2,3);  //Create a 'fake' serial port. Pin 2 is the Rx pin, pin 3 is the Tx pin.

// NewSoftSerial gps(4,5);

void setup()
{
  pinMode(13, OUTPUT);
  
  //Initialize serial ports for communication.
  Serial.begin(9600);
  cell.begin(9600);
  // gps.begin(9600);
  
  //Let's get started!
  Serial.println("Starting SM5100B Communication...");
}

void loop() {
  
  // if(gps.available() >0)
  // {
  //   incoming_char=gps.read();    //Get the character from the cellular serial port.
  //   Serial.print(incoming_char);  //Print the incoming character to the terminal.
  // }
  
  //If a character comes in from the cellular module...
  if(cell.available() >0)
  {
    incoming_char=cell.read();    //Get the character from the cellular serial port.
    Serial.print(incoming_char);  //Print the incoming character to the terminal.
  }
  //If a character is coming from the terminal to the Arduino...
  if(Serial.available() >0)
  {
    
    incoming_char = Serial.read();
    
    // memset(incoming, 0xFF, Serial.available());
    // 
    // for(size_t i = 0; i < Serial.available(); ++i)
    // {
    //   incoming[i] = Serial.read();
    // }

    // incoming_char=Serial.read();  //Get the character coming from the terminal
    cell.print(incoming_char);    //Send the character to the cellular module
    // Serial.println(incoming_char);
    
//    Serial.println("Sending txt...");
//    cell.println("AT+CMGF=1"); // set SMS mode to text
//    cell.print("AT+CMGS=");  // now send message...
//    cell.print(34,BYTE); // ASCII equivalent of "
//    cell.print("0432221634");
//    cell.println(34,BYTE);  // ASCII equivalent of "
//    delay(500); // give the module some thinking time
//    cell.print("Hello from Ivan's desk. I am a machine.");   // our message to send
//    cell.println(26,BYTE);  // ASCII equivalent of Ctrl-Z
//    delay(15000); // the SMS module needs time to return to OK status
//    do // You don't want to send out multiple SMSs.... or do you?
//    {
//    delay(1);
//    }
//    while (1>0);
//    Serial.println("Done");
  }
}
