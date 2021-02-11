*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    LEA health,A2
    
    MOVE #15,A2
    ;MOVE (A2),d1    
    
    ; MOVE.B #3,D0        
    ; TRAP #15 
    
    
    MOVE A2,D0
    ADD #5,D0
    SUB #5,D0
    MOVE #3,D1
    MULU D1,D0
    DIVU D2,D0
* Put program code here
Health dc.b 'health: ',20
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
