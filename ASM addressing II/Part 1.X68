*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    LEA MESSAGE,A1
    MOVE.B #14,D0
    TRAP #15
    
    MOVE.B #4,D0
    TRAP #15
    
    MOVE.B #3,D0
    TRAP #15    
    
MESSAGE DC.B 'ENTER GAMER SCORE',0
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
