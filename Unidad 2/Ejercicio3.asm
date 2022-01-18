__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC
LIST P=16F84A
INCLUDE <P16F84A.INC>

NUMERO EQU d'10'
 
; Comparta el dato del puerto de entrada PORTA con un numero.
; pueden darse 3 posibildiades:
;    si PORTA: = se encienden todos los leds
;    si PROTA < Solo se enciendne leds de nibble alto
;    si PORTA > se activan los leds pares de salidad
 
ORG 0 
DECLARACION
    BSF STATUS, RP0
    MOVLW b'00011111'
    MOVWF TRISA
    CLRF TRISB
    BCF STATUS, RP0
    
    INICIO
    MOVF 0x05,0
    SUBLW NUMERO
    BTFSC 0x03,0
    GOTO FILTRO
    GOTO PARES
   
    
PARES
    MOVLW b'10101010'
    MOVWF 0x06
    GOTO INICIO
   
   FILTRO
    BTFSC 0x03,2
    GOTO TODOS
    GOTO NIBLE
   
TODOS 
    MOVLW b'11111111'
    MOVWF 0x06
    GOTO INICIO
   
NIBLE 
    MOVLW b'11111111'
    MOVWF 0x06
    GOTO INICIO
   
END
