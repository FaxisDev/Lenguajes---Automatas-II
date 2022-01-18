__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC
LIST P=16F84A
INCLUDE <P16F84A.INC>
 
    ;zona de codigo
    ORG 0x0
    BSF STATUS,RP0
    MOVLW b'00011111'
    MOVWF TRISA
    CLRF TRISB
    BCF STATUS, RP0
	
	Principal
    MOVF PORTA,W
    ANDLW b'00000111'
    CALL Tabla
    MOVWF PORTB
    GOTO Principal
	
	Tabla
    ADDWF PCL,F
    retlw d'1'
    retlw d'2'
    retlw d'4'
    retlw d'8'
    retlw d'16'
    retlw d'32'
    retlw d'64'
    retlw d'128'

END