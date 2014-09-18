//===================================================================
// This file contains some basic LCD functions (4bit mode).         =
// The R/W-pin of the LCD is permanently set to "write".            =
//                                                                  =
// Used MCU : Intel D87C51FA ( 256 Byte RAM, 8 KByte EPROM,         =
//                             3 Timer, UART, @ 11.0592 MHz )       =
//                                                                  =
// Compiler commandline : sdcc program.c --stack-after-data         =
// Compiler version SDCC V2.19Ba                                    =
//===================================================================

//===================================================================
// Port-map of the MCU :                                            =
//                                                                  =
// P0_0 -> unused                                                   =
// P0_1 -> unused                                                   =
// P0_2 -> unused                                                   =
// P0_3 -> unused                                                   =
// P0_4 -> unused                                                   =
// P0_5 -> unused                                                   =
// P0_6 -> unused                                                   =
// P0_7 -> unused                                                   =
//                                                                  =
// P1_0 -> unused                                                   =
// P1_1 -> unused                                                   =
// P1_2 -> unused                                                   =
// P1_3 -> unused                                                   =
// P1_4 -> unused                                                   =
// P1_5 -> unused                                                   =
// P1_6 -> unused                                                   =
// P1_7 -> unused                                                   =
//                                                                  =
// P2_0 -> unused                                                   =
// P2_1 -> unused                                                   =
// P2_2 -> LCD RS                                                   =
// P2_3 -> LCD E                                                    =
// P2_4 -> LCD D4                                                   =
// P2_5 -> LCD D5                                                   =
// P2_6 -> LCD D6                                                   =
// P2_7 -> LCD D7                                                   =
//                                                                  =
// P3_0 -> [RXD]  unused                                            =
// P3_1 -> [TXD]  unused                                            =
// P3_2 -> [INT0] unused                                            =
// P3_3 -> [INT1] unused                                            =
// P3_4 -> [T0]   unused                                            =
// P3_5 -> [T1]   unused                                            =
// P3_6 -> [WR]   unused                                            =
// P3_7 -> [RD]   unused                                            =
//                                                                  =
//===================================================================


// INCLUDES =========================================================
#include <regc51fx.h>     // Definitions of registers, SFRs and Bits
// END INCLUDES =====================================================


// DEFINES ==========================================================
#define LCD_DATA  P2      // Dataport of LCD-Display (D4..D7) 
#define LCD_RS    P2_2    // Register Select of LCD-Display
#define LCD_E     P2_3    // Enable of LCD-Display
#define CTRL_REG  0       // Select instruction register
#define DATA_REG  1       // Select data register
#define BLINK     0x01    // Alias for blinking cursor
#define NOBLINK   0x00    // Alias for non blinking cursor
#define SHOW      0x02    // Alias for cursor on
#define HIDE      0x00    // Alias for cursor off
#define ON        0x04    // Alias for display on
#define OFF       0x00    // Alias for display off
                                                                                    
// END DEFINES ======================================================


// ISR-Prototypes ===================================================
void External0_ISR(void) interrupt 0;         // ISR for the external input INT0
void Timer0_ISR(void)    interrupt 1 using 2; // ISR for Timer0 overflow
void External1_ISR(void) interrupt 2;         // ISR for the external input INT1
void Timer1_ISR(void)    interrupt 3 using 3; // ISR for Timer1 overflow
void Serial_ISR(void)    interrupt 4 using 1; // ISR for serial reception
void Timer2_ISR(void)    interrupt 5;         // ISR for Timer2 overflow
// END ISR-Prototypes ===============================================


// Prototypes =======================================================
void init_MCU(void);                    // Initialize the MCU

void delay(unsigned int time_100us);    // Timer dependend delay-routine
void putchar(unsigned char value);      // Send a character via UART
void UART_puts(unsigned char *text);    // Sends a string to the UART
void init_LCD(void);                    // Initialize the LCD display
void clrscr(void);                      // Clears LCD screen
void LCD_putchar(unsigned char value);  // Writes a character to display
// Prints a text to x/y position
void LCD_printxy(unsigned char x,unsigned char y, unsigned char *text);
// Controls the display
void control_LCD(unsigned char dsp,unsigned char blink,unsigned char cursor);
// Sets LCD write position
void gotoxy(unsigned char x,unsigned char y);

