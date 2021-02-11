*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    MOVE.B $00110000,D1  ;value of color
    MOVE.B #21,D0        ;change colour of font
    TRAP #15  
    
    MOVE.B #2,D0        ; reads string fromkeyboard input stores a1
    TRAP #15
    
    MOVE.B #5,D0        ; reads single character input, stores at d1 
    TRAP #15
   
    MOVE.B #8,D0        ;return time since midnight to d1, REMOVE THIS DEMO
    TRAP #15
    
    MOVE.B #12,D1        ; num12 to d1
    MOVE.B #11,D0        ;position cursor at ROW,COL,
    TRAP #15

    MOVE.B #13,D0        ;display string at a1 , which is from above
    TRAP #15

    MOVE.B #17,D0        ;display string at a1 then display number at d1
    TRAP #15             ;which is time returned
    
    MOVE.B #18,D0        ;display string at a1 then read a number into d1
    TRAP #15  

  

* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
