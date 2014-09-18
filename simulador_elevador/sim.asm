;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Feb  3 2010) (UNIX)
; This file was generated Thu Jun 17 13:29:07 2010
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------

	.ident "SDCC version 2.9.0 #5416 [pic16 port]"
	.file	"sim.c"
	list	p=18f452
	__config 0x300001, 0xfa
	__config 0x300002, 0xfd
	__config 0x300003, 0xfe
	__config 0x300005, 0xff
	__config 0x300006, 0xfa
	__config 0x300008, 0xff
	__config 0x300009, 0xff
	__config 0x30000a, 0xff
	__config 0x30000b, 0xff
	__config 0x30000c, 0xff
	__config 0x30000d, 0xff

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _tmr0
	global _TMR0_ISR
	global _delay_ms
	global _main

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern _PORTAbits
	extern _PORTBbits
	extern _PORTCbits
	extern _PORTDbits
	extern _PORTEbits
	extern _LATAbits
	extern _LATBbits
	extern _LATCbits
	extern _LATDbits
	extern _LATEbits
	extern _TRISAbits
	extern _TRISBbits
	extern _TRISCbits
	extern _TRISDbits
	extern _TRISEbits
	extern _PIE1bits
	extern _PIR1bits
	extern _IPR1bits
	extern _PIE2bits
	extern _PIR2bits
	extern _IPR2bits
	extern _EECON1bits
	extern _RCSTAbits
	extern _TXSTAbits
	extern _T3CONbits
	extern _CCP2CONbits
	extern _CCP1CONbits
	extern _ADCON1bits
	extern _ADCON0bits
	extern _SSPCON2bits
	extern _SSPCON1bits
	extern _SSPSTATbits
	extern _T2CONbits
	extern _T1CONbits
	extern _RCONbits
	extern _WDTCONbits
	extern _LVDCONbits
	extern _OSCCONbits
	extern _T0CONbits
	extern _STATUSbits
	extern _INTCON3bits
	extern _INTCON2bits
	extern _INTCONbits
	extern _STKPTRbits
	extern _PORTA
	extern _PORTB
	extern _PORTC
	extern _PORTD
	extern _PORTE
	extern _LATA
	extern _LATB
	extern _LATC
	extern _LATD
	extern _LATE
	extern _TRISA
	extern _TRISB
	extern _TRISC
	extern _TRISD
	extern _TRISE
	extern _PIE1
	extern _PIR1
	extern _IPR1
	extern _PIE2
	extern _PIR2
	extern _IPR2
	extern _EECON1
	extern _EECON2
	extern _EEDATA
	extern _EEADR
	extern _RCSTA
	extern _TXSTA
	extern _TXREG
	extern _RCREG
	extern _SPBRG
	extern _T3CON
	extern _TMR3L
	extern _TMR3H
	extern _CCP2CON
	extern _CCPR2L
	extern _CCPR2H
	extern _CCP1CON
	extern _CCPR1L
	extern _CCPR1H
	extern _ADCON1
	extern _ADCON0
	extern _ADRESL
	extern _ADRESH
	extern _SSPCON2
	extern _SSPCON1
	extern _SSPSTAT
	extern _SSPADD
	extern _SSPBUF
	extern _T2CON
	extern _PR2
	extern _TMR2
	extern _T1CON
	extern _TMR1L
	extern _TMR1H
	extern _RCON
	extern _WDTCON
	extern _LVDCON
	extern _OSCCON
	extern _T0CON
	extern _TMR0L
	extern _TMR0H
	extern _STATUS
	extern _FSR2L
	extern _FSR2H
	extern _PLUSW2
	extern _PREINC2
	extern _POSTDEC2
	extern _POSTINC2
	extern _INDF2
	extern _BSR
	extern _FSR1L
	extern _FSR1H
	extern _PLUSW1
	extern _PREINC1
	extern _POSTDEC1
	extern _POSTINC1
	extern _INDF1
	extern _WREG
	extern _FSR0L
	extern _FSR0H
	extern _PLUSW0
	extern _PREINC0
	extern _POSTDEC0
	extern _POSTINC0
	extern _INDF0
	extern _INTCON3
	extern _INTCON2
	extern _INTCON
	extern _PRODL
	extern _PRODH
	extern _TABLAT
	extern _TBLPTRL
	extern _TBLPTRH
	extern _TBLPTRU
	extern _PCL
	extern _PCLATH
	extern _PCLATU
	extern _STKPTR
	extern _TOSL
	extern _TOSH
	extern _TOSU
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
BSR	equ	0xfe0
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1

