#include <pic16f876a.h>
							// one can use other pic14 device with
							//hardware usart

//#include "sdccEE.c"        // no other interfaces this time
#define bd110   0
#define bd300   1
#define bd600   2
#define bd1200  3
#define bd2400  4
#define bd4800  5
#define bd9600  6
#define bd14k   7
#define bd19k   8
#define bdMIDI  9          //the author is a musician so this is included :-)
#define bd38k   10
#define bd56k   11
#define bd57k   12
#define bd115k  13
#define bd128k  14
#define bd256k  15
//#define clkMhz            // comment out this line for  20Mhz operation
#define _usrtReadx  label
#define maxBuff 12;
__data char  *cyclicBuff;
unsigned int buffTail, buffHead;

void Usart_Init(const unsigned int baudrate) {
	/* Initializes the USART and enables the
	USAR HW interrupt. It is up to the user
	to enable the Global Interrupt Flag GIE */
	TRISC = TRISC | 0xC0;     // enable pins
	SPEN = 1;
	CREN = 1;

	TX9 = 0;
#ifndef clkMhz   // 20Mhz operation
	switch (baudrate) {
		case bd1200: SPBRG = 207;
		BRGH = 0;
		break;

		case bd2400: SPBRG = 103;
		BRGH = 0;
		break;
		case bd4800: SPBRG = 51;
		BRGH = 0;
		break;
		case bd9600: SPBRG = 129;
		BRGH = 1;
		break;
		case bd14k:  SPBRG = 86;
		BRGH = 1;
		break;
		case bd19k:  SPBRG = 64;
		BRGH = 1;
		break;
		case bdMIDI:  SPBRG = 39;
		BRGH = 1;
		break;
		case bd38k:  SPBRG = 32;
		BRGH = 1;
		break;
		case bd56k:  SPBRG = 22;
		BRGH = 1;
		break;
		case bd57k:  SPBRG = 21;
		BRGH = 1;
		break;
		case bd115k:  SPBRG = 10;
		BRGH = 1;
		break;
		case bd128k:  SPBRG = 9;
		BRGH = 1;
		break;
		case bd256k:  SPBRG = 4;
		BRGH = 1;
		break;
		default    :  SPBRG = 129; // defaults to 9600 bps
		BRGH = 1;
		break;
	}
#else      // 16Mhz
	switch (baudrate) {
		case bd1200: SPBRG = 255;
		BRGH = 0;
		break;
		case bd2400: SPBRG = 129;
		BRGH = 0;
		break;
		case bd4800: SPBRG = 64;
		BRGH = 0;
		break;
		case bd9600: SPBRG = 103;
		BRGH = 1;
		break;
		case bd14k:  SPBRG = 68;
		BRGH = 1;
		break;
		case bd19k:  SPBRG = 51;
		BRGH = 1;
		break;
		case bdMIDI:  SPBRG = 31;
		BRGH = 1;
		break;
		case bd38k:  SPBRG = 25;
		BRGH = 1;
		break;
		case bd56k:  SPBRG = 17;
		BRGH = 1;
		break;
		case bd57k:  SPBRG = 16;
		BRGH = 1;
		break;
		case bd115k:  SPBRG = 8;
		BRGH = 1;
		break;
		case bd128k:  SPBRG = 7;
		BRGH = 1;
		break;
		case bd256k:  SPBRG = 3;
		BRGH = 1;
		break;
		default    :  SPBRG = 103; // defaults to 9600bps
		BRGH = 1;
	}
#endif
	TXSTA = TXSTA | 0x20;

	RCIF = 0;
	PEIE = 1;
	GIE  = 1;
}
void Usart_OFF(void) {
	SPEN = 0;
}

/*unsigned char Usart_Data_Ready(void)
{
        return RCIF;
}*/

void Usart_Write( unsigned char _data) {
	while((!TRMT)&& TXEN);   // loop until the register get's emptied

	TXREG = _data;          // this action clears TXIF also;

}

unsigned char Usart_Read(void)
{unsigned char rx;
 //RCIE = 0;                // disable interrupt so as no to trigger during read
 if (FERR) goto _usrtReadx; //  read RCREG if there is framing err to reset it.
 //if (FERR) rx = RCREG;
 while (!RCIF);             //  wait until RCIF raises

_usrtReadx:
		if (OERR) {CREN = 0; CREN = 1;} // reset overrun error flag if raised
rx = RCREG;
//RCIE = 1;                     // re -enable interrupt
return RCREG;
}
void Usart_Str_tx(unsigned char *str)
{ /* sends out zero-terminated string*/
	while(*str) {Usart_Write(*str); str++;}
}
void Usart_Str_rx(unsigned char *str)
{ /* receives a series of characters and converts it to null terminated one.
	The pointer must be a valid RAM data pointer*/
	unsigned char strx;
	do {
		strx = Usart_Read();
		*str = strx;
		str++;
	}  while (strx!=0);
	/* Add the zero-terminator at the end*/
	*str = 0;

}
void Usart_Read_Send(void) // terminal echo just for testing
{ unsigned char rx;
  rx = Usart_Read();
  Usart_Write(rx);
}


////////////////////////////////Test block////////////////////////////////

void intHand(void) __interrupt 0
{
	if (RCIF) {
		RCIE = 0;
		Usart_Read_Send();
		RCIE = 1;
	}
}
void main (void)
{  char code *ID0 = "SDCC PIC14 USART Library";
   char code *ID1 = "Electronics Lab Philippines";
   char code *ID2 = "Copyright(c) 2008. All Rights Reserved.";

   buffTail = (int)(cyclicBuff);
   /*TRISD = 0;
   RD7 = 0;
   RD6 = 0;*/

   Usart_Init(bd57k);      // try other baudrates

/*   RD7 = 1;
   RD7 = 1;*/
   Usart_Str_tx(ID0);
   Usart_Write(10);    // CR-LF
   Usart_Write(13);
   Usart_Str_tx(ID1);
   Usart_Write(10);    // CR-LF
   Usart_Write(13);
   Usart_Str_tx(ID2);
   Usart_Write(10);
   Usart_Write(13);     // must key-in letter 'c'
   Usart_Str_tx("Waiting for the right key...(c)");
   Usart_Write(10);
   Usart_Write(13);
   while(Usart_Read()!='c');
   Usart_Str_tx("OK!...correct key received.....");
   Usart_Write(10);    // CR-LF
   Usart_Write(13);
   Usart_Str_tx("Test Successful!");
   while(1);   // loop forever
}