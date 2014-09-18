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
* Header file for HITACHI HD44780 based and compatible displays
*/

#define LCD_DATA PORTD
#define LCD_DATA_TRIS TRISD
#define LCD_ENABLE PORTEbits.RE1
//#define LCD_RW PORTCbits.RC1
#define LCD_RS PORTEbits.RE0

//Entry mode variables
#define INC_CURSOR 0x02
#define DEC_CURSOR 0x00
#define SHIFT_ON 0x01

//Display control variables
#define DISPLAY_ON 0x04
#define DISPLAY_OFF 0x00
#define CURSOR_ON 0x02
#define BLINK_ON 0x01

//Cursor move variables
#define SHIFT_DISP 0x08
#define SHIFT_RIGHT 0x04
#define SHIFT_LEFT 0x00

//Function set variables
#define IFACE_4BIT 0x00
#define IFACE_8BIT 0x10
#define DUAL_LINE 0x08
#define DOTS_5X11 0x04

//DDRAM locations
#define FIRST_LINE 0x00
#define SECOND_LINE 0x40

//Prototypes
void lcd_init(void);

void lcd_clear(void);
void lcd_home(void);
void lcd_emode(unsigned char);
void lcd_dmode(unsigned char);
void lcd_cmode(unsigned char);
void lcd_fmode(unsigned char);
void lcd_ddram(unsigned char);

void send_cmd(unsigned char);
void send_data(unsigned char);

char lcd_busy(void);
