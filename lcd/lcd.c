#include <pic18f452.h>
#include <stdio.h>
#include <usart.h>
//************************************************************************CONFIG
code char at __CONFIG1H CONFIG1H = _OSC_HS_1H & _OSCS_OFF_1H;
code char at __CONFIG2L CONFIG2L = _PUT_OFF_2L & _BODEN_OFF_2L &
_BODENV_2_0V_2L;
code char at __CONFIG2H CONFIG2H = _WDT_OFF_2H & _WDTPS_1_128_2H;
code char at __CONFIG3H CONFIG3H = _CCP2MUX_RC1_3H;
code char at __CONFIG4L CONFIG4L = _STVR_OFF_4L & _LVP_OFF_4L & _BACKBUG_OFF_4L;
code char at __CONFIG5L CONFIG5L = _CP_0_OFF_5L & _CP_1_OFF_5L & _CP_2_OFF_5L
& _CP_3_OFF_5L;
code char at __CONFIG5H CONFIG5H = _CPB_OFF_5H & _CPD_OFF_5H;
code char at __CONFIG6L CONFIG6L = _WRT_0_OFF_6L & _WRT_1_OFF_6L & _WRT_2_OFF_6L
& _WRT_3_OFF_6L;
code char at __CONFIG6H CONFIG6H = _WRTC_OFF_6H & _WRTB_OFF_6H & _WRTD_OFF_6H;
code char at __CONFIG7L CONFIG7L = _EBTR_0_OFF_7L & _EBTR_1_OFF_7L &
_EBTR_2_OFF_7L & _EBTR_3_OFF_7L;
code char at __CONFIG7H CONFIG7H = _EBTRB_OFF_7H;
//***********************************************************************DEFINES
#define rs				PORTEbits.RE0
#define en				PORTEbits.RE1
#define lcd_data		PORTD
//Entry_Mode
#define Increment		0x02
#define Decrement		0x00
//Display Off Control
#define Display_On		0x04
#define Display_Off 	0x00
#define Cursor_On		0x02
#define Cursor_Off		0x00
#define On_Blink		0x01
#define Off_Blink		0x00
//Cursor or Display shift
#define Display_Shift	0x08
#define Cursor_Move		0x00
#define Right			0x04
#define Left			0x00
//Function Set
#define Bit_8			0x10
#define Bit_4			0x00
#define Two_Lines		0x08
#define One_Line		0x00
#define Por10			0x04
#define Por7			0x00
//DD RAM Address
#define First_Line 		0x00
#define Second_Line 	0x40
//*********************************************************************VARIABLES
unsigned int i;		//1mS => 80 @ 4MHz

void stdio_init() {
	usart_open(
			USART_TX_INT_OFF & USART_RX_INT_OFF & USART_BRGH_HIGH
					& USART_ASYNCH_MODE & USART_EIGHT_BIT, 79);
	stdout = STREAM_USART;
}

void Send_Cmd(unsigned char cmd) {
	lcd_data = cmd;
	rs = 0;
	en = 0;
	en = 1;
	i = 80;
	while (i)
		i--;
	en = 0;
}

void Clear_Display(void) {
	Send_Cmd(0x01);
	i = 160;
	while (i)
		i--;
}

void Return_Home(void) {
	Send_Cmd(0x02);
	i = 160;
	while (i)
		i--;
}

void Entry_Mode(unsigned char mode) {
	mode &= 0x03;
	Send_Cmd(mode | 0x04);
	i = 80;
	while (i)
		i--;
}

void Display_Off_Control(unsigned char control) {
	control &= 0x07;
	Send_Cmd(control | 0x08);
	i = 80;
	while (i)
		i--;
}

void Cursor_Display_Shift(unsigned char shift) {
	shift &= 0x0C;
	Send_Cmd(shift | 0x10);
	i = 80;
	while (i)
		i--;
}

void Function_Set(unsigned char function) {
	function &= 0x1C;
	Send_Cmd(function | 0x20);
	i = 80;
	while (i)
		i--;
}

void Send_Data(unsigned char dado) {
	lcd_data = dado;
	en = 0;
	PORTE |= 0x03;
	i = 80;
	while (i)
		i--;
	PORTE = 0x01;
	i = 80;
	while (i)
		i--;
}

void Ddram_Adrdress(unsigned char address) {
	address &= 0x7F;
	Send_Cmd(address | 0x80);
	i = 80;
	while (i)
		i--;
}

void Lcd_Init(void) {
	int cont = 0;

	i = 1200;
	while (i)
		i--;
	cont = 3;
	while (cont) {
		Send_Cmd(0x30);
		cont--;
	}

	Function_Set(Bit_8 | Por10 | Two_Lines);

	Display_Off_Control(Display_On | Cursor_On);

	i = 80;
	while (i)
		i--;

	Clear_Display();

	Entry_Mode(Increment);
}

void Lcd_Print(unsigned char* message) {
	int j;
	while (message[j]) {
		switch (message[j]) {
		case '\n':
			Ddram_Adrdress(Second_Line);
			break;
		case '\f':
			Clear_Display();
			Ddram_Adrdress(First_Line);
			break;
		default:
			Send_Data(message[j]);
		}
		j++;
	}
}

void main(void) {

	TRISD = 0x00;
	PORTD = 0x00;
	TRISE = 0x00;
	PORTE = 0x00;

	Lcd_Init();
	stdio_init();
	printf("hello world\n");
}