udata_sim_0	udata
_tmr0	res	2

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block for absolute section
; ;-----------------------------------------
S_sim_ivec_0x1_TMR0_ISR	code	0X000008
ivec_0x1_TMR0_ISR:
	GOTO	_TMR0_ISR

; I code from now on!
; ; Starting pCode block
S_sim__main	code
_main:
	.line	36; sim.c	TRISB = 0xF0;
	MOVLW	0xf0
	MOVWF	_TRISB
	.line	37; sim.c	PORTB = 0x0F;
	MOVLW	0x0f
	MOVWF	_PORTB
	.line	38; sim.c	TRISD = 0x00;
	CLRF	_TRISD
	.line	39; sim.c	PORTD = 0x00;
	CLRF	_PORTD
	.line	41; sim.c	INTCONbits.GIE = 1;				//Habilita Interrupções Golbais
	BSF	_INTCONbits, 7
	.line	42; sim.c	INTCONbits.TMR0IE = 1;			//Habilita Interrupção TMR0
	BSF	_INTCONbits, 5
	.line	44; sim.c	T0CONbits.TMR0ON = 0;			//TMR0 Parado
	BCF	_T0CONbits, 7
	.line	45; sim.c	T0CONbits.T08BIT = 1;			//Configurado p/ 16 bits
	BSF	_T0CONbits, 6
	.line	46; sim.c	T0CONbits.T0CS = 0;				//Seleciona fonte interna p/ TMR0
	BCF	_T0CONbits, 5
	.line	47; sim.c	T0CONbits.PSA = 0;				//Seleciona Prescale p/ TMR0
	BCF	_T0CONbits, 3
	.line	48; sim.c	T0CONbits.T0PS2 = 0;			//prescale em 1:8 p/ estourar a cada
	BCF	_T0CONbits, 2
	.line	49; sim.c	T0CONbits.T0PS1 = 1;			//	1.024mS @ 8MHz
	BSF	_T0CONbits, 1
	.line	50; sim.c	T0CONbits.T0PS0 = 0;
	BCF	_T0CONbits, 0
_00121_DS_:
	.line	55; sim.c	if(PORTBbits.RB4)	{
	BTFSS	_PORTBbits, 4
	BRA	_00121_DS_
	.line	56; sim.c	PORTD++;
	INCF	_PORTD, F
	.line	57; sim.c	delay_ms(300);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x2c
	MOVWF	POSTDEC1
	CALL	_delay_ms
	MOVLW	0x02
	ADDWF	FSR1L, F
	BRA	_00121_DS_
	RETURN	

; ; Starting pCode block
S_sim__delay_ms	code
_delay_ms:
	.line	26; sim.c	void delay_ms(unsigned int ms) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	.line	28; sim.c	T0CONbits.TMR0ON = 1;			//Linga o Contador TMR0
	BSF	_T0CONbits, 7
	.line	29; sim.c	tmr0 = ms;
	MOVFF	r0x00, _tmr0
	MOVFF	r0x01, (_tmr0 + 1)
_00110_DS_:
	BANKSEL	_tmr0
	.line	30; sim.c	while(tmr0);
	MOVF	_tmr0, W, B
	BANKSEL	(_tmr0 + 1)
	IORWF	(_tmr0 + 1), W, B
	BNZ	_00110_DS_
	.line	31; sim.c	T0CONbits.TMR0ON = 0;			//Desliga o Contador
	BCF	_T0CONbits, 7
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_sim__TMR0_ISR	code
_TMR0_ISR:
	.line	21; sim.c	void TMR0_ISR(void) interrupt 1 {
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	.line	22; sim.c	INTCONbits.TMR0IF = 0;
	BCF	_INTCONbits, 2
	.line	23; sim.c	tmr0--;
	MOVLW	0xff
	BANKSEL	_tmr0
	ADDWF	_tmr0, F, B
	BC	_10118_DS_
	BANKSEL	(_tmr0 + 1)
	DECF	(_tmr0 + 1), F, B
_10118_DS_:
	MOVFF	PREINC1, FSR2L
	MOVFF	PREINC1, PCLATU
	MOVFF	PREINC1, PCLATH
	MOVFF	PREINC1, FSR0H
	MOVFF	PREINC1, FSR0L
	MOVFF	PREINC1, PRODH
	MOVFF	PREINC1, PRODL
	MOVFF	PREINC1, BSR
	MOVFF	PREINC1, STATUS
	MOVFF	PREINC1, WREG
	RETFIE	



; Statistics:
; code size:	  222 (0x00de) bytes ( 0.17%)
;           	  111 (0x006f) words
; udata size:	    2 (0x0002) bytes ( 0.16%)
; access size:	    2 (0x0002) bytes


	end
