__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC
LIST P=16F84A
INCLUDE <P16F84A.INC>
 
ORG 0 
DECLARACION
    BSF STATUS, RP0
    MOVLW b'00011111'
    MOVWF TRISA
    CLRF TRISB
    BCF STATUS, RP0

PROGRAMA
    MOVF PORTA,W
    MOVWF PORTB
    ADDWF PORTB, W
    MOVWF PORTB   

END
