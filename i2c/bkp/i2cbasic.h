/*-------------------------------------------------------------------------
  I2C Basic Funtions

   Written By - Dipl.-Ing. (FH) Michael Schmitt
    michael.schmitt@t-online.de

    Initial Version Mai 2000

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

#ifndef __FILE_I2CBASIC_H
#define __FILE_I2CBASIC_H

// Send the I2C start command to the target device
void I2CSendStart( void );
// Send the I2C stop command to the target device
void I2CSendStop( void );
// Send a clock pulse and check SDA for an ACK
// Target will send an ACK as a 1
// If SDA is 0 there is no ACK what means NACK
unsigned char I2CCheckACK( void );
// Send a NACK
void I2CSendNACK( void );
// Send a ACK
void I2CSendACK( void );
// Send a byte to the target
void I2CSendByte(unsigned char SendByte);
// Receive a byte from the target
unsigned char I2CGetByte( void );
// ClkSyncByte, do the garbage collection if bus fault
void I2CClkSyncByte(void);

#endif