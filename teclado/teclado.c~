#include <pic18f452.h>

code char at __CONFIG1H CONFIG1H = _OSC_HS_1H;

char varre_botao(void) {

	int cont;

	cont = 0x01;
	while(cont <= 0x08) {
		PORTB = ~cont;
		if(cont == 0x01){
			if(!PORTBbits.RB0)  return '1';
			if(!PORTBbits.RB1)  return '4';
			if(!PORTBbits.RB2)  return '7';
			if(!PORTBbits.RB3)  return '*';
		}
		if(cont == 0x02) {
			if(!PORTBbits.RB0)  return '2';
			if(!PORTBbits.RB1)  return '5';
			if(!PORTBbits.RB2)  return '8';
			if(!PORTBbits.RB3)  return '0';
		}
		if(cont == 0x04){
			if(!PORTBbits.RB0)  return '3';
			if(!PORTBbits.RB1)  return '6';
			if(!PORTBbits.RB2)  return '9';
			if(!PORTBbits.RB3)  return '#';
		}
		if(cont == 0x08) {
			if(!PORTBbits.RB0)  return 'A';
			if(!PORTBbits.RB1)  return 'B';
			if(!PORTBbits.RB2)  return 'C';
			if(!PORTBbits.RB3)  return 'D';
		}
		cont << 1;
	}
	return '';
}

char tecla;

void main(void) {

	TRISB = 0xF0;
	PORTB = 0x0F;
	PORTD = 0x00;

	while(1) {
		tecla = varre_botao();
		if(tecla == '1') PORTDbits.RD0 = 1;
		if(tecla == '2') PORTDbits.RD1 = 1;
		PORTD = 0x00;
   }
