LIST P = 18f45K50
    #include <p18f45K50.inc>
    CONFIG WDTEN = OFF		;Desabilita el Watch Dog
    CONFIG MCLRE = ON		;Habilita el pin MCLRE
    CONFIG DEBUG = OFF		;Desabilita el modo Debug
    CONFIG LVP = OFF		;Desabilita Low Voltage Programming
    CONFIG FOSC = INTOSCIO	;Habilita el osciolador interno
    
    org 0			;inicia codigo en la linea 0
    Aux1 EQU 0x00		;reserva un byte en registro 0
    Aux2 EQU 0x01
    
  
 Start:
    MOVLB 0x0F
    CLRF Aux1
    Clrf Aux2
    CLRF ANSELA 
    CLRF ANSELD
    CLRF TRISD
    CLRF TRISA
 
    MOVLW b'01010011'		;Configura Registro OSCCON
    MOVWF OSCCON
    
    Mainloop:

    BTFSC PORTA,0
    GOTO  STOP
    BTFSC PORTA,1
    GOTO SUBIR_PRIMER_SEGUNDO
    BTFSC PORTA,2
    GOTO SUBIR_SEGUNDO_TERCER
    BTFSC PORTA,3
    GOTO BAJAR_TERCER_SEGUNDO
    BTFSC PORTA,4
    GOTO BAJAR_TERCER_PRIMER
    BTFSC PORTA,5
    GOTO BAJAR_SEGUNDO_PRIMER
    BTFSC PORTA,6
    GOTO SUBIR_PRIMER_TERCERO
    
    STOP:
    MOVLW 0x00
    MOVWF LATD
    GOTO Mainloop
    
SUBIR_PRIMER_SEGUNDO:
    MOVLW 0x82
    MOVWF LATD
    CALL RETARDO
    MOVLW 0x08
    MOVWF LATD
    CALL RETARDO
    MOVLW 0x00
    MOVWF LATD
    
    
    GOTO Mainloop
    
SUBIR_PRIMER_TERCERO:
    MOVLW 0x82
    MOVWF LATD
    CALL RETARDO
    MOVLW 0x20
    MOVWF LATD
    CALL RETARDO
    MOVLW 0x00
    MOVWF LATD
    
    
    GOTO Mainloop    
    
  SUBIR_SEGUNDO_TERCER:
    MOVLW 0x88
    MOVWF LATD
    CALL RETARDO
    MOVLW 0x20
    MOVWF LATD
    CALL RETARDO
    MOVLW 0x00
    MOVWF LATD
    GOTO Mainloop 
    
    BAJAR_TERCER_SEGUNDO:
    MOVLW 0x60
    MOVWF LATD
    CALL RETARDO
    MOVLW 0x08
    MOVWF LATD
    CALL RETARDO
    MOVLW 0x00
    MOVWF LATD
    GOTO Mainloop
    
    BAJAR_TERCER_PRIMER:
    MOVLW 0x60
    MOVWF LATD
    CALL RETARDO
    MOVLW 0x02
    MOVWF LATD
    CALL RETARDO
    MOVLW 0x00
    MOVWF LATD
    GOTO Mainloop
    
    BAJAR_SEGUNDO_PRIMER:
    MOVLW 0x48
    MOVWF LATD
    CALL RETARDO
    MOVLW 0x02
    MOVWF LATD
    CALL RETARDO
    MOVLW 0x00
    MOVWF LATD
    CALL RETARDO
    GOTO Mainloop
    
    
    RETARDO:
    DECFSZ Aux1, 1		;Decrementa lo que hay en Aux 1 y salta lo que hay despues
    GOTO RETARDO		;Se dirige a esa direccion de la memoria de programa
    DECFSZ Aux2, 1		;comentario para Osciloscopio
    GOTO RETARDO		;comentario para osciloscopio
    RETURN 
    
    END