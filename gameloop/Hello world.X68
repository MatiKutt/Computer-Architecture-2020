*-------------------------------------------------------
* Starting memory  ress for the programme $1000
*-------------------------------------------------------
    org $1000
*-------------------------------------------------------

*-------------------------------------------------------
*Validation values to be used, modify as needed
*Add additional validation values as required
*-------------------------------------------------------
exit        EQU 0      used to exit assembly program
min_potions EQU 1      min number of potions
max_potions EQU 9      max number of potions
min_weapons EQU 1      min weapons
max_weapons EQU 3      max weapons
win_point   EQU 5      points accumilated on win
lose_point  EQU 8      points deducted on a loss

mine_loc    EQU 99    used below for some simple collision detection using CMP
                       * example for a hit




*Start of Game
start:
    move.b  #20,$4000 put score/health in memory location $4000
    lea     $4000,A3   assign address A3 to that memory location
    
    move.b  #10,$4500 put enemy health in memory location $4500
    lea     $4500,A5   assign address A5 to that memory location
    
    
    move.b  #2,$5000 put potions in memory location $5000
    lea     $5000,A4   assign address A4 to that memory location

    move.b  #1,$4750 put hit/miss in memory location $4750
    lea     $4750,A6   assign address A6  to that memory location

    
    bsr     welcome    branch to the welcome subroutine
    bsr     input      branch to the input subroutine
    bsr     game       branch to the game subroutine
*Game loop
    org     $3000      the rest of the program is to be located from 3000 onwards

*-------------------------------------------------------
*-------------------Game Subroutine---------------------
*-------------------------------------------------------
game:
    bsr     gameloop   branch to gameloop subroutine
    rts                return from game: subroutine
          
end:
    simhalt

*-------------------------------------------------------
*-------------------Welcome Subroutine------------------
*-------------------------------------------------------
welcome:
    bsr     endl            branch to endl subroutine
    lea     welcome_msg,A1  assign message to address register A1
    move.b  #14,D0          move literal 14 to DO
    trap    #15             trap and interpret value in D0
    bsr     endl            branch to endl subroutine
    rts                     return from welcome: subroutine

*-------------------------------------------------------
*---------Gameplay Input Values Subroutine--------------
*-------------------------------------------------------    
input:
    bsr     potions         branch to potion input subroutine
    bsr     weapons         branch to weaponss input subroutine
    rts

*-------------------------------------------------------
*----------------Gameloop (main loop)-------------------
*------------------------------------------------------- 
gameloop:
    bsr     update          branch to update game subroutine 
    bsr     clear_screen    clears the screen         
    bsr     draw            branch to draw screen subroutine
    bsr     clear_screen    clears the screen
    bsr     gameplay        branch to gameplay subroutine
    bsr     clear_screen    clears the screen
    bsr     hud             branch to display HUD subroutine
    bsr     clear_screen    clears the screen
    bsr     replay          branch to replay game subroutine
    bsr     clear_screen    clears the screen
    rts                     return from gameloop: subroutine

*-------------------------------------------------------
*----------------Update Quest Progress------------------
*  Complete Quest
*------------------------------------------------------- 
update:
    bsr     endl            print a CR and LF
    bsr     decorate        decorate with dots using a loop
    lea     update_msg,A1   
    move.b  #14,D0
    trap    #15
    bsr     decorate
    rts
*-------------------------------------------------------
*-----------------Draw Quest Updates--------------------
* Draw the game progress information, status regarding
* quest
*------------------------------------------------------- 
draw:
    bsr     endl
    bsr     decorate
    lea     draw_msg,A1
    move.b  #14,D0
    trap    #15
    bsr     decorate
    rts

*-------------------------------------------------------
*--------------------Potions Inventory---------------------
* Number of potions to be used in a Quest 
*------------------------------------------------------- 
potions:
    bsr     endl
    bsr     decorate
    lea     potions_msg,A1
    move.b  #14,D0
    trap    #15
    
    move.w  (A4),A1
    move.b  #14,D0
    trap    #15
    
    bsr     decorate
    rts

*-------------------------------------------------------
*-------------------------Weapons-----------------------
* Number of weapons
*-------------------------------------------------------   
weapons:
    bsr     endl
    bsr     decorate
    lea     weapons_msg,A1
    move.b  #14,D0
    trap    #15
    bsr     decorate
    rts






*-------------------------------*
NEXT_LEVEL
    move.b #10,(A5)
    lea     next_level_msg,A1
    
    move    #14,D0
    trap    #15
      *-----Wait for input ------*
    move    #5,D0
    trap    #15
    bsr     clear_screen 

*-------------------------------------------------------
*---Game Play (Quest Progress)--------------------------
*------------------------------------------------------- 
gameplay:

    *--- END PROGRAM IF HEALTH 0 ----*
    cmp.b #0,(A3)
    beq EXIT

    cmp.b #0,(A5)
    beq NEXT_LEVEL


    *-----Wait for input ------*
    move    #5,D0
    trap    #15
    bsr     clear_screen 
    
    
    clr D1
    bsr     endl
    bsr     decorate
    lea     gameplay_msg,A1
    move.b  #14,D0
    trap    #15
    
    *----show Potions-----*
    bsr endl
    lea     potions_msg,A1
    move    #14,D0
    trap    #15
      
    move.b (A4),D1
    move    #3,D0
    trap    #15
    clr D1

    
    
    *-----show enemy health currently -----*
    bsr     endl
    bsr     decorate
    lea     enemy_health_msg,A1
    move.b  #14,D0
    trap    #15
  
    move.b (A5),D1
    move    #3,D0
    trap    #15
    
    
    *-health-*
     bsr hud
     
     
     
