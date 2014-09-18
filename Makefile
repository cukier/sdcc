cc=sdcc
cflags=-mpic16 -I C:\SDCC\include
all:lcd.hex
	$(cc) $(cflags) lcd.c