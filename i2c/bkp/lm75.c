/*-------------------------------------------------------------------------
  I2C Digital Temp.Sensor & Thermal Watchdog

   Written By - Dipl.-Ing. (FH) Michael Schmitt
    michael.schmitt@t-online.de

    Initial Version January 2000

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
/* Function    : I2C Digital Temp.Sensor & Thermal Watchdog    FILE */
/*------------------------------------------------------------------*/
/* Description : LM75 from National can measure temperatures in the */
/*               of -55°C to +125°C by I2C with a resolution of 1°C */
/*------------------------------------------------------------------*/
/* Author      : Michael Schmitt                                    */
/*------------------------------------------------------------------*/
/* Input       : none                                               */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 00/01    V1.0 Initial Version                      */
/*                                                                  */
/********************************************************************/

#ifndef __FILE_LM75_C
#define __FILE_LM75_C

/********************************************************************/
/* Function    : I2CGetTempLM75                                 SUB */
/*------------------------------------------------------------------*/
/* Description : Get the temperature of Device-X                    */
/*------------------------------------------------------------------*/
/* Author      : Michael Schmitt                                    */
/*------------------------------------------------------------------*/
/* Input       : unsigned char DeviceNumber 0..7                    */
/*------------------------------------------------------------------*/
/* Returnvalue : char Temperatur -20..+100                          */
/*------------------------------------------------------------------*/
/* History     : 99/10    V1.0 Initial Version                      */
/*                                                                  */
/********************************************************************/

char I2CGetTempLM75( unsigned char DeviceAdr )
{
    char res;
    WatchDog();

    /* Start I2C */
    I2CSendStart();

    /* Send Device Adr. + Page + WriteCMD */
    I2CSendByte( 0x90 | ((DeviceAdr&0x07)<<1) | 0x01 ); // Send Device Adress 1010 A2/P2 A1/P1 A0/P0 R/W=1(Read)
    if( !I2CCheckACK() )
    {
        goto NO_ACK;
    }

    res = I2CGetByte();

    I2CSendACK();
    I2CClkSyncByte();   // weitere 8 Dummy Bits zum Reset des LM75
    I2CSendACK();

    I2CSendStop();

    return res;

NO_ACK:
    /* OK, if finished or not, make shure i2c is stopped */
    I2CClkSyncByte();   // weitere 8 Dummy Bits zum Reset des LM75
    I2CSendACK();
    I2CSendStop();

    return FALSE;                       // failure exit
}

#endif
