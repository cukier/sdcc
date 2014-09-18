#include "lcd.h"
#include "delays.h"
#include <pic16f876a.h>

volatile xdata at 0x8000 char cmd_write;
volatile xdata at 0x8001 char cmd_read;
volatile xdata at 0x8002 char data_write;
volatile xdata at 0x8003 char data_read;
unsigned int cont;

#define WAIT_WHILE_BUSY { while(cmd_read & 0x80); }

void lcd_init(void) {
	cont = 0;
	//16 ms
	cmd_write = 0x38;
	//5 ms
	cmd_write = 0x38;
	//110 ms
	cmd_write = 0x38;
}

void lcd_clear(void) 
{
	WAIT_WHILE_BUSY;
	cmd_write = 0x01;
}

void lcd_home(void)
{
	WAIT_WHILE_BUSY;
	cmd_write = 0x02;
}

void lcd_entrymode(char increment_pos, char shift)
{
	WAIT_WHILE_BUSY;
	cmd_write = 0x04 + (increment_pos?0x02:0x00) + (shift?0x01:0x00);
}

void lcd_displaypower(char on, char showcursor, char blinking)
{
	WAIT_WHILE_BUSY;
	cmd_write = 0x08 + (on?0x04:0x00) + (showcursor?0x02:0x00) + (blinking?0x01:0x00);
}

void lcd_putc(char dat)
{
	WAIT_WHILE_BUSY;
	data_write = dat;
}

void lcd_cursor (unsigned char pos)
{
	WAIT_WHILE_BUSY;
	cmd_write = 0x80 + pos;
}

void lcd_puts(const char* string)
{
	int i;
    for (i = 0; i < 16 && string[i]; i++) lcd_putc(string[i]);
}

void lcd_functionset(char twolines, char font5x10) 
{
	WAIT_WHILE_BUSY;
	cmd_write = 0x20 + 0x10 + (twolines?0x08:0x00) + (font5x10?0x04:0x00);
}

void lcd_setshift(char shiftcontent, char turn_right)
{
	WAIT_WHILE_BUSY;
	cmd_write = 0x10 + (shiftcontent?0x08:0x00) + (turn_right?0x04:0x00);
}
