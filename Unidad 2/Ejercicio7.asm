__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC
LIST P=16F84A
INCLUDE <P16F84A.INC>
 
    ;zona de codigo
    ORG 0x0
    BSF STATUS,RP0
    CLRF TRISA
    ;L3,L2,L1,L0,A,B
    MOVLW b'11111111'
    MOVWF TRISB
    BCF STATUS, RP0
	
	Principal
    MOVF PORTB,W
    ANDLW b'00000011'
    GOTO Tabla
	Continuar
    MOVWF PORTA
    GOTO Principal
	
	Tabla
    ADDWF PCL,F
    GOTO L0
    GOTO L1
    GOTO L2
    GOTO L3

    
    L0
    BTFSS PORTB,2
    MOVLW d'0'
    BTFSC PORTB,2
    MOVLW d'1'
    GOTO Continuar
    
        L1
    BTFSS PORTB,3
    MOVLW d'0'
    BTFSC PORTB,3
    MOVLW d'1'
    GOTO Continuar
    
    
        L2
    BTFSS PORTB,4
    MOVLW d'0'
    BTFSC PORTB,4
    MOVLW d'1'
    GOTO Continuar
    
    
        L3
    BTFSS PORTB,5
    MOVLW d'0'
    BTFSC PORTB,5
    MOVLW d'1'
    GOTO Continuar
    
END