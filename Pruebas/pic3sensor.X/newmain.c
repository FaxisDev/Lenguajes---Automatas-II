//Mendez Cruz Juan Daniel
//Carlos Chavez
//Control de temperatura por medio de dos sensores LM35 controlados por PIC16F887
//Rangos de Temperatura baja>10 grados C,Temperatura media[10,30] grados C
//Temperatura alta> 40 grados C, para temperatura media se acciona un ventilador
//Para Temperatura alta se acciona segundo ventilador se dispara una alarma
 
#include <16F887.h>
#device ADC=10       //Resolución de 10 bits para ADC
#fuses INTRC_IO,NOCPD,NOWDT,NOPUT,NOLVP,NOBROWNOUT,MCLR
#use delay(clock=2M)
#define use_portd_lcd TRUE
#use rs232(baud=9600,xmit=PIN_C6,rcv=PIN_C7) // Pines para establecer comunicación RS232
#include <lcd.c>
 
#use fast_IO(A)   // Configuración rápida del puerto A
#use fast_IO(B)   // Configuración rápida del puerto B
#use fast_IO(C) // Configuración rápida del puerto C
 
long temp;     //Variable de tipo long temp
long conversion; //Variable de tipo long conversión
long conversion1;  //Variable de tipo long conversión1
float temo;          // //Variable de tipo flotante temo
 
unsigned int16 resultado;  //Variable de 16 bits sin signo resultado
 
float sensor(int8 primero , int8 segundo) //función que controla al sensor de temperatura parametros primero y segunto tipo entero de 8 bits
{
while(true)   //Cliclo siempre activo
{
set_adc_channel(primero);            //Seleccionando canal a primero
delay_us(10);                    // tiempo de espera de 10 us segundos
conversion=read_adc();           //conversión lee el canal analógico
set_adc_channel(segundo);     // definiendo el canal que se va a leer
delay_us(10);                 // tiempo de espera de 10 us segundos
 
conversion1=read_adc()  ;   //Conversión1 lee el canal analóico
if(conversion>conversion1)   //Condisión conversión> conversió 1
{
temp=conversion-conversion1;
 
temo=temp*500/1023 ;          //rectifica el sensor de temperatura
lcd_gotoxy(2,1);             // posición 2 en x y 1 en y de LCD
printf(lcd_putc,"Tempera:%f",temo);    //Imprime en el LCD Tempera es temo
printf("%6.2F",temo); //imprime en LCD
delay_ms(200);  //tiempo de espera de 200 msSegundos
 
lcd_gotoxy(2,2); // posicion 2x y 2 y del LCD
printf(lcd_putc"Grados Celcius"); // imprime en el LCD
delay_ms(200); // tiempo de retardo 200 ms S
if(temo>30)   // consicion de rangos de temp si temo menor a treinta
{
OUTPUT_high(PIN_C3);  // nivel alto pin C3
delay_ms(30);         //espera 50 ms S
OUTPUT_low(PIN_C3);   //apaga C3
delay_ms(20);        //espera 50 ms S
OUTPUT_high(PIN_C3); //nivel alto pin C3
delay_ms(20);           //espera 50 ms S
OUTPUT_low(PIN_C3);   //apaga C3
delay_ms(20);           //espera 50 ms S
OUTPUT_high(PIN_C3);    // nivel alto pin C3
delay_ms(20);           //espera 50 ms S
OUTPUT_low(PIN_C3);   //apaga C3
delay_ms(20);           //espera 50 ms S
OUTPUT_high(PIN_C3);    // nivel alto pin C3
delay_ms(20);           //espera 50 ms S
OUTPUT_low(PIN_C3);   //apaga C3
delay_ms(20);           //espera 50 ms S
OUTPUT_high(PIN_C3);    // nivel alto pin C3
OUTPUT_low(PIN_C4);         //apaga C4
OUTPUT_low(PIN_C5);         //apaga C5
}
 
if(temo>10 && temo<30 )       //temo esta entre 10 y 30
{
OUTPUT_high(PIN_C4);        //prende CA
delay_ms(100);             //espera 100 ms
OUTPUT_low(PIN_C4);          //apaga C3
delay_ms(100);               //espera 100 ms S
OUTPUT_high(PIN_C4);          //prende C4
delay_ms(100);                //espera 100 ms
OUTPUT_low(PIN_C3);        //apaga C3
OUTPUT_low(PIN_C5);           //apaga C5
 
}
if(temo>10)   //temo mayor a 18
{
OUTPUT_HIGH(PIN_C0);  //enciende C0
OUTPUT_LOW(PIN_B6);   //enciende Buzzer
}
 
else
{
OUTPUT_LOW(PIN_C0);    //apaga C0
OUTPUT_LOW(PIN_B6);
}
 
if(temo>40)            //temo mayor a 40
{
OUTPUT_HIGH(PIN_B7);  //enciende B7
OUTPUT_HIGH(PIN_B6);  //enciende B7
}
 
else
{
OUTPUT_LOW(PIN_B7);       //apaga B7
OUTPUT_LOW(PIN_B6);  //enciende B7
}
 
if(temo>0 && temo<10)     //temo mayor a 0
{
OUTPUT_high(PIN_C5);     // enciende C5
delay_ms(100);        //espera 100 ms S
OUTPUT_low(PIN_C5);   // apaga C5
delay_ms(100);           //espera 100 ms S
OUTPUT_high(PIN_C5);    //enciende C5
delay_ms(100);        //espera 100 ms S
OUTPUT_low(PIN_C3);  // apaga C3
OUTPUT_low(PIN_C4);   // apaga C4
}
}
 
if(conversion1>conversion)  //conversion1>conversion
{
temp=conversion1-conversion;
temo=temp*500/1023 ;
lcd_gotoxy(2,1);   //posición 2x 1y del LCD
printf(lcd_putc,"Tempera:-%f",temo);  //impirme en LCD
lcd_gotoxy(2,2);      //posición 2x 2y del LCD
printf(lcd_putc"Grados Celcius");  //imprime en LCD
delay_ms(200);                      // espera 200 ms
//  printf("\fUNAM MECATRONICA FI\rCircuitos Digitales \rTemperatura: -%6.2f C°",temo);  //Imprime en LCD
delay_ms(200);    //tiempo de 200 ms
if(temo>0)     //temo mayor a 0
{
OUTPUT_high(PIN_C5);     // enciende C5
delay_ms(100);        //espera 100 ms S
OUTPUT_low(PIN_C5);   // apaga C5
delay_ms(100);           //espera 100 ms S
OUTPUT_high(PIN_C5);    //enciende C5
delay_ms(100);        //espera 100 ms S
OUTPUT_low(PIN_C3);  // apaga C3
OUTPUT_low(PIN_C4);   // apaga C4
}
}
delay_ms(800);  //tiempo de espera 800 ms S
}
return temo;  //regresa el valor de temo
}
 
