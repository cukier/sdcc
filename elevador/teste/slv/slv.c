#include <pic16f876a.h>

#define botao_subir		RB1
#define botao_descer	RB2
#define saida_subir		RC0
#define saida_descer	RC1
#define I2CSDA			RC4
#define I2CSCL			RC3
#define geral			0x00
#define parar			0x00
#define subir   		0x01
#define descer  		0x02

void isr_i2c(void) interrupt 0 {
	char