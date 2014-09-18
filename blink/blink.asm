;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Feb  3 2010) (UNIX)
; This file was generated Tue Jul  6 10:11:41 2010
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------

	.ident "SDCC version 2.9.0 #5416 [pic16 port]"
	.file	"blink.c"
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
	global _i
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

udata_blink_0	udata
_i	res	2

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_blink__main	code
_main:
	.line	32; blink.c	TRISD = 0x00;
	CLRF	_TRISD
	.line	33; blink.c	PORTD = 0x00;
	CLRF	_PORTD
_00109_DS_:
	.line	36; blink.c	i = 1200;
	MOVLW	0xb0
	BANKSEL	_i
	MOVWF	_i, B
	MOVLW	0x04
	BANKSEL	(_i + 1)
	MOVWF	(_i + 1), B
_00105_DS_:
	BANKSEL	_i
	.line	37; blink.c	while(i) i--;
	MOVF	_i, W, B
	BANKSEL	(_i + 1)
	IORWF	(_i + 1), W, B
	BZ	_00107_DS_
	MOVLW	0xff
	BANKSEL	_i
	ADDWF	_i, F, B
	BC	_10105_DS_
	BANKSEL	(_i + 1)
	DECF	(_i + 1), F, B
_10105_DS_:
	BRA	_00105_DS_
_00107_DS_:
	.line	39; blink.c	PORTD++;
	INCF	_PORTD, F
	BRA	_00109_DS_
	RETURN	



; Statistics:
; code size:	   46 (0x002e) bytes ( 0.04%)
;           	   23 (0x0017) words
; udata size:	    2 (0x0002) bytes ( 0.16%)
; access size:	    0 (0x0000) bytes


	end
