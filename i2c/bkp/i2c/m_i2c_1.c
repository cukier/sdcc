//*************************************************************************
//                           m_i2c_1.c
//                         Version 1.00
//
// Mikes simple software driven I2C routine - hopefully done for compactness.
// Master Only mode - output only in this version
//
// Author: Michael Pearce
//         Chemistry Department, University of Canterbury
//
// Started: 2 June 1999
//
//*************************************************************************
// Version 1.1.0 - 15 June 2000
//  Added I2C_Read and i2cgetbyte routines - hope they work
//*************************************************************************
// Version 1.0.0 - 2 June 1999
//  Single routine to write data to i2c
//*************************************************************************


//******** REQUIRED DEFINES ***********
// #define BITNUM(adr, bit)       ((unsigned)(&adr)*8+(bit))
// static bit SCL @ BITNUM(PORTA,0)  //-- The SCL output pin
// #define SCL_TRIS       //-- The SCL Direction Register Bit
// #define SDA            //-- The SDA output pin
// #define SDA_TRIS       //-- The SDA Direction Register Bit
// #define XTAL_FREQ 8MHZ //-- Define the crystal frequency

#define I2CLOW  0         //-- Puts pin into output/low mode
#define I2CHIGH 1         //-- Puts pin into Input/high mode

#ifndef MHZ
 #define	MHZ	*1000			/* number of kHz in a MHz */
#endif
#ifndef KHZ
 #define	KHZ	*1			/* number of kHz in a kHz */
#endif


//********* I2C Bus Timing - uS ************
#define I2CSTARTDELAY 50
#define I2CSTOPDELAY  50
#define I2CDATASETTLE 20
#define I2CCLOCKHIGH  100
#define I2CHALFCLOCK  50
#define I2CCLOCKLOW   100
#define I2CACKWAITMIN 50

//********************* FUNCTIONS ************************
char I2C_Send(char Address,char *Data,char Num);
char I2C_Read(char Address,char *Data,char Num);
char i2csendbyte(char byte);
char i2cgetbyte(void);
char i2cgetack(void);
void i2csendack(void);
void i2cdelay(char delay);
void i2cstart(void);
void i2cstop(void);
void i2cclock(void);
char i2creadbit(void);

//*************************************************************************
//                          I2C_Send
//
// Inputs:
//         char Address  - Address to write data to
//         char *Data    - Pointer to buffer
//         char Num      - Number of bytes to send
//*************************************************************************
char I2C_Send(char Address,char *Data,char Num)
{
 i2cstart();

 //-- Send Address
 i2csendbyte(Address & 0xFE);   //-- Lowest bit = 0 => WRITE
 if(!i2cgetack())
 {
  i2cstop();
  return(0);
 }

 while(Num--)
 {
  i2csendbyte(*Data);
  if(!i2cgetack())
  {
   i2cstop();
   return(0);
  }
  Data++;
 }
 i2cstop();
 return(1);
}
//************** END OF I2C_Send

//*************************************************************************
//            char I2C_Read(char Address,char *data, char Num)
//*************************************************************************
char I2C_Read(char Address,char *Data, char Num)
{
 i2cstart();

 //-- Send Address
 i2csendbyte(Address | 0x01);   //-- Lowest bit = 1 => READ

 if(!i2cgetack())
 {
  i2cstop();
  return(0);
 }

 while(Num--)
 {
  *Data=i2cgetbyte();
  Data++;

  if(Num > 0)
  {
   i2csendack();
  }
 }
 i2cstop();
 return(1);

}

//*************************************************************************
//                        i2csendbyte
//*************************************************************************
char i2csendbyte(char Byte)
{
 char count;
 SDA=I2CLOW;
 SCL=I2CLOW;

 i2cdelay(I2CCLOCKLOW);         //-- Minimum Clock Low Time

 for(count=8;count>0;count--)   //-- Send 8 bits of data
 {
  if( (Byte & 0x80)== 0)        //-- Get the Bit
  {
   SDA=I2CLOW;                  //-- Ensure Port pin is low
   SDA_TRIS=I2CLOW;             //-- Lower pin if bit = 0
  }
  else
  {
   SDA_TRIS=I2CHIGH;            //-- Release pin if bit = 1
  }
  Byte=Byte<<1;                 //-- Shift next bit into position
  i2cclock();                   //-- Pulse the clock
 }
 SDA_TRIS=I2CHIGH;              //-- Release data pin for ACK
 return(1);
}
//************** END OF i2csendbyte