// END Prototypes ===================================================


// Globals ==========================================================

// Table to select DD-RAM address (including instruction and address)
// 0x00..0x0F -> Line 1, 0x40..0x4F -> Line 2
static unsigned char code LOCATION[2][16] = { {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,
                                               0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F},
                                              {0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,
                                               0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF} };

volatile unsigned int  DELAY;                   // Global delaytime

// END Globals ======================================================


/********************************************************************/
/* Function    : External0_ISR()                                ISR */
/*------------------------------------------------------------------*/
/* Description : Interrupt-Service-Routine on vector #0 for         */
/*               handling interrupt requests on external pin P3_2.  */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : none                                               */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*                                                                  */
/********************************************************************/
void External0_ISR(void) interrupt 0 
{
// Safety-routine
_asm
  nop
_endasm;
 
return;  
}


/********************************************************************/
/* Function    : Timer0_ISR()                                   ISR */
/*------------------------------------------------------------------*/
/* Description : Interrupt-Service-Routine on vector #1 for         */
/*               handling Timer0 interrupts. Register set #2 is     */
/*               used to store important registers.                 */
/*               The routine is called every 200탎.                 */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : none                                               */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*                                                                  */
/********************************************************************/
void Timer0_ISR(void) interrupt 1 using 2
{
ET0 = 0;                     // Disable Timer0-interrupt

if ( DELAY > 0 ) DELAY--;    // Timebase ticks for delay-routine

ET0 = 1;                     // Enable Timer0-interrupt

return;
}


/********************************************************************/
/* Function    : External1_ISR()                                ISR */
/*------------------------------------------------------------------*/
/* Description : Interrupt-Service-Routine on vector #2 for         */
/*               handling interrupt requests on external pin P3_3.  */
/*               Free for further use.                              */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : none                                               */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*                                                                  */
/********************************************************************/
void External1_ISR(void) interrupt 2
{
// Safety-routine
_asm
  nop
_endasm;
  
return;
}


/********************************************************************/
/* Function    : Timer1_ISR()                                   ISR */
/*------------------------------------------------------------------*/
/* Description : Interrupt-Service-Routine on vector #3 for         */
/*               handling Timer1 interrupts. Register set #3 is     */
/*               used to store important registers.                 */
/*               Free for further use.                              */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : none                                               */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*                                                                  */
/********************************************************************/
void Timer1_ISR(void) interrupt 3 using 3
{
ET1 = 0;                     // Disable Timer1-interrupt

// Safety-routine
_asm
  nop
_endasm;

ET1 = 1; 

return;
}
 

/********************************************************************/
/* Function    : Serial_ISR()                                   ISR */
/*------------------------------------------------------------------*/
/* Description : Interrupt-Service-Routine on vector #4 for         */
/*               handling serial interrupts. Register set #1 is     */
/*               used to store important registers.                 */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : none                                               */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*                                                                  */
/********************************************************************/
void Serial_ISR(void) interrupt 4 using 1
{
// Safety-routine
_asm
  nop
_endasm;
  

return;
}


/********************************************************************/
/* Function    : Timer2_ISR()                                   ISR */
/*------------------------------------------------------------------*/
/* Description : Interrupt-Service-Routine on vector #5 for         */
/*               handling Timer2 interrupts.                        */
/*               Routine is not used, because Timer2 generates      */
/*               the baudrate for the serial communication.         */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : none                                               */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*                                                                  */
/********************************************************************/
void Timer2_ISR(void) interrupt 5
{
// Safety-routine
_asm
  nop
_endasm;

return;
}


