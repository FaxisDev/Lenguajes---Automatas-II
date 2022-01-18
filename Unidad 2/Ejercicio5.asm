__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC
LIST P=16F84A
INCLUDE <P16F84A.INC>
   
;Zona de datos
    CBLOCK 0x0c
	Centenas
	Decenas
	Unidades
    ENDC

Numero EQU d'165'
    ;zona de codigo
	ORG 0x0
	BSF STATUS,RP0
	CLRF TRISB
	BCF STATUS, RP0

	MOVLW Numero
	CALL Uni
	SWAPF Decenas,w
	IORWF Unidades,w
	MOVWF PORTB
    SLEEP
	
Uni
	clrf Centenas	
	clrf Decenas
	movlw Numero
	movwf Unidades
    
ComparaUnidades movlw d'10'
	subwf Unidades,w
	btfss STATUS,0
	goto Termina
    DecrementoUnidades 
	movwf Unidades
    
DecenasigualaNueve 
	movlw d'9'
	subwf Decenas,w
	btfss STATUS,2
	goto incrementaDecenas
    
iguales 
	clrf Decenas
	incf Centenas
	goto ComparaUnidades
    incrementaDecenas 
	incf Decenas
	goto ComparaUnidades
    
Termina 
	RETURN
END