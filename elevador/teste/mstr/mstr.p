pcode dump


	New pBlock

internal pblock, dbName =M
;; Starting pCode block
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2283:genFunction *{*
;; ***	genFunction  2285 curr label offset=28previous max_key=0 
_main	;Function start
; 2 exit points
;; gen.c:2261:resultRemat *{*
;; gen.c:6332:genAssign *{*
;; ***	genAssign  6333
;; ***	aopForSym 350
;;	361 sym->rname = _TRISC, size = 1
;; 	line = 6342 result AOP_DIR=_TRISC, size=1, left -=-, size=0, right AOP_LIT=0x00, size=1
;; ***	genAssign  6434
; >>> gen.c:6443:genAssign
;;	1013
;;	1029  _TRISC   offset=0
	.line	93; "mstr.c"	TRISC = 0x00;
	CLRF	_TRISC
;; gen.c:2261:resultRemat *{*
;; gen.c:6332:genAssign *{*
;; ***	genAssign  6333
;; ***	aopForSym 350
;;	361 sym->rname = _PORTC, size = 1
;; 	line = 6342 result AOP_DIR=_PORTC, size=1, left -=-, size=0, right AOP_LIT=0x00, size=1
;; ***	genAssign  6434
; >>> gen.c:6443:genAssign
;;	1013
;;	1029  _PORTC   offset=0
	.line	94; "mstr.c"	PORTC = 0x00;
	CLRF	_PORTC
;; gen.c:2261:resultRemat *{*
;; gen.c:6332:genAssign *{*
;; ***	genAssign  6333
;; ***	aopForSym 350
;;	361 sym->rname = _TRISB, size = 1
;; 	line = 6342 result AOP_DIR=_TRISB, size=1, left -=-, size=0, right AOP_LIT=0xff, size=1
;; ***	genAssign  6434
; >>> gen.c:6439:genAssign
	.line	96; "mstr.c"	TRISB = 0xFF;
	MOVLW	0xff
; >>> gen.c:6441:genAssign
;;	1013
;;	1029  _TRISB   offset=0
	MOVWF	_TRISB
;; gen.c:2261:resultRemat *{*
;; gen.c:6332:genAssign *{*
;; ***	genAssign  6333
;; ***	aopForSym 350
;;	361 sym->rname = _PORTB, size = 1
;; 	line = 6342 result AOP_DIR=_PORTB, size=1, left -=-, size=0, right AOP_LIT=0x00, size=1
;; ***	genAssign  6434
; >>> gen.c:6443:genAssign
;;	1013
;;	1029  _PORTB   offset=0
	.line	97; "mstr.c"	PORTB = 0x00;
	CLRF	_PORTB
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:5608:genPointerGet *{*
;; ***	genPointerGet  5609
;; gen.c:5397:genNearPointerGet *{*
;; ***	genNearPointerGet  5398
;;	641
;;	aopForRemat 425
;;	446: rname _PORTB_bits, val 0, const = 0
;; ***	genNearPointerGet  5414
;;	721 register type nRegs=1
;; gen.c:3504:ifxForOp *{*
;; ***	ifxForOp  3506
;; gen.c:5240:genUnpackBits *{*
;; ***	genUnpackBits  5241
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTB_bits
; >>> gen.c:5257:genUnpackBits
_00140_DS_
	.line	100; "mstr.c"	if(!botao_subir) {
	BTFSC	_PORTB_bits,1
; >>> gen.c:5258:genUnpackBits
;; ***	popGetLabel  key=5, label offset 32
	GOTO	_00137_DS_
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
;; 	2079 left AOP_LIT
;; gen.c:1324:mov2w_op *{*
; >>> gen.c:1339:mov2w_op
	.line	101; "mstr.c"	enviar_i2c(geral,0xFF,subir);
	MOVLW	0x01
;; 	2079 left AOP_LIT
; >>> gen.c:2087:genCall
;; ***	popRegFromIdx,1043  , rIdx=0x7e
	MOVWF	STK01
;; gen.c:1324:mov2w_op *{*
; >>> gen.c:1339:mov2w_op
	MOVLW	0xff
;; 	2079 left AOP_LIT
; >>> gen.c:2087:genCall
;; ***	popRegFromIdx,1043  , rIdx=0x7f
	MOVWF	STK00
;; gen.c:1324:mov2w_op *{*
; >>> gen.c:1339:mov2w_op
	MOVLW	0x00
; >>> gen.c:2118:genCall
	CALL	_enviar_i2c
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:6332:genAssign *{*
;; ***	genAssign  6333
;; ***	aopForSym 350
;;	361 sym->rname = _PORTC, size = 1
;; 	line = 6342 result AOP_DIR=_PORTC, size=1, left -=-, size=0, right AOP_LIT=0x01, size=1
;; ***	genAssign  6434
; >>> gen.c:6439:genAssign
	.line	102; "mstr.c"	PORTC = subir;
	MOVLW	0x01
; >>> gen.c:6441:genAssign
;;	1013
;;	1029  _PORTC   offset=0
	MOVWF	_PORTC
;; gen.c:2261:resultRemat *{*
;; gen.c:2614:genGoto *{*
; >>> gen.c:2616:genGoto
;; ***	popGetLabel  key=8, label offset 32
	GOTO	_00140_DS_
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:5608:genPointerGet *{*
;; ***	genPointerGet  5609
;; gen.c:5397:genNearPointerGet *{*
;; ***	genNearPointerGet  5398
;;	641
;;	aopForRemat 425
;;	446: rname _PORTB_bits, val 0, const = 0
;; ***	genNearPointerGet  5414
;;	721 register type nRegs=1
;; gen.c:3504:ifxForOp *{*
;; ***	ifxForOp  3506
;; gen.c:5240:genUnpackBits *{*
;; ***	genUnpackBits  5241
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTB_bits
; >>> gen.c:5257:genUnpackBits
_00137_DS_
	.line	104; "mstr.c"	else if (!botao_descer) {
	BTFSC	_PORTB_bits,2
; >>> gen.c:5258:genUnpackBits
;; ***	popGetLabel  key=2, label offset 32
	GOTO	_00134_DS_
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
;; 	2079 left AOP_LIT
;; gen.c:1324:mov2w_op *{*
; >>> gen.c:1339:mov2w_op
	.line	105; "mstr.c"	enviar_i2c(geral,0xFF,descer);
	MOVLW	0x02
;; 	2079 left AOP_LIT
; >>> gen.c:2087:genCall
;; ***	popRegFromIdx,1043  , rIdx=0x7e
	MOVWF	STK01
;; gen.c:1324:mov2w_op *{*
; >>> gen.c:1339:mov2w_op
	MOVLW	0xff
;; 	2079 left AOP_LIT
; >>> gen.c:2087:genCall
;; ***	popRegFromIdx,1043  , rIdx=0x7f
	MOVWF	STK00
;; gen.c:1324:mov2w_op *{*
; >>> gen.c:1339:mov2w_op
	MOVLW	0x00
; >>> gen.c:2118:genCall
	CALL	_enviar_i2c
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:6332:genAssign *{*
;; ***	genAssign  6333
;; ***	aopForSym 350
;;	361 sym->rname = _PORTC, size = 1
;; 	line = 6342 result AOP_DIR=_PORTC, size=1, left -=-, size=0, right AOP_LIT=0x02, size=1
;; ***	genAssign  6434
; >>> gen.c:6439:genAssign
	.line	106; "mstr.c"	PORTC = descer;
	MOVLW	0x02
; >>> gen.c:6441:genAssign
;;	1013
;;	1029  _PORTC   offset=0
	MOVWF	_PORTC
;; gen.c:2261:resultRemat *{*
;; gen.c:2614:genGoto *{*
; >>> gen.c:2616:genGoto
;; ***	popGetLabel  key=8, label offset 32
	GOTO	_00140_DS_
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
;; 	2079 left AOP_LIT
;; gen.c:1324:mov2w_op *{*
; >>> gen.c:1339:mov2w_op
_00134_DS_
	.line	109; "mstr.c"	enviar_i2c(geral,0xFF,parar);
	MOVLW	0x00
;; 	2079 left AOP_LIT
; >>> gen.c:2087:genCall
;; ***	popRegFromIdx,1043  , rIdx=0x7e
	MOVWF	STK01
;; gen.c:1324:mov2w_op *{*
; >>> gen.c:1339:mov2w_op
	MOVLW	0xff
;; 	2079 left AOP_LIT
; >>> gen.c:2087:genCall
;; ***	popRegFromIdx,1043  , rIdx=0x7f
	MOVWF	STK00
;; gen.c:1324:mov2w_op *{*
; >>> gen.c:1339:mov2w_op
	MOVLW	0x00
; >>> gen.c:2118:genCall
	CALL	_enviar_i2c
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:6332:genAssign *{*
;; ***	genAssign  6333
;; ***	aopForSym 350
;;	361 sym->rname = _PORTC, size = 1
;; 	line = 6342 result AOP_DIR=_PORTC, size=1, left -=-, size=0, right AOP_LIT=0x00, size=1
;; ***	genAssign  6434
; >>> gen.c:6443:genAssign
;;	1013
;;	1029  _PORTC   offset=0
	.line	110; "mstr.c"	PORTC = parar;
	CLRF	_PORTC
;; gen.c:2261:resultRemat *{*
;; gen.c:2614:genGoto *{*
; >>> gen.c:2616:genGoto
;; ***	popGetLabel  key=8, label offset 32
	GOTO	_00140_DS_
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2435:genEndFunction *{*
;; ***	genEndFunction  2437
	RETURN	
; exit point of _main

	New pBlock

code, dbName =C
;; Starting pCode block
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2283:genFunction *{*
;; ***	genFunction  2285 curr label offset=16previous max_key=8 
_enviar_i2c	;Function start
; 2 exit points
;; gen.c:2261:resultRemat *{*
;; gen.c:6739:genReceive *{*
;; ***	genReceive  6740
;;	721 register type nRegs=1
;; gen.c:1866:assignResultValue *{*
;; ***	assignResultValue  1868
;; 	line = 1870 result -=-, size=0, left AOP_REG=r0x104A, size=1, right -=-, size=0
; >>> gen.c:1367:movwf
;;	1109 rIdx = r0x104A 
	.line	84; "mstr.c"	void enviar_i2c(char end_disp, char end_mem, char dado) {
	MOVWF	r0x1002
;; gen.c:2261:resultRemat *{*
;; gen.c:6739:genReceive *{*
;; ***	genReceive  6740
;;	721 register type nRegs=1
;; gen.c:1866:assignResultValue *{*
;; ***	assignResultValue  1868
;; 	line = 1870 result -=-, size=0, left AOP_REG=r0x104B, size=1, right -=-, size=0
; >>> gen.c:1393:get_returnvalue
;; ***	popRegFromIdx,1043  , rIdx=0x7f
	MOVF	STK00,W
; >>> gen.c:1367:movwf
;;	1109 rIdx = r0x104B 
	MOVWF	r0x1003
;; gen.c:2261:resultRemat *{*
;; gen.c:6739:genReceive *{*
;; ***	genReceive  6740
;;	721 register type nRegs=1
;; gen.c:1866:assignResultValue *{*
;; ***	assignResultValue  1868
;; 	line = 1870 result -=-, size=0, left AOP_REG=r0x104C, size=1, right -=-, size=0
; >>> gen.c:1393:get_returnvalue
;; ***	popRegFromIdx,1043  , rIdx=0x7e
	MOVF	STK01,W
; >>> gen.c:1367:movwf
;;	1109 rIdx = r0x104C 
	MOVWF	r0x1004
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
; >>> gen.c:2118:genCall
	.line	85; "mstr.c"	I2CSendStart();
	CALL	_I2CSendStart
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
;;	721 register type nRegs=1
;;	721 register type nRegs=1
;; 	2079 left AOP_REG
;; gen.c:1324:mov2w_op *{*
;; ***	mov2w  1356  offset=0
; >>> gen.c:1361:mov2w
;;	1109 rIdx = r0x104A 
	.line	86; "mstr.c"	I2CSendByte(end_disp);
	MOVF	r0x1002,W
; >>> gen.c:2118:genCall
	CALL	_I2CSendByte
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
;;	721 register type nRegs=1
;;	721 register type nRegs=1
;; 	2079 left AOP_REG
;; gen.c:1324:mov2w_op *{*
;; ***	mov2w  1356  offset=0
; >>> gen.c:1361:mov2w
;;	1109 rIdx = r0x104B 
	.line	87; "mstr.c"	I2CSendByte(end_mem);
	MOVF	r0x1003,W
; >>> gen.c:2118:genCall
	CALL	_I2CSendByte
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
;;	721 register type nRegs=1
;;	721 register type nRegs=1
;; 	2079 left AOP_REG
;; gen.c:1324:mov2w_op *{*
;; ***	mov2w  1356  offset=0
; >>> gen.c:1361:mov2w
;;	1109 rIdx = r0x104C 
	.line	88; "mstr.c"	I2CSendByte(dado);
	MOVF	r0x1004,W
; >>> gen.c:2118:genCall
	CALL	_I2CSendByte
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
; >>> gen.c:2118:genCall
	.line	89; "mstr.c"	I2CSendStop();
	CALL	_I2CSendStop
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2435:genEndFunction *{*
;; ***	genEndFunction  2437
	RETURN	
; exit point of _enviar_i2c
;; gen.c:6803:genpic14Code *{*

	New pBlock

code, dbName =C
;; Starting pCode block
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2283:genFunction *{*
;; ***	genFunction  2285 curr label offset=12previous max_key=0 
_I2CSendByte	;Function start
; 2 exit points
;; gen.c:2261:resultRemat *{*
;; gen.c:6739:genReceive *{*
;; ***	genReceive  6740
;;	721 register type nRegs=1
;; gen.c:1866:assignResultValue *{*
;; ***	assignResultValue  1868
;; 	line = 1870 result -=-, size=0, left AOP_REG=r0x1048, size=1, right -=-, size=0
; >>> gen.c:1367:movwf
;;	1109 rIdx = r0x1048 
	.line	50; "mstr.c"	void I2CSendByte(unsigned char SendByte) {
	MOVWF	r0x1000
;; gen.c:2261:resultRemat *{*
;; gen.c:6332:genAssign *{*
;; ***	genAssign  6333
;;	721 register type nRegs=1
;; 	line = 6342 result AOP_REG=r0x1049, size=1, left -=-, size=0, right AOP_LIT=0x00, size=1
;; ***	genAssign  6434
; >>> gen.c:6443:genAssign
;;	1109 rIdx = r0x1049 
	.line	53; "mstr.c"	for (i=0; i<8; i++) {
	CLRF	r0x1001
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:3504:ifxForOp *{*
;; ***	ifxForOp  3506
;; gen.c:3357:genCmpLt *{*
;; ***	genCmpLt  3358
;;	721 register type nRegs=1
;; gen.c:3126:genCmp *{*
;unsigned compare: left < lit(0x8=8), size=1
; >>> gen.c:3099:pic14_mov2w_regOrLit
_00120_DS_
	MOVLW	0x08
; >>> gen.c:3234:genCmp
;;	1109 rIdx = r0x1049 
	SUBWF	r0x1001,W
;; gen.c:3073:genSkipc *{*
; >>> gen.c:3078:genSkipc
	BTFSC	STATUS,0
; >>> gen.c:3082:genSkipc
;; ***	popGetLabel  key=8, label offset 16
	GOTO	_00124_DS_
;genSkipc:3083: created from rifx:0x7fff717c0b30
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:3504:ifxForOp *{*
;; ***	ifxForOp  3506
;; gen.c:3719:genAnd *{*
;; ***	genAnd  3720
;;	721 register type nRegs=1
;; 	line = 3754 result AOP_CRY=0x00, size=0, left AOP_REG=r0x1048, size=1, right AOP_LIT=0x80, size=1
;; gen.c:3646:isLiteralBit *{*
;; ***	isLiteralBit  3647
; >>> gen.c:3823:genAnd
	.line	55; "mstr.c"	if ( SendByte & 0x80) {
	BTFSS	r0x1000,7
; >>> gen.c:3824:genAnd
;; ***	popGetLabel  key=2, label offset 16
	GOTO	_00118_DS_
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:6117:genPointerSet *{*
;; ***	genPointerSet  6118
;; gen.c:5945:genNearPointerSet *{*
;; ***	genNearPointerSet  5946
;;	641
;;	aopForRemat 425
;;	446: rname _PORTC_bits, val 0, const = 0
;; ***	genNearPointerSet  5963
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
;; 	line = 5965 result AOP_PCODE=_PORTC_bits, size=2, left -=-, size=0, right AOP_LIT=0x01, size=1
;; gen.c:5694:genPackBits *{*
;; ***	genPackBits  5695
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
; >>> gen.c:5720:genPackBits
	.line	56; "mstr.c"	I2CSDA = 1;        // MSB first -> LSB last
	BSF	_PORTC_bits,4
;; gen.c:2261:resultRemat *{*
;; gen.c:2614:genGoto *{*
; >>> gen.c:2616:genGoto
;; ***	popGetLabel  key=3, label offset 16
	GOTO	_00119_DS_
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:6117:genPointerSet *{*
;; ***	genPointerSet  6118
;; gen.c:5945:genNearPointerSet *{*
;; ***	genNearPointerSet  5946
;;	641
;;	aopForRemat 425
;;	446: rname _PORTC_bits, val 0, const = 0
;; ***	genNearPointerSet  5963
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
;; 	line = 5965 result AOP_PCODE=_PORTC_bits, size=2, left -=-, size=0, right AOP_LIT=0x00, size=1
;; gen.c:5694:genPackBits *{*
;; ***	genPackBits  5695
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
; >>> gen.c:5720:genPackBits
_00118_DS_
	.line	59; "mstr.c"	I2CSDA = 0;
	BCF	_PORTC_bits,4
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:6117:genPointerSet *{*
;; ***	genPointerSet  6118
;; gen.c:5945:genNearPointerSet *{*
;; ***	genNearPointerSet  5946
;;	641
;;	aopForRemat 425
;;	446: rname _PORTC_bits, val 0, const = 0
;; ***	genNearPointerSet  5963
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
;; 	line = 5965 result AOP_PCODE=_PORTC_bits, size=2, left -=-, size=0, right AOP_LIT=0x01, size=1
;; gen.c:5694:genPackBits *{*
;; ***	genPackBits  5695
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
; >>> gen.c:5720:genPackBits
_00119_DS_
	.line	65; "mstr.c"	I2CSCL = 1;
	BSF	_PORTC_bits,3
;; gen.c:2261:resultRemat *{*
;; gen.c:4425:genInline *{*
;; ***	genInline  4426
	NOP;
	NOP;
	NOP;
	NOP;
	NOP;
	NOP;
	NOP;
	
;; gen.c:2261:resultRemat *{*
;; gen.c:4988:genGenericShift *{*
;; ***	genGenericShift  4992
;;	721 register type nRegs=1
;;	606
; >>> gen.c:4780:shiftLeft_Left2ResultLit
	.line	77; "mstr.c"	SendByte = SendByte << 1;
	BCF	STATUS,0
; >>> gen.c:4783:shiftLeft_Left2ResultLit
;;	1109 rIdx = r0x1048 
	RLF	r0x1000,F
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:6117:genPointerSet *{*
;; ***	genPointerSet  6118
;; gen.c:5945:genNearPointerSet *{*
;; ***	genNearPointerSet  5946
;;	641
;;	aopForRemat 425
;;	446: rname _PORTC_bits, val 0, const = 0
;; ***	genNearPointerSet  5963
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
;; 	line = 5965 result AOP_PCODE=_PORTC_bits, size=2, left -=-, size=0, right AOP_LIT=0x00, size=1
;; gen.c:5694:genPackBits *{*
;; ***	genPackBits  5695
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
; >>> gen.c:5720:genPackBits
	.line	79; "mstr.c"	I2CSCL = 0;
	BCF	_PORTC_bits,3
;; gen.c:2261:resultRemat *{*
;; ***	genPlus  547
;; genarith.c:548:genPlus *{*
;;	721 register type nRegs=1
;;	606
;; 	line = 554 result AOP_REG=r0x1049, size=1, left AOP_REG=r0x1049, size=1, right AOP_LIT=0x01, size=1
;; ***	pic14_getDataSize  1426
;; genarith.c:142:genPlusIncr *{*
;; ***	genPlusIncr  144
;; 	result AOP_REG, left AOP_REG, right AOP_LIT
;; 	genPlusIncr  156
; >>> genarith.c:168:genPlusIncr
;;	1109 rIdx = r0x1049 
	.line	53; "mstr.c"	for (i=0; i<8; i++) {
	INCF	r0x1001,F
;; gen.c:2261:resultRemat *{*
;; gen.c:2614:genGoto *{*
; >>> gen.c:2616:genGoto
;; ***	popGetLabel  key=4, label offset 16
	GOTO	_00120_DS_
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2435:genEndFunction *{*
;; ***	genEndFunction  2437
_00124_DS_
	RETURN	
; exit point of _I2CSendByte
;; gen.c:6803:genpic14Code *{*

	New pBlock

code, dbName =C
;; Starting pCode block
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2283:genFunction *{*
;; ***	genFunction  2285 curr label offset=8previous max_key=0 
_I2CSendStop	;Function start
; 2 exit points
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
; >>> gen.c:2118:genCall
	.line	41; "mstr.c"	I2CDelay();
	CALL	_I2CDelay
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:6117:genPointerSet *{*
;; ***	genPointerSet  6118
;; gen.c:5945:genNearPointerSet *{*
;; ***	genNearPointerSet  5946
;;	641
;;	aopForRemat 425
;;	446: rname _PORTC_bits, val 0, const = 0
;; ***	genNearPointerSet  5963
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
;; 	line = 5965 result AOP_PCODE=_PORTC_bits, size=2, left -=-, size=0, right AOP_LIT=0x00, size=1
;; gen.c:5694:genPackBits *{*
;; ***	genPackBits  5695
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
; >>> gen.c:5720:genPackBits
	.line	42; "mstr.c"	I2CSDA = 0;
	BCF	_PORTC_bits,4
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
; >>> gen.c:2118:genCall
	.line	43; "mstr.c"	I2CDelay();
	CALL	_I2CDelay
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:6117:genPointerSet *{*
;; ***	genPointerSet  6118
;; gen.c:5945:genNearPointerSet *{*
;; ***	genNearPointerSet  5946
;;	641
;;	aopForRemat 425
;;	446: rname _PORTC_bits, val 0, const = 0
;; ***	genNearPointerSet  5963
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
;; 	line = 5965 result AOP_PCODE=_PORTC_bits, size=2, left -=-, size=0, right AOP_LIT=0x01, size=1
;; gen.c:5694:genPackBits *{*
;; ***	genPackBits  5695
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
; >>> gen.c:5720:genPackBits
	.line	44; "mstr.c"	I2CSCL = 1;
	BSF	_PORTC_bits,3
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
; >>> gen.c:2118:genCall
	.line	45; "mstr.c"	I2CDelay();
	CALL	_I2CDelay
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:6117:genPointerSet *{*
;; ***	genPointerSet  6118
;; gen.c:5945:genNearPointerSet *{*
;; ***	genNearPointerSet  5946
;;	641
;;	aopForRemat 425
;;	446: rname _PORTC_bits, val 0, const = 0
;; ***	genNearPointerSet  5963
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
;; 	line = 5965 result AOP_PCODE=_PORTC_bits, size=2, left -=-, size=0, right AOP_LIT=0x01, size=1
;; gen.c:5694:genPackBits *{*
;; ***	genPackBits  5695
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
; >>> gen.c:5720:genPackBits
	.line	46; "mstr.c"	I2CSDA = 1;
	BSF	_PORTC_bits,4
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
; >>> gen.c:2118:genCall
	.line	47; "mstr.c"	I2CDelay();
	CALL	_I2CDelay
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2435:genEndFunction *{*
;; ***	genEndFunction  2437
	RETURN	
; exit point of _I2CSendStop
;; gen.c:6803:genpic14Code *{*

	New pBlock

code, dbName =C
;; Starting pCode block
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2283:genFunction *{*
;; ***	genFunction  2285 curr label offset=4previous max_key=0 
_I2CSendStart	;Function start
; 2 exit points
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
; >>> gen.c:2118:genCall
	.line	28; "mstr.c"	I2CDelay();
	CALL	_I2CDelay
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:6117:genPointerSet *{*
;; ***	genPointerSet  6118
;; gen.c:5945:genNearPointerSet *{*
;; ***	genNearPointerSet  5946
;;	641
;;	aopForRemat 425
;;	446: rname _PORTC_bits, val 0, const = 0
;; ***	genNearPointerSet  5963
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
;; 	line = 5965 result AOP_PCODE=_PORTC_bits, size=2, left -=-, size=0, right AOP_LIT=0x01, size=1
;; gen.c:5694:genPackBits *{*
;; ***	genPackBits  5695
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
; >>> gen.c:5720:genPackBits
	.line	29; "mstr.c"	I2CSDA = 1;
	BSF	_PORTC_bits,4
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
; >>> gen.c:2118:genCall
	.line	30; "mstr.c"	I2CDelay();
	CALL	_I2CDelay
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:6117:genPointerSet *{*
;; ***	genPointerSet  6118
;; gen.c:5945:genNearPointerSet *{*
;; ***	genNearPointerSet  5946
;;	641
;;	aopForRemat 425
;;	446: rname _PORTC_bits, val 0, const = 0
;; ***	genNearPointerSet  5963
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
;; 	line = 5965 result AOP_PCODE=_PORTC_bits, size=2, left -=-, size=0, right AOP_LIT=0x01, size=1
;; gen.c:5694:genPackBits *{*
;; ***	genPackBits  5695
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
; >>> gen.c:5720:genPackBits
	.line	31; "mstr.c"	I2CSCL = 1;
	BSF	_PORTC_bits,3
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
; >>> gen.c:2118:genCall
	.line	32; "mstr.c"	I2CDelay();
	CALL	_I2CDelay
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:6117:genPointerSet *{*
;; ***	genPointerSet  6118
;; gen.c:5945:genNearPointerSet *{*
;; ***	genNearPointerSet  5946
;;	641
;;	aopForRemat 425
;;	446: rname _PORTC_bits, val 0, const = 0
;; ***	genNearPointerSet  5963
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
;; 	line = 5965 result AOP_PCODE=_PORTC_bits, size=2, left -=-, size=0, right AOP_LIT=0x00, size=1
;; gen.c:5694:genPackBits *{*
;; ***	genPackBits  5695
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
; >>> gen.c:5720:genPackBits
	.line	33; "mstr.c"	I2CSDA = 0;
	BCF	_PORTC_bits,4
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
; >>> gen.c:2118:genCall
	.line	34; "mstr.c"	I2CDelay();
	CALL	_I2CDelay
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:6117:genPointerSet *{*
;; ***	genPointerSet  6118
;; gen.c:5945:genNearPointerSet *{*
;; ***	genNearPointerSet  5946
;;	641
;;	aopForRemat 425
;;	446: rname _PORTC_bits, val 0, const = 0
;; ***	genNearPointerSet  5963
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
;; 	line = 5965 result AOP_PCODE=_PORTC_bits, size=2, left -=-, size=0, right AOP_LIT=0x00, size=1
;; gen.c:5694:genPackBits *{*
;; ***	genPackBits  5695
;;	858: aopGet AOP_PCODE type PO_IMMEDIATE
;;	_PORTC_bits
; >>> gen.c:5720:genPackBits
	.line	35; "mstr.c"	I2CSCL = 0;
	BCF	_PORTC_bits,3
;; gen.c:2261:resultRemat *{*
;; gen.c:2030:genCall *{*
;; ***	genCall  2032
;; gen.c:1765:saveRegisters *{*
;; ***	saveRegisters  1767
; >>> gen.c:2118:genCall
	.line	36; "mstr.c"	I2CDelay();
	CALL	_I2CDelay
;; gen.c:1809:unsaveRegisters *{*
;; ***	unsaveRegisters  1811
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2435:genEndFunction *{*
;; ***	genEndFunction  2437
	RETURN	
; exit point of _I2CSendStart
;; gen.c:6803:genpic14Code *{*

	New pBlock

code, dbName =C
;; Starting pCode block
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2283:genFunction *{*
;; ***	genFunction  2285 curr label offset=0previous max_key=0 
_I2CDelay	;Function start
; 2 exit points
;; gen.c:2261:resultRemat *{*
;; gen.c:4425:genInline *{*
;; ***	genInline  4426
	NOP;
	NOP;
	NOP;
	NOP;
	NOP;
	NOP;
	
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2435:genEndFunction *{*
;; ***	genEndFunction  2437
	RETURN	
; exit point of _I2CDelay
;; gen.c:6803:genpic14Code *{*
