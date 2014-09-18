pcode dump


	New pBlock

internal pblock, dbName =M
;; Starting pCode block
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2283:genFunction *{*
;; ***	genFunction  2285 curr label offset=0previous max_key=0 
_main	;Function start
; 2 exit points
;; gen.c:2261:resultRemat *{*
;; gen.c:6332:genAssign *{*
;; ***	genAssign  6333
;; ***	aopForSym 350
;;	361 sym->rname = _TRISB, size = 1
;; 	line = 6342 result AOP_DIR=_TRISB, size=1, left -=-, size=0, right AOP_LIT=0x00, size=1
;; ***	genAssign  6434
; >>> gen.c:6443:genAssign
;;	1013
;;	1029  _TRISB   offset=0
	.line	11; "blink.c"	TRISB = 0x00;
	CLRF	_TRISB
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
	.line	12; "blink.c"	PORTB = 0x00;
	CLRF	_PORTB
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:6332:genAssign *{*
;; ***	genAssign  6333
;; ***	aopForSym 350
;;	361 sym->rname = _i, size = 2
;; 	line = 6342 result AOP_DIR=_i, size=2, left -=-, size=0, right AOP_LIT=0xb0, size=2
;; ***	genAssign  6434
; >>> gen.c:6439:genAssign
_00109_DS_
	.line	15; "blink.c"	i = 1200;
	MOVLW	0xb0
; >>> gen.c:6441:genAssign
;;	1013
;;	1029  _i   offset=0
	MOVWF	_i
;; ***	genAssign  6434
; >>> gen.c:6439:genAssign
	MOVLW	0x04
; >>> gen.c:6441:genAssign
;;	1013
;;	1029  _i   offset=1
	MOVWF	(_i + 1)
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:6187:genIfx *{*
;; ***	genIfx  6188
;; ***	aopForSym 350
;;	361 sym->rname = _i, size = 2
;; ***	pic14_toBoolean  1500
; >>> gen.c:1509:pic14_toBoolean
;;	1013
;;	1029  _i   offset=0
_00105_DS_
	.line	16; "blink.c"	while(i) i--;
	MOVF	_i,W
; >>> gen.c:1514:pic14_toBoolean
;;	1013
;;	1029  _i   offset=1
	IORWF	(_i + 1),W
; >>> gen.c:6236:genIfx
	BTFSC	STATUS,2
; >>> gen.c:6237:genIfx
;; ***	popGetLabel  key=3, label offset 4
	GOTO	_00107_DS_
;; gen.c:2261:resultRemat *{*
;; gen.c:3504:ifxForOp *{*
;; ***	ifxForOp  3506
;; gen.c:6695:genDjnz *{*
;; ***	genDjnz  6696
;; genarith.c:832:genMinus *{*
;; ***	genMinus  833
;; ***	aopForSym 350
;;	361 sym->rname = _i, size = 2
;; 	result AOP_DIR, left AOP_DIR, right AOP_LIT
;; ***	pic14_getDataSize  1426
;; ***	pic14_getDataSize  1426
;; genarith.c:270:genAddLit *{*
;; ***	genAddLit  271
;; ***	pic14_getDataSize  1426
;; ***	pic14_getDataSize  1426
;; hi = ff	genAddLit  342
; >>> genarith.c:353:genAddLit
	MOVLW	0xff
; >>> genarith.c:354:genAddLit
;;	1013
;;	1029  _i   offset=0
	ADDWF	_i,F
; >>> genarith.c:355:genAddLit
	BTFSS	STATUS,0
; >>> genarith.c:356:genAddLit
;;	1013
;;	1029  _i   offset=1
	DECF	(_i + 1),F
;; ***	pic14_getDataSize  1426
;; ***	pic14_getDataSize  1426
;; ***	pic14_getDataSize  1426
;; ***	addSign  797
;; genarith.c:798:addSign *{*
;; gen.c:2261:resultRemat *{*
;; gen.c:2614:genGoto *{*
; >>> gen.c:2616:genGoto
;; ***	popGetLabel  key=1, label offset 4
	GOTO	_00105_DS_
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; ***	genPlus  547
;; genarith.c:548:genPlus *{*
;; ***	aopForSym 350
;;	361 sym->rname = _PORTB, size = 1
;; 	line = 554 result AOP_DIR=_PORTB, size=1, left AOP_DIR=_PORTB, size=1, right AOP_LIT=0x01, size=1
;; ***	pic14_getDataSize  1426
;; genarith.c:142:genPlusIncr *{*
;; ***	genPlusIncr  144
;; 	result AOP_DIR, left AOP_DIR, right AOP_LIT
;; 	genPlusIncr  156
; >>> genarith.c:168:genPlusIncr
;;	1013
;;	1029  _PORTB   offset=0
_00107_DS_
	.line	17; "blink.c"	PORTB++;
	INCF	_PORTB,F
;; gen.c:2261:resultRemat *{*
;; gen.c:2614:genGoto *{*
; >>> gen.c:2616:genGoto
;; ***	popGetLabel  key=5, label offset 4
	GOTO	_00109_DS_
;; gen.c:2261:resultRemat *{*
;; gen.c:2597:genLabel *{*
;; ***	genLabel  2600
;; gen.c:2261:resultRemat *{*
;; gen.c:2435:genEndFunction *{*
;; ***	genEndFunction  2437
	RETURN	
; exit point of _main
