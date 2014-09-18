;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Feb  3 2010) (UNIX)
; This file was generated Wed Jun  9 16:31:23 2010
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------

	.ident "SDCC version 2.9.0 #5416 [pic16 port]"
	.file	"hd44780.c"
	list	p=18f452

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _lcd_init
	global _lcd_clear
	global _lcd_home
	global _lcd_emode
	global _lcd_dmode
	global _lcd_cmode
	global _lcd_fmode
	global _lcd_ddram
	global _send_cmd
	global _send_data
	global _lcd_busy

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
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_hd44780__lcd_busy	code
_lcd_busy:
	.line	258; hd44780.c	char lcd_busy(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	.line	264; hd44780.c	LCD_DATA_TRIS = 0xFF;
	MOVLW	0xff
	MOVWF	_TRISD
	.line	266; hd44780.c	LCD_DATA = 0x00;
	CLRF	_PORTD
	.line	270; hd44780.c	LCD_RS = 0;
	BCF	_PORTEbits, 0
	.line	272; hd44780.c	LCD_ENABLE = 1;
	BSF	_PORTEbits, 1
	.line	277; hd44780.c	while(loop < 20){
	CLRF	r0x00
	CLRF	r0x01
_00193_DS_:
	MOVF	r0x01, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00205_DS_
	MOVLW	0x14
	SUBWF	r0x00, W
_00205_DS_:
	BC	_00195_DS_
	.line	278; hd44780.c	loop++;
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BRA	_00193_DS_
_00195_DS_:
	.line	281; hd44780.c	dataval = LCD_DATA;
	MOVFF	_PORTD, r0x00
	.line	283; hd44780.c	LCD_ENABLE = 0;
	BCF	_PORTEbits, 1
	.line	286; hd44780.c	dataval = dataval & 0x80;
	MOVLW	0x80
	ANDWF	r0x00, F
	.line	287; hd44780.c	if(dataval == 0x80){
	MOVF	r0x00, W
	XORLW	0x80
	BNZ	_00197_DS_
	.line	289; hd44780.c	LCD_DATA_TRIS = 0x00;
	CLRF	_TRISD
	.line	290; hd44780.c	return(1);
	MOVLW	0x01
	BRA	_00199_DS_
_00197_DS_:
	.line	295; hd44780.c	LCD_DATA_TRIS = 0x00;
	CLRF	_TRISD
	.line	296; hd44780.c	return(0);
	CLRF	WREG
_00199_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_hd44780__send_data	code
_send_data:
	.line	222; hd44780.c	void send_data(unsigned char dataval)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
_00173_DS_:
	.line	227; hd44780.c	while(lcd_busy() == 1);
	CALL	_lcd_busy
	MOVWF	r0x01
	MOVF	r0x01, W
	XORLW	0x01
	BZ	_00173_DS_
	.line	230; hd44780.c	LCD_DATA_TRIS = 0x00;
	CLRF	_TRISD
	.line	234; hd44780.c	LCD_RS = 1;
	BSF	_PORTEbits, 0
	.line	236; hd44780.c	LCD_DATA = dataval;
	MOVFF	r0x00, _PORTD
	.line	238; hd44780.c	LCD_ENABLE = 1;
	BSF	_PORTEbits, 1
	.line	244; hd44780.c	while(loop < 20){
	CLRF	r0x00
	CLRF	r0x01
_00176_DS_:
	MOVF	r0x01, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00188_DS_
	MOVLW	0x14
	SUBWF	r0x00, W
_00188_DS_:
	BC	_00178_DS_
	.line	245; hd44780.c	loop++;
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BRA	_00176_DS_
_00178_DS_:
	.line	248; hd44780.c	LCD_ENABLE = 0;
	BCF	_PORTEbits, 1
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_hd44780__send_cmd	code
_send_cmd:
	.line	189; hd44780.c	void send_cmd(unsigned char command)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
_00153_DS_:
	.line	194; hd44780.c	while(lcd_busy() == 1);
	CALL	_lcd_busy
	MOVWF	r0x01
	MOVF	r0x01, W
	XORLW	0x01
	BZ	_00153_DS_
	.line	197; hd44780.c	LCD_DATA_TRIS = 0x00;
	CLRF	_TRISD
	.line	201; hd44780.c	LCD_RS = 0;
	BCF	_PORTEbits, 0
	.line	203; hd44780.c	LCD_DATA = command;
	MOVFF	r0x00, _PORTD
	.line	205; hd44780.c	LCD_ENABLE = 1;
	BSF	_PORTEbits, 1
	.line	211; hd44780.c	while(loop < 20){
	CLRF	r0x00
	CLRF	r0x01
_00156_DS_:
	MOVF	r0x01, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00168_DS_
	MOVLW	0x14
	SUBWF	r0x00, W
_00168_DS_:
	BC	_00158_DS_
	.line	212; hd44780.c	loop++;
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BRA	_00156_DS_
_00158_DS_:
	.line	215; hd44780.c	LCD_ENABLE = 0;
	BCF	_PORTEbits, 1
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_hd44780__lcd_ddram	code
_lcd_ddram:
	.line	175; hd44780.c	void lcd_ddram(unsigned char address)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	.line	178; hd44780.c	address = address & 0x7F;
	BCF	r0x00, 7
	.line	180; hd44780.c	address = address | 0x80;
	BSF	r0x00, 7
	.line	182; hd44780.c	send_cmd(address);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_send_cmd
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_hd44780__lcd_fmode	code
_lcd_fmode:
	.line	158; hd44780.c	void lcd_fmode(unsigned char options)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	.line	161; hd44780.c	options = options & 0x1F;
	MOVLW	0x1f
	ANDWF	r0x00, F
	.line	163; hd44780.c	options = options | 0x20;
	BSF	r0x00, 5
	.line	165; hd44780.c	send_cmd(options);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_send_cmd
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_hd44780__lcd_cmode	code
_lcd_cmode:
	.line	138; hd44780.c	void lcd_cmode(unsigned char options)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	.line	141; hd44780.c	options = options & 0x0C;
	MOVLW	0x0c
	ANDWF	r0x00, F
	.line	143; hd44780.c	options = options | 0x10;
	BSF	r0x00, 4
	.line	145; hd44780.c	send_cmd(options);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_send_cmd
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_hd44780__lcd_dmode	code
_lcd_dmode:
	.line	119; hd44780.c	void lcd_dmode(unsigned char options)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	.line	122; hd44780.c	options = options & 0x07;
	MOVLW	0x07
	ANDWF	r0x00, F
	.line	124; hd44780.c	options = options | 0x08;
	BSF	r0x00, 3
	.line	126; hd44780.c	send_cmd(options);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_send_cmd
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_hd44780__lcd_emode	code
_lcd_emode:
	.line	99; hd44780.c	void lcd_emode(unsigned char options)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	.line	102; hd44780.c	options = options & 0x03;
	MOVLW	0x03
	ANDWF	r0x00, F
	.line	104; hd44780.c	options = options | 0x04;
	BSF	r0x00, 2
	.line	106; hd44780.c	send_cmd(options);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_send_cmd
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_hd44780__lcd_home	code
_lcd_home:
	.line	84; hd44780.c	void lcd_home(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	.line	87; hd44780.c	send_cmd(0x02);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_send_cmd
	INCF	FSR1L, F
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_hd44780__lcd_clear	code
_lcd_clear:
	.line	73; hd44780.c	void lcd_clear(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	.line	76; hd44780.c	send_cmd(0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_send_cmd
	INCF	FSR1L, F
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_hd44780__lcd_init	code
_lcd_init:
	.line	32; hd44780.c	void lcd_init(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	.line	38; hd44780.c	LCD_DATA_TRIS = 0x00;
	CLRF	_TRISD
	.line	40; hd44780.c	LCD_DATA = 0x00;
	CLRF	_PORTD
	.line	43; hd44780.c	TRISC = 0xF0;
	MOVLW	0xf0
	MOVWF	_TRISC
	.line	46; hd44780.c	LCD_ENABLE = 0;
	BCF	_PORTEbits, 1
	.line	48; hd44780.c	LCD_RS = 0;
	BCF	_PORTEbits, 0
	.line	52; hd44780.c	while(loop < 9000){
	CLRF	r0x00
	CLRF	r0x01
_00105_DS_:
	MOVLW	0x23
	SUBWF	r0x01, W
	BNZ	_00113_DS_
	MOVLW	0x28
	SUBWF	r0x00, W
_00113_DS_:
	BC	_00107_DS_
	.line	53; hd44780.c	loop++;
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BRA	_00105_DS_
_00107_DS_:
	.line	57; hd44780.c	lcd_clear();
	CALL	_lcd_clear
	.line	60; hd44780.c	lcd_emode(INC_CURSOR);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_lcd_emode
	INCF	FSR1L, F
	.line	63; hd44780.c	lcd_fmode(IFACE_8BIT | DUAL_LINE);
	MOVLW	0x18
	MOVWF	POSTDEC1
	CALL	_lcd_fmode
	INCF	FSR1L, F
	.line	66; hd44780.c	lcd_dmode(DISPLAY_ON);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_lcd_dmode
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  630 (0x0276) bytes ( 0.48%)
;           	  315 (0x013b) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    2 (0x0002) bytes


	end
