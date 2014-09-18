/*
 	Example program for writing data to the AV1624 LCD display
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

#include <pic16f876a.h>
#include "lcd.h"

void main(void) {
	lcd_init();
	lcd_functionset(1, 0);
	lcd_displaypower(1, 1, 0);
	lcd_clear();
	lcd_entrymode(1, 0);
	lcd_puts("foobar");
	lcd_cursor(64);
	lcd_putc('a');
	while(1);
}
