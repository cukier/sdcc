/*-------------------------------------------------------------------------
  I2C Basic Functions

   Written By - Dipl.-Ing. (FH) Michael Schmitt
    michael.schmitt@t-online.de

    Initial Version March 2000

   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 2, or (at your option) any
   later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

   In other words, you are welcome to use, share and improve this program.
   You are forbidden to forbid anyone else to use, share and improve
   what you give them.   Help stamp out software-hoarding!
-------------------------------------------------------------------------*/

/********************************************************************/
/* Function    : I2C Basic Funktions                           FILE */
/*------------------------------------------------------------------*/
/* Description : This File has the basic functions needed for       */
/*               I2C comunication and is optimized to meet the      */
/*               requirements of 100KHz I2C running on normal       */
/*               8051 Core @ 24MHz                                  */
/*------------------------------------------------------------------*/
/* Author      : Michael Schmitt                                    */
/*------------------------------------------------------------------*/
/* Input       : none                                               */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 00/03    V1.0 Initial Version                      */
/*                                                                  */
/********************************************************************/
#ifndef __FILE_I2CBASIC_C
#define __FILE_I2CBASIC_C

//#define I2C_DEBUG_MODE

void I2CDelay( void )
{
    NOP;
    NOP;
    NOP;
    NOP;
    NOP;
    NOP;
}

// Send the I2C start command to the target device
// "safety start" for 100kHz devices (24MHz)
void I2CSendStart( void )
{
#ifdef I2C_DEBUG_MODE
    printf("\n\r<Start>");
#endif
    // Start Condition SDA 1->0 while SCL is 1
    I2CDelay();
    I2CSDA = 1;
    I2CDelay();
    I2CSCL = 1;
    I2CDelay();
    I2CSDA = 0;
    I2CDelay();
    I2CSCL = 0;
    I2CDelay();
}


// Send the I2C stop command to the target device
// "safety stop" for 100kHz devices (24MHz)
void I2CSendStop( void )
{
#ifdef I2C_DEBUG_MODE
printf("<Stopp>");
#endif
    // Stop Condition SDA 0->1 while SCL is 1
    I2CDelay();
    I2CSDA = 0;
    I2CDelay();
    I2CSCL = 1;
    I2CDelay();
    I2CSDA = 1;
    I2CDelay();
}


// Send a clock pulse and check SDA for an ACK
// Target will send an ACK as a 1
// If SDA is 0 there is no ACK what means NACK
unsigned char I2CCheckACK( void )
{
    unsigned char return_value;
    I2CSDA = 1;
        NOP;
        NOP;
        NOP;
        NOP;
//    I2CDelay();
    I2CSCL = 1;
//      NOP;
//      NOP;
//      NOP;
//      NOP;
//      NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
//    I2CDelay();
    return_value = !I2CSDA;   // invert
#ifdef I2C_DEBUG_MODE
    if( return_value == 1 )
    {
        printf("<?ACK>");
    }
    else
    {
        printf("<?NACK>");
    }
#endif
    I2CSCL = 0;
    return( return_value ); // 1=ACK 0=NACK
}

// Send a NACK
void I2CSendNACK( void )
{
#ifdef I2C_DEBUG_MODE
printf("<!NACK>");
#endif
    // NACK by Master sending a single 1
    I2CSDA = 1;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
//    I2CDelay();
    I2CSCL = 1;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
//    I2CDelay();
    I2CSCL = 0;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
//    I2CDelay();
    I2CSDA = 0;
}

// Send a ACK
void I2CSendACK( void )
{
#ifdef I2C_DEBUG_MODE
    printf("<!ACK>");
#endif
    // ACK by Master sending a single 0
        I2CSDA = 0;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
//    I2CDelay();
    I2CSCL = 1;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
//    I2CDelay();
    I2CSCL = 0; // Cmd executin lasts 1usec so clk 100KHz
//      NOP;
//      NOP;
//      NOP;
//      NOP;
//      NOP;
//      NOP;
//      NOP;
//      NOP;
//      NOP;
//      NOP;
//    I2CDelay();
//  I2CSDA = 0;
}

// Send a byte to the target
void I2CSendByte(unsigned char SendByte)
{
    register unsigned char i;
#ifdef I2C_DEBUG_MODE
printf("<S:%02X>",(unsigned int)SendByte);
#endif
    for (i=0; i<8; i++)
    {
//      I2CDelay();
        if ( SendByte & 0x80)
        {
            I2CSDA = 1;        // MSB first -> LSB last
        }
        else
        {
            I2CSDA = 0;
        }
//      NOP;
//      NOP;
//      NOP;
//      NOP;
        I2CSCL = 1;
        /* doing the shift during clocking, otherwise the pulse width would be to short */
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        SendByte = SendByte << 1;
//      I2CDelay();
        I2CSCL = 0;
//      I2CDelay();
    }
}

// Receive a byte from the target
unsigned char I2CGetByte( void )
{
    register unsigned char i, res;

    I2CSDA = 1; /* release SDA-Line */
//      NOP;
//      NOP;
//      NOP;
//      NOP;
//  I2CDelay();
    res = 0;
    for (i=0;i<8;i++)     // each bit at a time, MSB first
    {
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        I2CSCL = 1;
        res = res << 1;
//      I2CDelay();
//      NOP;
//      NOP;
//      NOP;
//      NOP;
//      NOP;
        if (I2CSDA) res++;
//      I2CDelay();
//      NOP;
//      NOP;
//      NOP;
//      NOP;
//      NOP;
        I2CSCL = 0;
//      I2CDelay();
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
    }
#ifdef I2C_DEBUG_MODE
printf("<G:%02X>",(unsigned int)res);
#endif
    return(res);
}

// ClkSyncByte fclk=100kHz
void I2CClkSyncByte(void)
{
    register unsigned char i;
#ifdef I2C_DEBUG_MODE
printf("<SYNC>");
#endif
    for (i=0; i<8; i++)
    {
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
//      I2CDelay();
        I2CSCL = 1;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
//      I2CDelay();
        I2CSCL = 0;
        NOP;
        NOP;
        NOP;
        NOP;
        NOP;
//      I2CDelay();
    }
}

#endif