/********************************************************************/
/* Function    : init_MCU()                                     SUB */
/*------------------------------------------------------------------*/
/* Description : Routine initializes the used MCU registers,        */
/*               the timers and the global variables.               */
/*               Baudrate calculation :                             */
/*               RCAP2 = 65536 - ( Quarz / 32 * Baud )              */
/*               Timer 0/1 autoreload-register THx calculation :    */
/*               THx = Timebase * Quarz / 12                        */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : none                                               */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*                                                                  */
/********************************************************************/
void init_MCU(void)
{
EA   = 0;     // Disable all interrupts
ET0  = 0;     // Disable Timer 0 interrupt
ET1  = 0;     // Disable Timer 1 interrupt
ES   = 0;     // Disable Serial interrupt
TR0  = 0;     // Stop Timer 0
TR1  = 0;     // Stop Timer 1
TR2  = 0;     // Stop Baudrate-Generator Timer 2

// Set all pins to input-mode
P0   = 0xFF; 
P1   = 0xFF;
P2   = 0xFF;
P3   = 0xFF;

// Timer 0 & 1
TL0  = 0x00;    // MUST be initialized for the firt time with 0
TH0  = 0xA4;    // Tick every 100탎 
TL1  = 0x00;    // MUST be initialized for the firt time with 0
TH1  = 0x48;    // Tick every 200탎
TMOD = 0x22;    // Autoreload for both Timer 0 & 1

// Timer 2 (used for baudrate-generation)
C_T2 = 0;       // Timer-Mode
RCLK = 1;
TCLK = 1;       // Set mode to Baudrate-Generator

SM1  = 1;     
SM0  = 0;       // Set UART to 8N1
REN  = 1;       // Enable UART reception
RCAP2H = 0xFF;
RCAP2L = 0xEE;  // Set Baudrate to 19200Bd at fq = 11.0592MHz (9k6 -> RCAP2 = 0xFFDC)
RI  = 0;        // Clear Receive-Interrupt-Flag
TI  = 0;        // Clear Transmit-Interrupt-Flag

// Initialize globals
DELAY = 0;

TR0  = 1;       // Start Timer 0
TR1  = 1;       // Start Timer 1
TR2  = 1;       // Start Baudrate-Generator Timer 2

ET0  = 1;       // Enable Timer 0 interrupt
ET1  = 1;       // Enable Timer 1 interrupt
ES   = 1;       // Enable Serial interrupt

EA   = 1;       // Enable all interrupts

return;
}


/********************************************************************/
/* Function    : init_LCD()                                     SUB */
/*------------------------------------------------------------------*/
/* Description : Routine initializes the LCD display recommended    */
/*               in the datasheet (4 Bit initialization)            */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : none                                               */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*               09/99    V1.1 Timing correction of init            */
/*                                                                  */
/********************************************************************/
void init_LCD(void)
{

delay(200);             // Wait 20ms
LCD_E  = 0;
LCD_RS = CTRL_REG;      // Switch to inruction register

//Set LCD_DATA to high nibble of Software Reset
LCD_DATA = (LCD_DATA&0x0F)|0x30;
LCD_E = 1; LCD_E = 0;   // Write data to display
delay(50);              // Wait 5ms

LCD_E = 1; LCD_E = 0;   // Write data to display again (SW Reset)
delay(50);              // Wait 5ms

LCD_E = 1; LCD_E = 0;   // Write data to display again (SW Reset)
delay(50);              // Wait 5ms

// Set LCD_DATA to high nibble of Function Set (4Bit)
LCD_DATA = (LCD_DATA&0x0F)|0x20;
LCD_E = 1; LCD_E = 0;   // Write data to display
delay(4);

// Set LCD_DATA to high nibble of Function Set : 4 bit, 2 lines, 5*7 font
LCD_DATA = (LCD_DATA&0x0F)|0x20;
LCD_E = 1; LCD_E = 0;   // Write data to display
// Set LCD_DATA to lower nibble of Function Set : 4 bit, 2 lines, 5*7 font
LCD_DATA = (LCD_DATA&0x0F)|0x80;
LCD_E = 1; LCD_E = 0;   // Write data to display
delay(4);               // Wait 400탎

// Set LCD_DATA to high nibble of Display On/Off Control : display off, cursor off, don큧 blink
LCD_DATA = (LCD_DATA&0x0F)|0x00;
LCD_E = 1; LCD_E = 0;   // Write data to display
// Set LCD_DATA to lower nibble of Display On/Off Control : display off, cursor off, don큧 blink
LCD_DATA = (LCD_DATA&0x0F)|0x80;
LCD_E = 1; LCD_E = 0;   // Write data to display
delay(4);               // Wait 400탎

// Set LCD_DATA to high nibble of Clear Display
LCD_DATA = (LCD_DATA&0x0F)|0x00;
LCD_E = 1; LCD_E = 0;   // Write data to display
// Set LCD_DATA to lower nibble of Clear Display
LCD_DATA = (LCD_DATA&0x0F)|0x10;
LCD_E = 1; LCD_E = 0;   // Write data to display
delay(50);              // Wait 5ms

// Set LCD_DATA to high nibble of Entry Mode Set : increment DD-RAM address, move cursor
LCD_DATA = (LCD_DATA&0x0F)|0x00;
LCD_E = 1; LCD_E = 0;   // Write data to display
// Set LCD_DATA to lower nibble of Entry Mode Set : increment DD-RAM address, move cursor
LCD_DATA = (LCD_DATA&0x0F)|0x60;
LCD_E = 1; LCD_E = 0;   // Write data to display
delay(4);               // Wait 400탎

return;
}


