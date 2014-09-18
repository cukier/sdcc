#include <pic18f452.h>

code char at __CONFIG1H CONFIG1H = _OSC_HS_1H;

static void isr(void) interrupt 0 {
	if (PORTD == 0xFF) PORTD = 0x00;
	else PORTD++;
	INTCONbits.TMR0IF = 0;
}

void main(void) {

	INTCONbits.GIE = 1;			//Habilita Interrupção geral
	//INTCONbits.PEIE = 1;		//Habilita Interrupção Periférica
	INTCONbits.TMR0IE = 1;		//Habilita Interrupção TMR0

	T0CONbits.TMR0ON = 1;		//Liga Interrupção TMR0
	T0CONbits.T08BIT = 0;		//Seta o contador em 16bits 0xFFFF --> 0x0000
	T0CONbits.PSA = 0;			//Designa o prescaler p/ TMR0
	T0CONbits.T0PS2 = 0;		//**
	T0CONbits.T0PS1 = 0;		//*****Seta o prescaler p/ disparar a cada 1mS
	T0CONbits.T0PS0 = 1;		//**

	TRISD = 0x00;
	PORTD = 0x00;

	while(1) { }
}