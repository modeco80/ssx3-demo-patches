; patch asm
; (c) 2025 Lily Tsuru <lily@crustywindo.ws>.

.ps2

.create "no_autoreset_patch.bin",0x0041cac4
.org 0x0041cac4
patch:
	; The registers we care about:
	; a0 - cRider* this (we don't care about this yet)
	; a1 - bool bShouldReset
	; a2 - eAutoReset type

	ori t1, t0, 1		; set t1 to 1 (in this case, t1 = t0 | 1 which 
						; will always end up 1)

	bne a2, t0, .ignore	; make sure auto reset type is not equal to 0
	li v0, 0x0			; if it isn't then we simply ignore it

						; detour back to the original game code
	addiu sp, sp, -32	; setup the stack
	j 0x00116fb0		; trampoline back
	sq s0, 0x10(sp)		; set this up so it's good				

.ignore:
	jr ra				; if this is an autoreset and the game is trying to reset
						; ignore it entirely :)	
	nop					; branch delay slot
.close

; TRAMPOLINE
; this trampolines cRider::checkForReset(bool bShouldReset, eAutoReset type)
.create "no_autoreset_trampoline.bin",0x00116fa8
.org 0x00116fa8
trampoline_entry:
	j patch				; jump to patch code
	move t0, zero		; do some register setup while we're here
						; to actually use the branch delay slot
.close