#include <pic16f876a.h>

typedef unsigned int word;
word at 0x2007 CONFIG = _HS_OSC & _WDT_OFF & _PWRTE_OFF & _BODEN_OFF & _LVP_OFF
		& _CPD_OFF & _WRT_OFF & _DEBUG_OFF & _CP_OFF;

void TMR0_ISR(void) interrupt 0 {
	PORTB++;
	TMR0IF = 0;
}

void main(void) {

	TRISB = 0x00;
	PORTB = 0x00;

	//CMCON = 0x07;

	GIE = 1;
	TMR0IE = 1;

	T0CS = 0;
	PSA = 0;
	PS2 = 1;
	PS1 = 1;
	PS0 = 1;

	TMR0 = 0;
	TMR0IF = 0;

	while(1) { }
}