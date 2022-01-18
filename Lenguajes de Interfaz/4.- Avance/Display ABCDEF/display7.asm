__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC
LIST P=16F84A
INCLUDE <P16F84.INC>

ORG 0
INICIO
BSF STATUS,RP0
CLRF PORTB
MOVLW b'00011111'
MOVWF PORTA
BCF STATUS,RP0
Principal
MOVF PORTA,W
ANDLW b'00001111'
CALL Binario_a_7Segmentos
MOVWF PORTB
GOTO Principal
Binario_a_7Segmentos
ADDWF PCL,F
Tabla
RETLW b'00111111' ;Valor igual a 0
RETLW b'00000110' ;Valor igual a 1
RETLW b'01011011' ;Valor igual a 2
RETLW b'01001111' ;Valor igual a 3
RETLW b'01100110' ;Valor igual a 4
RETLW b'01101101' ;Valor igual a 5
RETLW b'01111101' ;Valor igual a 6
RETLW b'01000111' ;Valor igual a 7
RETLW b'01111111' ;Valor igual a 8
RETLW b'01100111' ;Valor igual a 9
RETLW b'01110111' ;Valor igual a A
RETLW b'01111100' ;Valor igual a B
RETLW b'00111001' ;Valor igual a C
RETLW b'01011111' ;Valor igual a D
RETLW b'01111001' ;Valor igual a E
RETLW b'01110001' ;Valor igual a F

END