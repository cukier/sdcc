/*
 * LCD Demo.
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

#pragma stack 0x200 64

#include <pic18fregs.h>
#include "hd44780.h"

// Set the __CONFIG words:
code char at __CONFIG1H _conf0 = _OSC_HS_1H;
code char at __CONFIG2L _conf1 = _PUT_OFF_2L & _BODEN_OFF_2L;
code char at __CONFIG2H _conf2 = _WDT_OFF_2H;
code char at __CONFIG3H _conf3 = _CCP2MUX_RC1_3H;
code char at __CONFIG4L _conf4 = _LVP_OFF_4L & _STVR_OFF_4L;
code char at __CONFIG5L _conf5 = _CP_0_OFF_5L & _CP_1_OFF_5L & _CP_2_OFF_5L & _CP_3_OFF_5L;
code char at __CONFIG5H _conf6 = _CPD_OFF_5H & _CPB_OFF_5H;
code char at __CONFIG6L _conf7 = _WRT_0_OFF_6L & _WRT_1_OFF_6L & _WRT_2_OFF_6L & _WRT_3_OFF_6L;
code char at __CONFIG6H _conf8 = _WRTD_OFF_6H & _WRTB_OFF_6H & _WRTC_OFF_6H;
code char at __CONFIG7L _conf9 = _EBTR_0_OFF_7L & _EBTR_1_OFF_7L & _EBTR_2_OFF_7L & _EBTR_3_OFF_7L;
code char at __CONFIG7H _conf10 = _EBTRB_OFF_7H;

void main(void) 
{
	unsigned char value;

	lcd_init();

	value = 0;

	while(value < 16) {
		send_data(value+'A');
		value++;
	}

	lcd_ddram(SECOND_LINE);

	value = 0;

	while(value < 16) {
		send_data(value+'a');
		value++;
	}

}
