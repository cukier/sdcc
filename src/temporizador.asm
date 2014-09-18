;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Feb  3 2010) (UNIX)
; This file was generated Tue Jun 15 13:49:17 2010
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------

	.ident "SDCC version 2.9.0 #5416 [pic16 port]"
	.file	"temporizador.c"
	list	p=18f452
	__config 0x300001, 0xfa

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
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
PRODL	equ	0xff3
PRODH	equ	0xff4

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block for absolute section
; ;-----------------------------------------
S_temporizador_ivec_0x0_isr	code	0X000000
ivec_0x0_isr:
	GOTO	_isr

; I code from now on!
; ; Starting pCode block
S_temporizador__main	code
_main:
	.line	13; temporizador.c	INTCONbits.GIE = 1;			//Habilita Interrupção geral
	BSF	_INTCONbits, 7
	.line	15; temporizador.c	INTCONbits.TMR0IE = 1;		//Habilita Interrupção TMR0
	BSF	_INTCONbits, 5
	.line	17; temporizador.c	T0CONbits.TMR0ON = 1;		//Liga Interrupção TMR0
	BSF	_T0CONbits, 7
	.line	18; temporizador.c	T0CONbits.T08BIT = 0;		//Seta o contador em 16bits 0xFFFF --> 0x0000
	BCF	_T0CONbits, 6
	.line	19; temporizador.c	T0CONbits.PSA = 0;			//Designa o prescaler p/ TMR0
	BCF	_T0CONbits, 3
	.line	20; temporizador.c	T0CONbits.T0PS2 = 0;		//**
	BCF	_T0CONbits, 2
	.line	21; temporizador.c	T0CONbits.T0PS1 = 0;		//*****Seta o prescaler p/ disparar a cada 1mS
	BCF	_T0CONbits, 1
	.line	22; temporizador.c	T0CONbits.T0PS0 = 1;		//**
	BSF	_T0CONbits, 0
	.line	24; temporizador.c	TRISD = 0x00;
	CLRF	_TRISD
	.line	25; temporizador.c	PORTD = 0x00;
	CLRF	_PORTD
_00118_DS_:
	.line	27; temporizador.c	while(1) { }
	BRA	_00118_DS_
	RETURN	

; ; Starting pCode block
S_temporizador__isr	code
_isr:
	.line	5; temporizador.c	static void isr(void) interrupt 0 {
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
	.line	6; temporizador.c	if (PORTD == 0xFF) PORTD = 0x00;
	MOVF	_PORTD, W
	XORLW	0xff
	BNZ	_00106_DS_
	CLRF	_PORTD
	BRA	_00107_DS_
_00106_DS_:
	.line	7; temporizador.c	else PORTD++;
	INCF	_PORTD, F
_00107_DS_:
	.line	8; temporizador.c	INTCONbits.TMR0IF = 0;
	BCF	_INTCONbits, 2
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
; code size:	  126 (0x007e) bytes ( 0.10%)
;           	   63 (0x003f) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    0 (0x0000) bytes


	end