void main ()
{
set_tris_b(0x0C);  //configurando como salida el puerto B
set_tris_c(0x00);  //configurando como salida el puerto C
 
setup_adc(ADC_CLOCK_DIV_32);   //EL RELOJ DE CONVERSIÓN  del ADC
setup_adc_ports(sAN0| sAN1| sAN5|sAN6);         //Canales  analógicos a usarse AN0, AN1, AN5,AN6
delay_ms(100);       //tiempo de espera 100 ms
lcd_init();
//printf("\fUNAM MECATRONICA FI\rCircuitos Digitales \rProyecto Final");        // imprimiendo en LCD
delay_ms(500);          //tiempo de espera 500 ms S
//printf("\fCargando......");   // imprimiendo por medio de RS232
delay_ms(200);        //tiempo de espera 200 ms S
printf(lcd_putc,"UNAM INGENIERIA\n MECATRONICA FI");   //imprimiendo en LCD
delay_ms(2000);             //tiempo de espera 1000 ms S
printf(lcd_putc,"\f");  // borrando LCD
printf(lcd_putc,"  Control de  \n  temperatura");  //imprimiendo en LCD
delay_ms(1000);            //tiempo de espera 1000 ms
printf(lcd_putc,"\f");   // borrando LCD
printf(lcd_putc,"  Circuitos\n  Digitales");  //imprimiendo en LCD
delay_ms(1000);         //tiempo de espera 1000 ms
printf(lcd_putc,"\f");   // borrando LCD
printf(lcd_putc," DanielMendez\n Carlos Chavez");  //imprimiendo en LCD
delay_ms(1000);         //tiempo de espera 1000 ms
 
lcd_init();             //INICIALIZA LCD
 
while(true)  //bucle infinito
{
if(input(PIN_A2)==0 && input(PIN_A2)==0 )   //si a2 esta apagado
{
printf(lcd_putc,"Presione\n un boton"); // imprime LCD
delay_ms(3000);         //espera 1500 ms
printf(lcd_putc,"\f");    //borrando LCD
 
OUTPUT_LOW(PIN_B7);   //apaga B7
OUTPUT_LOW(PIN_C0);    //apaga C0
}
 
if(input(PIN_A2)==1)   // si la entrada A2 se presiona
{
printf(lcd_putc,"Sensor 1");  //impirme en LCD
delay_ms(500);         //espera 1500 ms
printf(lcd_putc,"\f");    //borrando LCD
delay_ms(500);
sensor(5,6);   //activa función sensor con canala analógico 5, 6
DELAY_MS(200);  //espera 200 ms S
}
 
if(input(PIN_A3)==1)  // si la entrada A3 se presiona
{
printf(lcd_putc,"Sensor 2");  //imprime en LCD
delay_ms(500);         //espera 1500 ms
printf(lcd_putc,"\f");    //borrando LCD
delay_ms(500);
sensor(0,1);  //activa función sensor con canala analógico 0, 1
}
}
}