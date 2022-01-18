LIST P=16F84A
   INCLUDE <P16F84A.INC>
__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC
CBLOCK 0x0c

ENDC 


ORG 0

BSF STATUS,RP0 ; BIT EN UNO
CLRF TRISB     ;SALIDA
BCF STATUS,RP0 ;INGRESO AL BANCO 0 


INICIO 
        MOVLW D'143'
        MOVWF PORTB
        call Retardo_500ms
        
         MOVLW D'79'
        MOVWF PORTB
        call Retardo_500ms
        
         MOVLW D'47'
        MOVWF PORTB
        call Retardo_500ms
       
         MOVLW D'31'
        MOVWF PORTB
        call Retardo_500ms
        
        MOVLW D'47'
        MOVWF PORTB
        call Retardo_500ms
        
         MOVLW D'79'
        MOVWF PORTB
        call Retardo_500ms
        
         MOVLW D'143'
        MOVWF PORTB
        call Retardo_500ms
        goto INICIO





include<Retardos.inc>
END