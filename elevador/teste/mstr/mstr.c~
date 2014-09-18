#include <pic16f876a.h>

#define botao_subir RB1
#define botao_descer RB2
#define saida_subir RC0
#define saida_descer RC1

#define geral   0x00
#define parar   0x00
#define subir   0x01
#define descer  0x02
#define I2CSDA RC4
#define I2CSCL RC3

void I2CDelay( void ) {
	_asm
	NOP;
	NOP;
	NOP;
	NOP;
	NOP;
	NOP;
	_endasm;
}

void I2CSendStart( void ) {
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

void I2CSendStop( void ) {
    // Stop Condition SDA 0->1 while SCL is 1
	I2CDelay();
	I2CSDA = 0;
	I2CDelay();
	I2CSCL = 1;
	I2CDelay();
	I2CSDA = 1;
	I2CDelay();
}

void I2CSendByte(unsigned char SendByte) {
	register unsigned char i;

	for (i=0; i<8; i++) {
//      I2CDelay();
		if ( SendByte & 0x80) {
			I2CSDA = 1;        // MSB first -> LSB last
		}
		else {
			I2CSDA = 0;
		}
//      NOP;
//      NOP;
//      NOP;
//      NOP;
		I2CSCL = 1;
        /* doing the shift during clocking, otherwise the pulse width would be
		to short */
		_asm
		NOP;
		NOP;
		NOP;
		NOP;
		NOP;
		NOP;
		NOP;
		_endasm;
		SendByte = SendByte << 1;
//      I2CDelay();
		I2CSCL = 0;
//      I2CDelay();
	}
}

void enviar_i2c(char end_disp, char end_mem, char dado) {
	I2CSendStart();
	I2CSendByte(end_disp);
	I2CSendByte(end_mem);
	I2CSendByte(dado);
	I2CSendStop();
}

void main(void) {
	TRISC = 0x00;
	PORTC = 0x00;

	TRISB = 0xFF;
	PORTB = 0x00;

	while(1) {
		if(!botao_subir) {
			enviar_i2c(geral,0xFF,subir);
			PORTC = subir;
		}
		else if (!botao_descer) {
			enviar_i2c(geral,0xFF,descer);
			PORTC = descer;
		}
		else {
			enviar_i2c(geral,0xFF,parar);
			PORTC = parar;
		}
	}
}