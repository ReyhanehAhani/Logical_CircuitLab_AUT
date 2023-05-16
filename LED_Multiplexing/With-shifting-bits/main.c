#include <mega32.h>
#include <delay.h>
unsigned int a=0x01,b=0x01,c=0x01,d=0x01;
int i=0;
void main(void)
{
    DDRA=0xff;
    PORTA=0x00;
    DDRB=0xff;
    PORTB=0x00;
    DDRC=0xff;
    PORTC=0x00;
    DDRD=0xff;
    PORTD=0x00;
    
    
    
    while (1)
      {
      i++;
      // PORTA led
      if(i % 6 == 0)
      {       
        if(a == 256)
        {
            a = 0x01;
        }
        PORTA = a;
        a <<= 1;
      }
      // PORTB led
      if(i % 17 == 0)
      {       
        if(b == 256)
        {
            b = 0x01;
        }
        PORTB = b;
        b <<= 1;
      }
      // PORTC led
      if(i % 29 == 0)
      {       
        if(c == 256)
        {
            c = 0x01;
        }
        PORTC = b;
        c <<= 1;
      }
      
      // PORTD led
      if(i % 29 == 0)
      {       
        if(d == 256)
        {
            d = 0x01;
        }
        PORTD = d;
        d <<= 1;
      }
      
      delay_ms(10);
    }
}