/*
 * LCD Library.
 *
 * written by Martyn Welch, 2005 <martyn AT warpedlogic.co.uk>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 * 
*/

/*
* Routines for Hitachi HD44780 based and compatible displays
*/

#include <pic18fregs.h>
#include "hd44780.h"

/**
 * lcd_init(void) - Initialise Display
 */
void lcd_init(void)
{

	unsigned int loop;
	
	// Set data bus as output
	LCD_DATA_TRIS = 0x00;
	// Initialise data bus
	LCD_DATA = 0x00;
	
	// Set control lines as output
	TRISE = 0xF0;

	// Set all conrol lines to 0;
	LCD_ENABLE = 0;
//	LCD_RW = 0;
	LCD_RS = 0;
	
	// Wait for more than 30ms
	loop = 0;
	while(loop < 9000){
		loop++;
	}

	// Clear LCD
	lcd_clear();
	
	// Set entry mode
	lcd_emode(INC_CURSOR);

	// Select Function Set
	lcd_fmode(IFACE_8BIT | DUAL_LINE);
	
	// Configure display mode
	lcd_dmode(DISPLAY_ON);
}

/**
 * lcd_clear() - Clear the LCD Display and return cursor to home position
 *
 */
void lcd_clear(void)
{
	// Send the command
	send_cmd(0x01);

}

/**
 * lcd_home() - Return cursor to home position (contents of diaplay unchanged)
 *
 */
void lcd_home(void)
{
	// Send the command
	send_cmd(0x02);
}

/**
 * set_emode(options) - Set entry mode
 *
 * Options:
 *
 *  INC_CURSOR - Incremnt cursor after character written
 *  DEC_CURSOR - Decrement cursor after character written
 *  SHIFT_ON - Switch Cursor shifting on
 */
void lcd_emode(unsigned char options)
{
	// Ensure that only valid range of bits set
	options = options & 0x03;
	// Set display command bit
	options = options | 0x04;
	// Send the command
	send_cmd(options);
}

/**
 * set_dmode(options) - Configure display mode
 *
 * Options:
 *
 *  DISPLAY_ON - Turn Display on
 *  DISPLAY_OFF - Turn Display off
 *  CURSOR_ON  - Turn Cursor on
 *  BLINK_ON - Blink Cursor
 */
void lcd_dmode(unsigned char options)
{
	// Ensure that only valid range of bits set
	options = options & 0x07;
	// Set display command bit
	options = options | 0x08;
	// Send the command
	send_cmd(options);
}

/**
 * set_cmode(options) - Configure cursor mode
 *
 * Options:
 *
 *  SHIFT_DISP - Shift Display
 *  SHIFT_RIGHT - Move cursor right
 *  SHIFT_LEFT - Move cursor left
 */
void lcd_cmode(unsigned char options)
{
	// Ensure that only valid range of bits set
	options = options & 0x0C;
	// Set display command bit
	options = options | 0x10;
	// Send the command
	send_cmd(options);
}

/**
 * set_fmode(options) - Configure function set
 *
 * Options:
 *
 *  4BIT_IFACE - 4-bit interface
 *  8BIT_IFACE - 8-bit interface
 *  1_16_DUTY - 1/16 duty 
 *  5X10_DOTS - 5x10 dot characters
 */
void lcd_fmode(unsigned char options)
{
	// Ensure that only valid range of bits set
	options = options & 0x1F;
	// Set display command bit
	options = options | 0x20;
	// Send the command
	send_cmd(options);
}

/**
 * set_ddram(address) - Set DDRAM address
 *
 * Options:
 *
 *  address - 7-bit address
 */
void lcd_ddram(unsigned char address)
{
	// Ensure that only valid range of bits set
	address = address & 0x7F;
	// Set DDRAM bit
	address = address | 0x80;
	// Send the command
	send_cmd(address);
}

/**
 * send_cmd(unsigned char) - Send command
 *
 */
void send_cmd(unsigned char command)
{
	int loop;

	// Wait for LCD to be ready
	while(lcd_busy() == 1);
	
	// Set data bus as output
	LCD_DATA_TRIS = 0x00;
	// Set directon control line to write
	LCD_RW = 0;
	// Clear command/data flag (command)
	LCD_RS = 0;
	//Put command on data bus
	LCD_DATA = command;
	// Raise Enable Line
	LCD_ENABLE = 1;
	//NOTE: Enable Lime must be up for atleast 450ns!
	//NOTE: Data must be valid after 320ns from LCD_ENABLE rising
	
	//Short pause
	loop = 0;
	while(loop < 20){
		loop++;
	}
	// Lower Enable Line
	LCD_ENABLE = 0;
}

/**
 * send_data(unsigned char) - Send data
 *
 */
void send_data(unsigned char dataval)
{
	int loop;

	// Wait for LCD to be ready
	while(lcd_busy() == 1);

	// Set data bus as output
	LCD_DATA_TRIS = 0x00;
	// Set directon control line to write
//	LCD_RW = 0;
	// Set command/data flag (data)
	LCD_RS = 1;
	//Put command on data bus
	LCD_DATA = dataval;
	// Raise Enable Line
	LCD_ENABLE = 1;
	//NOTE: Enable Lime must be up for atleast 450ns!
	//NOTE: Data must be valid after 320ns from LCD_ENABLE rising
	
	//Short pause
	loop = 0;
	while(loop < 20){
		loop++;
	}
	// Lower Enable Line
	LCD_ENABLE = 0;
}

/**
 * lcd_busy(void) - Check to see if LCD is ready
 *
 * Return:
 *  0 - Ready
 *  1 - Busy
 */
char lcd_busy(void)
{
	int loop;
	unsigned char dataval;

	// Set data bus as input
	LCD_DATA_TRIS = 0xFF;
	// Initialise data bus
	LCD_DATA = 0x00;
	// Set directon control line to write
//	LCD_RW = 1;
	// Set command/data flag (command)
	LCD_RS = 0;
	// Raise Enable Line
	LCD_ENABLE = 1;
	//NOTE: Enable Lime must be up for atleast 450ns!
	//NOTE: Data must be valid after 320ns from LCD_ENABLE rising
	//Short pause
	loop = 0;
	while(loop < 20){
		loop++;
	}
	// Read data bus
	dataval = LCD_DATA;
	// Lower Enable Line
	LCD_ENABLE = 0;

	// Mask all but busy flag
	dataval = dataval & 0x80;
	if(dataval == 0x80){
		// Set data bus as output
		LCD_DATA_TRIS = 0x00;
		return(1);
	}
	else
	{
		// Set data bus as output
		LCD_DATA_TRIS = 0x00;
		return(0);
	}

}

