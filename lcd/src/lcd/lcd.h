/*
 	Functions for controlling the AV1624 LCD display
	(c) 2004 Jelmer Vernooij <jelmer@samba.org>

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#ifndef __LCD_H__
#define __LCD_H__

void lcd_init(void);
void lcd_puts(const char *name);
void lcd_putc(char);
void lcd_clear(void);
void lcd_cursor(unsigned char pos);
void lcd_displaypower(char on, char showcursor, char blinking);
void lcd_entrymode(char increment, char shift);
void lcd_home(void);
void lcd_setshift(char shift_content, char turn_right);
void lcd_functionset(char twolines, char font5x10);

#endif /* __LCD_H__ */
