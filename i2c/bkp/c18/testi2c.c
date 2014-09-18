//*************************************************************************
//                           testi2c.c
//                         Version 1.00
//
// Simple test routines for Mikes i2c Routines
//
//
// Author: Michael Pearce
//         Chemistry Department, University of Canterbury
//
// Started: 2 June 1999
//
// Processor: 16C64 - on the LCD Keypad Board
//
//*************************************************************************
// Version 1.00 - 2 June 1999
//  Tests send only - data sent to LCD at i2c Address 74h
//*************************************************************************


#include <pic.h>

#define BITNUM(adr, bit)       ((unsigned)(&adr)*8+(bit))
//static bit SCL      @ BITNUM(PORTC,3);   //-- The SCL output pin
//static bit SCL_TRIS @ BITNUM(TRISC,3);   //-- The SCL Direction Register Bit
//static bit SDA      @ BITNUM(PORTC,4);   //-- The SDA output pin
//static bit SDA_TRIS @ BITNUM(TRISC,4);   //-- The SDA Direction Register Bit

static bit SCL      @ BITNUM(PORTA,0);   //-- The SCL output pin
static bit SCL_TRIS @ BITNUM(TRISA,0);   //-- The SCL Direction Register Bit
static bit SDA      @ BITNUM(PORTA,1);   //-- The SDA output pin
static bit SDA_TRIS @ BITNUM(TRISA,1);   //-- The SDA Direction Register Bit



#define XTAL_FREQ 10MHZ       //-- Define the crystal frequency
//#define SLOWDOWN
#include "m_i2c_1.c"

char I2CBUFF[5]={0x00,0x0F,0xF0,0x01,0x10};
void pause(char sec);


void main(void)
{
	OPTION=0xFF;
	GIE=0;

 while(1)
 {
  pause(1);
  I2CBUFF[1]++;
  I2CBUFF[2]--;
  I2CBUFF[3]++;
  I2CBUFF[4]--;
  I2CBUFF[0]=0;
  I2C_Send(0x74,I2CBUFF,5);
 }
}
void pause(char sec)
{
 int count1,count2;
 while(sec-- >0)
 {
  for(count1=10;count1>0;count1--)
  {
   for(count2=10;count2>0;count2--)
   {
    i2cdelay(96);
   }
  }
 }
}
