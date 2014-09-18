#include <pic16f876a.h>
#include "m_i2c_1.c"

typedef unsigned int word;
word at 0x2007 CONFIG = _HS_OSC & _WDT_OFF & _PWRTE_OFF & _BODEN_OFF & _LVP_OFF
		& _CPD_OFF & _WRT_OFF & _DEBUG_OFF & _CP_OFF;

#define bto_subir	RB1
#define bto_descer	RB2
#define parar		0x00
#define subir		0x01
#define descer		0x02

unsigned char address[1] = {0x00};

void main(void) {

	TRISB = 0xFF;
	TRISC = 0x00;

	PORTC = 0x00;

	while(1) {
		if(!bto_subir) {
			I2C_Send(address,subir,1);
			PORTC = subir;
		}
		else if(!bto_descer) {
			I2C_Send(address,descer,1);
			PORTC = descer;
		}
		else {
			I2C_Send(address,parar,1);
			PORTC = parar;
		}
	}
}