__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC
LIST P=16F84A
INCLUDE <P16F84A.INC>

cons1 EQU b'00001101'
cons2 EQU b'10110011'

ORG 0
INICIO

BSF STATUS, RP0
CLRF TRISA
CLRF TRISB
BCF STATUS, RP0

PRINCIPAL
MOVLW cons1
MOVWF PORTA
MOVLW cons2
MOVWF PORTB
END