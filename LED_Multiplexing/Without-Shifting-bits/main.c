#include <mega32.h>
#include <delay.h>

void main(void)
{
int i=0;
unsigned int a=1,b=1,c=1,d=1;
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
      if(i % 6 == 0)
      { 
        a=a*2;  
        if(a > 255)
        {
            a=1;
        }
        PORTA=a;
      }
      if(i % 17 == 0)
      { 
        b=b*2;  
        if(b > 255)
        {
            b=1;
        }
        PORTB=b;
      }
      if(i % 29 == 0)
      { 
        c=c*2;  
        if(c > 255)
        {
            c=1;
        }
        PORTC=c;
      }
      if(i % 43 == 0)
      { 
        d=d*2;  
        if(d > 255)
        {
            d=1;
        }
        PORTD=d;
      }
      
      delay_ms(10);
      }
}