/********************************************************************/
/* Function    : control_LCD(dsp,blink,cursor)                  SUB */
/*------------------------------------------------------------------*/
/* Description : Routine controls the screen                        */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : unsigned char dsp    = ON     -> Display on        */
/*                                      OFF    -> Display off       */
/*               unsigned char blink  = BLINK  -> Cursor blinks     */
/*                                      NOBLINK-> Cursor not blinks */
/*               unsigned char cursor = SHOW   -> Cursor visible    */
/*                                      HIDE   -> Cursor invisible  */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*               09/99    V1.1 Calculation of control modified      */
/*                             (because of compiler otim. bug)      */
/*                                                                  */
/********************************************************************/
void control_LCD(unsigned char dsp,unsigned char blink,unsigned char cursor)
{
unsigned char control;  // variable to generate instruction byte

control = (0x08 + blink + cursor + dsp); // Cursor control

EA = 0;                 // Disable all interrupts
LCD_RS = CTRL_REG;      // Switch to instruction register
// Set LCD_DATA to high nibble of Display On/Off Control
LCD_DATA = (LCD_DATA&0x0F)|0x00;
LCD_E = 1; LCD_E = 0;   // Write data to display
// Set LCD_DATA to lower nibble of Display On/Off Control
LCD_DATA = (LCD_DATA&0x0F)|((control<<4)&0xF0);
LCD_E = 1; LCD_E = 0;   // Write data to display
EA = 1;                 // Enable all interrupts

delay(4);               // Wait 400탎

return;
}


/********************************************************************/
/* Function    : gotoxy(x,y)                                    SUB */
/*------------------------------------------------------------------*/
/* Description : Sets the write position of the LCD display         */
/*                                                                  */
/*                 (1,1)         (16,1)                             */
/*                   |              |                               */
/*                   ################   -> line 1                   */
/*                   ################   -> line 2                   */
/*                   |              |                               */
/*                 (1,2)         (16,2)                             */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : unsigned char x    -> x position (horizontal)      */
/*               unsigned char y    -> y position (vertical)        */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*                                                                  */
/********************************************************************/
void gotoxy(unsigned char x,unsigned char y)
{

EA = 0;                         // Disable all interrupts
LCD_RS = CTRL_REG;              // Switch to instruction register
// Set LCD_DATA to high nibble of position table value
LCD_DATA = (LCD_DATA&0x0F)|((LOCATION[y-1][x-1])&0xF0);
LCD_E = 1; LCD_E = 0;           // Write data to display
// Set LCD_DATA to lower nibble of position table value
LCD_DATA = (LCD_DATA&0x0F)|(((LOCATION[y-1][x-1])<<4)&0xF0);
LCD_E = 1; LCD_E = 0;           // Write data to display
EA = 1;                         // Enable all interrupts

delay(4);                       // Wait 400탎

return;
}


