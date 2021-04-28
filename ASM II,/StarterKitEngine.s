#include <avr/io.h>
#include <defines.h>

;****************************
; ScratchPad Assembly
;****************************
.global sample
.section .text.sample
sample:
//	MOV	R0, #0x11		; load value
//	LSL R1, R0, #1		; logical shift 1 bit left
//	LSL	R2, R1, #1		; logical shift 1 bit left
	RET

;****************************
; Infinite GameLoop
;****************************
.global gameloop
.section .text.gameloop
gameloop:
	JMP gameloop;		; jump to gameloop

;****************************
; Turns on onboard LED PD4
;****************************
.global setLedOn
.section .text.setLedOn
setLedOn:
	SBI _SFR_IO_ADDR(PORTD),PD4
	RET

;****************************
; Turns off onboard LED PD4
;****************************
.global setLedOff
.section .text.setLedOff
setLedOff:
	CBI _SFR_IO_ADDR(PORTD),PD4
	RET

;****************************
; Delay for Second
; CLK(CPU) = 1 MHz
;****************************
.global delay
.section .text.delay
delay:
  	LDI  R18, 41
    LDI  R19, 150
    LDI  R20, 128
delay_loop:
	DEC  R20
	BRNE delay_loop
	DEC  R19
	BRNE delay_loop
	DEC  R18
    BRNE delay_loop
    RET

;****************************
; Starter Pack
;****************************
.global startgame
.section .text.startgame
startgame:
	CALL delay
	CALL setLedOn
	CALL delay
	CALL setLedOff
	CALL delay
	RET

;****************************
; Get Health
;****************************
.global getHealth
.section .text.getHealth
getHealth:
	ADD R24,R22
	CLR	R25
	RET

;****************************
; Update the Score
;****************************
.global getScore
.section .text.getScore
getScore:
	ADD R24,R22
	CLR	R25
	RET
