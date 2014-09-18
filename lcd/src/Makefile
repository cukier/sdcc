default: lcd_demo

lcd_demo:
	sdcc -c -mpic16 hd44780.c
	sdcc -mpic16 lcd_demo.c hd44780.o

clean:
	rm *.asm *.cod *.cof *.hex *.lst *.o