/********************************************************************/
/* Function    : clrscr()                                       SUB */
/*------------------------------------------------------------------*/
/* Description : Clears LCD display, and sets position to (1,1)     */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : none                                               */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*               09/99    V1.1 Timing correction                    */
/*                                                                  */
/********************************************************************/
void clrscr(void)
{
 
EA = 0;                         // Disable all interrupts
LCD_RS = CTRL_REG;              // Switch to instruction register
// Set LCD_DATA to high nibble of Clear Screen
LCD_DATA = (LCD_DATA&0x0F)|0x00;
LCD_E = 1; LCD_E = 0;           // Write data to display
// Set LCD_DATA to lower nibble of Clear Screen
LCD_DATA = (LCD_DATA&0x0F)|0x10;
LCD_E = 1; LCD_E = 0;           // Write data to display
EA = 1;                         // Enable all interrupts

delay(41);                      // Wait 4.1ms

return;
}


/********************************************************************/
/* Function    : LCD_putchar(value)                             SUB */
/*------------------------------------------------------------------*/
/* Description : Writes the character value to the display          */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : unsigned char value    -> character to be written  */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*                                                                  */
/********************************************************************/
void LCD_putchar(unsigned char value)
{

EA = 0;                         // Disable all interrupts
LCD_RS = DATA_REG;              // Switch to data register
// Set LCD_DATA to high nibble of value
LCD_DATA = (LCD_DATA&0x0F)|(value&0xF0);
LCD_E = 1; LCD_E = 0;           // Write data to display
// Set LCD_DATA to lower nibble of value
LCD_DATA = (LCD_DATA&0x0F)|((value<<4)&0xF0);
LCD_E = 1; LCD_E = 0;           // Write data to display
EA = 1;                         // Enable all interrupts

delay(4);                       // Wait 400탎

return;
}


/********************************************************************/
/* Function    : LCD_printxy(x,y,*text)                         SUB */
/*------------------------------------------------------------------*/
/* Description : Prints text to position x/y of the display         */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : unsigned char x     -> x position of the display   */
/*               unsigned char y     -> y position of the display   */
/*               unsigned char *text -> pointer to text             */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*                                                                  */
/********************************************************************/
void LCD_printxy(unsigned char x,unsigned char y, unsigned char *text)
{

gotoxy(x,y);            // Set cursor position

while( *text )          // while not end of text
  {
  LCD_putchar(*text++); // Write character and increment position
  } 

return;
}


/********************************************************************/
/* Function    : delay(delaytime)                               SUB */
/*------------------------------------------------------------------*/
/* Description : Routine waits (dependening on Timer 0) for about   */
/*               delaytime * 100탎. Best for delaytime > 10         */
/*------------------------------------------------------------------*/
/* Author      : Thorsten Godau  NT8                                */
/*------------------------------------------------------------------*/
/* Input       : unsigned int time_100탎                            */
/*------------------------------------------------------------------*/
/* Returnvalue : none                                               */
/*------------------------------------------------------------------*/
/* History     : 06/99    V1.0 Basic routine                        */
/*               09/99    V1.1 nop inserted in delay-loop           */
/*                                                                  */
/********************************************************************/
void delay(unsigned int time_100us)
{

if ( time_100us == 0 ) return;   // Return if no delaytime is assigned

DELAY = time_100us;              // Set global delaytime
   
while ( DELAY > 0 )
  {
  _asm
    nop
  _endasm;
  }             // Wait delaytime

return;
}


// MAIN =============================================================
void main( void )
{
init_MCU();                                            // Initialize MCU
init_LCD();                                            // Initialize the LCD display
                
LCD_printxy(1,1,"Test of the LCD!");                   // Message to LCD
LCD_printxy(1,2,"---4bit mode----");                   // Message to LCD
control_LCD(ON,NOBLINK,HIDE);                          // Display on, cursor hidden and non-blinking

while(1) // Main loop
  {
  // Do nothing
  _asm
    nop
  _endasm;
  }
}
// END MAIN =========================================================
