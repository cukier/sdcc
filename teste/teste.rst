                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.0.0 #6037 (Oct 31 2010) (MINGW32)
                              4 ; This file was generated Wed Apr 13 14:13:45 2011
                              5 ;--------------------------------------------------------
                              6 	.module teste
                              7 	.optsdcc -mmcs51 --model-small
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _main
                             13 	.globl _strl
                             14 ;--------------------------------------------------------
                             15 ; special function registers
                             16 ;--------------------------------------------------------
                             17 	.area RSEG    (ABS,DATA)
   0000                      18 	.org 0x0000
                             19 ;--------------------------------------------------------
                             20 ; special function bits
                             21 ;--------------------------------------------------------
                             22 	.area RSEG    (ABS,DATA)
   0000                      23 	.org 0x0000
                             24 ;--------------------------------------------------------
                             25 ; overlayable register banks
                             26 ;--------------------------------------------------------
                             27 	.area REG_BANK_0	(REL,OVR,DATA)
   0000                      28 	.ds 8
                             29 ;--------------------------------------------------------
                             30 ; internal ram data
                             31 ;--------------------------------------------------------
                             32 	.area DSEG    (DATA)
   0008                      33 _strl::
   0008                      34 	.ds 10
                             35 ;--------------------------------------------------------
                             36 ; overlayable items in internal ram 
                             37 ;--------------------------------------------------------
                             38 	.area OSEG    (OVR,DATA)
                             39 ;--------------------------------------------------------
                             40 ; Stack segment in internal ram 
                             41 ;--------------------------------------------------------
                             42 	.area	SSEG	(DATA)
   0018                      43 __start__stack:
   0018                      44 	.ds	1
                             45 
                             46 ;--------------------------------------------------------
                             47 ; indirectly addressable internal ram data
                             48 ;--------------------------------------------------------
                             49 	.area ISEG    (DATA)
                             50 ;--------------------------------------------------------
                             51 ; absolute internal ram data
                             52 ;--------------------------------------------------------
                             53 	.area IABS    (ABS,DATA)
                             54 	.area IABS    (ABS,DATA)
                             55 ;--------------------------------------------------------
                             56 ; bit data
                             57 ;--------------------------------------------------------
                             58 	.area BSEG    (BIT)
                             59 ;--------------------------------------------------------
                             60 ; paged external ram data
                             61 ;--------------------------------------------------------
                             62 	.area PSEG    (PAG,XDATA)
                             63 ;--------------------------------------------------------
                             64 ; external ram data
                             65 ;--------------------------------------------------------
                             66 	.area XSEG    (XDATA)
                             67 ;--------------------------------------------------------
                             68 ; absolute external ram data
                             69 ;--------------------------------------------------------
                             70 	.area XABS    (ABS,XDATA)
                             71 ;--------------------------------------------------------
                             72 ; external initialized ram data
                             73 ;--------------------------------------------------------
                             74 	.area XISEG   (XDATA)
                             75 	.area HOME    (CODE)
                             76 	.area GSINIT0 (CODE)
                             77 	.area GSINIT1 (CODE)
                             78 	.area GSINIT2 (CODE)
                             79 	.area GSINIT3 (CODE)
                             80 	.area GSINIT4 (CODE)
                             81 	.area GSINIT5 (CODE)
                             82 	.area GSINIT  (CODE)
                             83 	.area GSFINAL (CODE)
                             84 	.area CSEG    (CODE)
                             85 ;--------------------------------------------------------
                             86 ; interrupt vector 
                             87 ;--------------------------------------------------------
                             88 	.area HOME    (CODE)
   0000                      89 __interrupt_vect:
   0000 02 00 08             90 	ljmp	__sdcc_gsinit_startup
                             91 ;--------------------------------------------------------
                             92 ; global & static initialisations
                             93 ;--------------------------------------------------------
                             94 	.area HOME    (CODE)
                             95 	.area GSINIT  (CODE)
                             96 	.area GSFINAL (CODE)
                             97 	.area GSINIT  (CODE)
                             98 	.globl __sdcc_gsinit_startup
                             99 	.globl __sdcc_program_startup
                            100 	.globl __start__stack
                            101 	.globl __mcs51_genXINIT
                            102 	.globl __mcs51_genXRAMCLEAR
                            103 	.globl __mcs51_genRAMCLEAR
                            104 	.area GSFINAL (CODE)
   0061 02 00 03            105 	ljmp	__sdcc_program_startup
                            106 ;--------------------------------------------------------
                            107 ; Home
                            108 ;--------------------------------------------------------
                            109 	.area HOME    (CODE)
                            110 	.area HOME    (CODE)
   0003                     111 __sdcc_program_startup:
   0003 12 00 64            112 	lcall	_main
                            113 ;	return from main will lock up
   0006 80 FE               114 	sjmp .
                            115 ;--------------------------------------------------------
                            116 ; code
                            117 ;--------------------------------------------------------
                            118 	.area CSEG    (CODE)
                            119 ;------------------------------------------------------------
                            120 ;Allocation info for local variables in function 'main'
                            121 ;------------------------------------------------------------
                            122 ;------------------------------------------------------------
                            123 ;	teste.c:5: void main (void) {
                            124 ;	-----------------------------------------
                            125 ;	 function main
                            126 ;	-----------------------------------------
   0064                     127 _main:
                    0002    128 	ar2 = 0x02
                    0003    129 	ar3 = 0x03
                    0004    130 	ar4 = 0x04
                    0005    131 	ar5 = 0x05
                    0006    132 	ar6 = 0x06
                    0007    133 	ar7 = 0x07
                    0000    134 	ar0 = 0x00
                    0001    135 	ar1 = 0x01
                            136 ;	teste.c:6: strcpy (strl, "testing");
   0064 75 12 EF            137 	mov	_strcpy_PARM_2,#__str_0
   0067 75 13 00            138 	mov	(_strcpy_PARM_2 + 1),#(__str_0 >> 8)
   006A 75 14 80            139 	mov	(_strcpy_PARM_2 + 2),#0x80
   006D 90 00 08            140 	mov	dptr,#_strl
   0070 75 F0 40            141 	mov	b,#0x40
   0073 02 00 76            142 	ljmp	_strcpy
                            143 	.area CSEG    (CODE)
                            144 	.area CONST   (CODE)
   00EF                     145 __str_0:
   00EF 74 65 73 74 69 6E   146 	.ascii "testing"
        67
   00F6 00                  147 	.db 0x00
                            148 	.area XINIT   (CODE)
                            149 	.area CABS    (ABS,CODE)
