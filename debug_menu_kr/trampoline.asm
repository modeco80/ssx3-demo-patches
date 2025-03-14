; patch asm for debug menu patch
; (c) 2025 Lily Tsuru <lily@crustywindo.ws>.

.ps2

; TRAMPOLINE FUNCTION
; This is 15*4 bytes long, although in the space I've found 
; there's about 25*4 bytes extra space in this cave (past the ones I'm using here)
.create "trampoline.bin",0x0041cd58
.org 0x0041cd58
trampoline:
	lui t0,0x004b     		; load address of SSXApp global pointer into t0
	ori t0,t0,0xcbc8
	move t1, a0			; save old a0 into t1 (we will need it later)
	lw t3, 0(t0) 			; load value of SSXApp pointer into t3

	move t2, zero			; check if the debug button was touched here
	ori t2, zero, 0x0008
	beq a2, t2, .is_debug_menu_id
	nop				
.not_debug_menu_id:			; t'was not..
	jr t1				; "return" back via switch table entry, 
					; and detour back to the normal code path
	nop				; ...

.is_debug_menu_id:			; okay, this is it...
	lw a0, 0x5c(t3)			; load cGame ptr from SSXApp
	ori a1, zero, 0x0		; first controller? not sure what this param is tbh
	mtc1 zero, f12			; zero unknown float thats required?
	j 0x001fc2b8			; jump to debug menu function (it will jr ra for us)
	nop				; ...
.close

; TRAMPOLINE ENTRY
.create "trampoline_entry.bin",0x001b75e4
.org 0x001b75e4
trampoline_entry:
	jal trampoline			; jump to trampoline
	nop				; ...
.close