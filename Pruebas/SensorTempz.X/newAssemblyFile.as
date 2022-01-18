Device = 16F877A        'DECLARAMOS EL PIC A USAR
XTAL = 4                 'CRYSTAL DE 4Mhz
 

Declare LCD_TYPE 0           'DECLARAMOS LOS PUERTOS DE SALIDA Y DE PROGRAMACION.
Declare LCD_DTPIN PORTD.4
Declare LCD_RSPIN PORTD.2 
Declare LCD_ENPIN PORTD.3
LCD_LINES 2


TRISD=0                     'PUERTO D COMO SALIDA.
TRISA.0=1                    'PUERTO A.0 COMO ENTRADA ANALOGICA.
ADCON1=%100000                    
Dim adc As Float 
Dim resultado As Float 
   
     Print At 1,1, "   SENSOR DE    "        'FRASES AL COMENSAR LA PROGRAMACION.
     Print At 2,1, "TEMPERATURA LM35"
     DelayMS 3000
     Print At 1,1, "                "
     Print At 2,1, "                "
     DelayMS 500
     
     Print At 1,1, " PROGRAMADO CON "
     Print At 2,1, "  PIC 16F877A   "
     DelayMS 3000
     Print At 1,1, "               "
     Print At 2,1, "               "
     DelayMS 500
    
     inicio:
         Print At 1,1, "  TEMPERATURA   "       'EN LA ?RIMERA FILA LA PALABRA TEMPERATURA.
         Print At 2,1, "ACTUAL"                  'FILA 2 PALABRA ACTUAL ASTA COLUMNA 8.
         adc = ADIn 0
         resultado = adc * 500/65472              'AQUI APARESCE LA TEMPERATURA.
         Print At 2,8,DEC1,resultado,0
         Print At 2,12,"'C  "
        
     
     GoTo inicio
     End 