//*************************************************************************
//                      char i2cgetbyte(void)
//
//  Reads in a byte from the I2C Port
//*************************************************************************
char i2cgetbyte(void)
{
 char count,Byte=0;
 SDA=I2CLOW;
 SCL=I2CLOW;

 i2cdelay(I2CCLOCKLOW);         //-- Minimum Clock Low Time

 for(count=8;count>0;count--)   //-- Read 8 bits of data
 {
  Byte=Byte <<1;
  SDA_TRIS=I2CHIGH;            //-- Release pin so data can be recieved
  if(i2creadbit())
  {
   Byte +=1;
  }
 }
 return(Byte);
}


//*************************************************************************
//                           i2cstart
//*************************************************************************
void i2cstart(void)
{
 //-- Ensure pins are in high impedance mode --
 SDA_TRIS=I2CHIGH;
 SCL_TRIS=I2CHIGH;
 SCL=I2CLOW;
 SDA=I2CLOW;
 i2cdelay(I2CSTARTDELAY);

 //-- Generate the start condition
 SDA_TRIS=I2CLOW;
 SDA=I2CLOW;
 i2cdelay(I2CSTARTDELAY);
 SCL_TRIS=I2CLOW;
 i2cdelay(I2CCLOCKLOW);         //-- Minimum Clock Low Time

}
//************** END OF i2cstart

//*************************************************************************
//                           i2cstop
//*************************************************************************
void i2cstop(void)
{
  //-- Generate Stop Condition --
 SDA_TRIS=I2CLOW;
 SCL_TRIS=I2CHIGH;
 i2cdelay(I2CSTOPDELAY);
 SDA_TRIS=I2CHIGH;

}
//************** END OF i2cstop

//*************************************************************************
//                          i2cclock
//*************************************************************************
void i2cclock(void)
{
 i2cdelay(I2CDATASETTLE);       //-- Minimum Clock Low Time
 SCL_TRIS=I2CHIGH;              //-- Release clock
 i2cdelay(I2CCLOCKHIGH);        //-- Minimum Clock High Time
 SCL_TRIS=I2CLOW;               //-- Lower the clock
 i2cdelay(I2CCLOCKLOW);         //-- Minimum Clock Low Time
}
//************** END OF i2cclock


//*************************************************************************
//                          i2creadbit
//*************************************************************************
char i2creadbit(void)
{
 char Data=0;
 i2cdelay(I2CDATASETTLE);       //-- Minimum Clock Low Time
 SCL_TRIS=I2CHIGH;              //-- Release clock
 i2cdelay(I2CHALFCLOCK);        //-- 1/2 Minimum Clock High Time
 if(SDA !=0 ) Data=1;           //-- READ in the data bit
 i2cdelay(I2CHALFCLOCK);        //-- 1/2 Minimum Clock High Time
 SCL_TRIS=I2CLOW;               //-- Lower the clock
 i2cdelay(I2CCLOCKLOW);         //-- Minimum Clock Low Time
 return(Data);
}
//************** END OF i2cclock


//*************************************************************************
//                           i2cgetack
//*************************************************************************
char i2cgetack(void)
{
 SDA=I2CLOW;
 SCL=I2CLOW;
 SCL_TRIS=I2CLOW;                 //-- Ensure clock is low
 SDA_TRIS=I2CHIGH;                //-- Release the Data pin so slave can ACK
 SCL_TRIS=I2CHIGH;                //-- raise the clock pin
 i2cdelay(I2CHALFCLOCK);          //-- wait for 1/2 the clock pulse
 if(SDA)                          //-- sample the ACK signal
 {
  return(0);                      //-- No ACK so return BAD
 }
 i2cdelay(I2CHALFCLOCK);          //-- Else wait for rest of clock
 SCL_TRIS=I2CLOW;                 //-- Finish the clock pulse
 i2cdelay(I2CCLOCKLOW);           //-- Minimum Clock Low Time
 i2cdelay(I2CCLOCKLOW);           //-- Minimum Clock Low Time
 return(1);
}
//************** END OF i2cgetack


//*************************************************************************
//                   void i2csendack(void)
//*************************************************************************
void i2csendack(void)
{
 //--- Send Ack to slave except for last time ---
 SDA=0;
 SDA_TRIS=I2CLOW;              //-- Send ACK
 i2cdelay(I2CDATASETTLE);      //-- Give it time to settle
 i2cclock();                   //-- Pulse the clock
 SDA_TRIS=I2CHIGH;             //-- Release ACK
 i2cdelay(I2CDATASETTLE);      //-- Gap between next byte
}
//************** END OF i2csendack


//*************************************************************************
//                           i2cdelay
//
// This delay is approx us plus the function call delays
// Should be close enough for I2C
//*************************************************************************
void i2cdelay(const char delay)
{
	DelayUs(delay);
// DelayMs(delay);  //-- For Debug
}
//************** END OF i2cdelay