*----Choose Move----*
  
    

    bsr     decorate
    lea     player_move_msg,A1
    move.b  #14,D0
    trap    #15
    

    move.b  #4,D0
    trap    #15
    bsr     decorate
    
    *--if player inputs 1, attack--*
    cmp     #1,D1          
    beq     roll_attack
   
   *--if player inputs 2, drink potion--*
   cmp     #2,D1          
   beq     try_potion
    
    
   *--if player inputs 3, block--*
   cmp     #3,D1          
   beq     block
   
   
   
   
    
    
block:
   
    lea     block_msg,A1
    move.b  #14,D0
    trap    #15
    bsr gameplay
   
*-------------------------------------------------------
*-----------------Heads Up Display (Score)--------------
* Retrieves the score from memory location
*-------------------------------------------------------   
hud:


    bsr     endl
    bsr     decorate
    lea     hud_msg,A1
    move.b  #14,D0
    trap    #15
    
    move.b  (A3),D1     retrieve the value A3 point to and move to D1
    move.b  #3,D0       move literal 3 to D0
    trap    #15         intrepret value in D0, which 3 which displays D1
    bsr     decorate
    rts

*-------------------------------------------------------
*-----------------------Being Attacked------------------
* This could be used for collision detection
*-------------------------------------------------------
collision:
    move.b  #mine_loc,D1
    cmp     #99,D1 is( x == 100)?
	bne     collision_miss if x is equal to 100, then hit
	
	
collision_hit:
    *hit
    clr  (A6)

    move    #1,(A6) 
    lea     hit_msg,A1
    move    #14,D0
    trap    #15
    sub.b   #2,(A5)
   
    
    bsr gameplay
    
collision_miss:
    *miss
    clr  (A6)
    move #2,(A6)
    sub.b   #1,(A3)
    lea     miss_msg,A1
    move    #14,D0
    trap    #15
    bsr gameplay


    
try_potion:

    cmp.b     #0,(A4)
    bne drink_potion
    beq     collision
    bsr gameplay
    
    
drink_potion:
    
    lea     potions_msg,A1
    move    #14,D0
    trap    #15
    add.b   #2,(A3)
    sub.b   #1,(A4)


    move.b (A4),D1
    move    #3,D0
    trap    #15
    
    
   bsr gameplay

roll_attack:
    cmp.b     #1,(A6)
    
    beq collision_miss
    bne collision_hit
*-------------------------------------------------------
*--------------------------Loop-------------------------
*-------------------------------------------------------
loop:
    move.b  #5, D3 loop counter D3=5
next:
    lea     loop_msg,A1
    move.b  #14,D0
    trap    #15
	sub     #1,D3   decrement loop counter
    bne     next    repeat until D0=0

*-------------------------------------------------------
*------------------Screen Decoration--------------------
*-------------------------------------------------------
decorate:
    move.b  #60, D3
    bsr     endl
out:
    lea     loop_msg,A1
    move.b  #14,D0
    trap    #15
	sub     #1,D3   decrement loop counter
    bne     out	    repeat until D0=0
    bsr     endl
    rts
    
clear_screen: 
    move.b  #11,D0      clear screen
    move.w  #$ff00,D1
    trap    #15
    rts
*-------------------------------------------------------
*------------------------Replay-------------------------
*-------------------------------------------------------
replay:
    bsr     endl
    lea     replay_msg,A1
    move.b  #14,D0
    trap    #15
    
    move.b  #4,D0
    trap    #15

    cmp     #exit,D1
    beq     end         if SR Z register contains 1 beq => Branch Equals
    bsr     gameloop

endl:
    movem.l D0/A1,-(A7)
    move    #14,D0
    lea     crlf,A1
    trap    #15
    movem.l (A7)+,D0/A1
    rts
    
*-------------------------------------------------------
*-------------------Data Delarations--------------------
*-------------------------------------------------------

crlf:           dc.b    $0D,$0A,0
welcome_msg:    dc.b    '************************************************************'
                dc.b    $0D,$0A
                dc.b    'Rabbits vs. Plumbers'
                dc.b    $0D,$0A
                dc.b    '************************************************************'
                dc.b    $0D,$0A,0
potion_msg:     dc.b    'Potion ....'
                dc.b    $0D,$0A
                dc.b    'Enter Potion : ',0
potions_msg:    dc.b    'Number of potions : ',0
weapons_msg:    dc.b    'Each quest need at least 2 Weapons'
                dc.b    $0D,$0A
                dc.b    'minimum requirement is 2 i.e. Sword x 1 and Speer x 1.'
                dc.b    $0D,$0A
                dc.b    'Enter # of weapons : ',0
gameplay_msg:   dc.b    'Make Your Move!!',0
helloWorld_msg: dc.b    'hello world!',0
update_msg:     dc.b    'Update Gameplay !',0
draw_msg:       dc.b    'Draw Screen !',0
hit_msg:        dc.b    'Strike!',0
miss_msg:       dc.b    'Miss!',0
loop_msg:       dc.b    '.',0
player_move_msg: dc.b   '1: Attack'
                 dc.b   $0D,$0A
                 dc.b   '2: Drink potion'
                 dc.b   $0D,$0A
                 dc.b   '3: Block'
                 dc.b   $0D,$0A,0
enemy_health_msg: dc.b  'Enemy Health : ',$0D,$0A,0
next_level_msg    dc.b  'You progress to the next floor',$0D,$0A,0
                
   
replay_msg:     dc.b    'Enter 0 to Quit any other number to replay : ',0
block_msg:     dc.b    'You block your opponents attack! : ',0
hud_msg:        dc.b    'Health : ',0

health:     ds.w    1   Players Health
score:      ds.w    1   Reserve space for score

    end start






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
