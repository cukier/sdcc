#include <pic18f452.h>

code char at __CONFIG1H CONFIG1H = _OSC_HS_1H & _OSCS_OFF_1H;
code char at __CONFIG2L CONFIG2L = _PUT_OFF_2L & _BODEN_OFF_2L &
		_BODENV_2_0V_2L;
code char at __CONFIG2H CONFIG2H = _WDT_OFF_2H & _WDTPS_1_128_2H;
code char at __CONFIG3H CONFIG3H = _CCP2MUX_RC1_3H;
code char at __CONFIG4L CONFIG4L = _STVR_OFF_4L & _LVP_OFF_4L & _BACKBUG_OFF_4L;
code char at __CONFIG5L CONFIG5L = _CP_0_OFF_5L & _CP_1_OFF_5L & _CP_2_OFF_5L &
		_CP_3_OFF_5L;
code char at __CONFIG5H CONFIG5H = _CPB_OFF_5H & _CPD_OFF_5H;
code char at __CONFIG6L CONFIG6L = _WRT_0_OFF_6L & _WRT_1_OFF_6L & _WRT_2_OFF_6L
		& _WRT_3_OFF_6L;
code char at __CONFIG6H CONFIG6H = _WRTC_OFF_6H & _WRTB_OFF_6H & _WRTD_OFF_6H;
code char at __CONFIG7L CONFIG7L = _EBTR_0_OFF_7L & _EBTR_1_OFF_7L &
		_EBTR_2_OFF_7L & _EBTR_3_OFF_7L;
code char at __CONFIG7H CONFIG7H = _EBTRB_OFF_7H;

unsigned int tmr0;

void TMR0_ISR(void) interrupt 1 {
	INTCONbits.TMR0IF = 0;
	tmr0--;
}

void delay_ms(unsigned int ms) {
	
	T0CONbits.TMR0ON = 1;			//Linga o Contador TMR0
	tmr0 = ms;
	while(tmr0);
	T0CONbits.TMR0ON = 0;			//Desliga o Contador
}

void main(void) {

	TRISB = 0xF0;
	PORTB = 0x0F;
	TRISD = 0x00;
	PORTD = 0x00;

	INTCONbits.GIE = 1;				//Habilita Interrupções Golbais
	INTCONbits.TMR0IE = 1;			//Habilita Interrupção TMR0

	T0CONbits.TMR0ON = 0;			//TMR0 Parado
	T0CONbits.T08BIT = 0;			//Configurado p/ 8 bits
	T0CONbits.T0CS = 0;				//Seleciona fonte interna p/ TMR0
	T0CONbits.PSA = 0;				//Seleciona Prescale p/ TMR0
	T0CONbits.T0PS2 = 0;			//prescale em 1:8 p/ estourar a cada
	T0CONbits.T0PS1 = 1;			//	1.024mS @ 8MHz
	T0CONbits.T0PS0 = 0;


	while(1) {

		if(PORTBbits.RB4)	{
			PORTD++;
			delay_ms(300);
		}

	}
}
