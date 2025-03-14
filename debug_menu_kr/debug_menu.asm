; patch asm for debug menu patch
; (c) 2025 Lily Tsuru <lily@crustywindo.ws>.

.ps2

; PATCH FUNCTION
.create "debug_menu_patch.bin",0x0041cd58
.org 0x0041cd58
entry:
	lui t0,0x004b     		; load address of SSXApp global pointer into t0
	ori t0,t0,0xcbc8
	lw t3, 0(t0) 			; load value of SSXApp pointer into t3

	move t2, zero			; check if the debug button was touched here
	ori t2, zero, 0x0008
	beq a2, t2, .is_debug_menu_id
	lw a0, 0x5c(t3)			; load cGame ptr from SSXApp

.not_debug_menu_id:			; t'was not..
	jr t1					; "return" back via switch table entry, 
							; and detour back to the normal code path
	nop						; ...

.is_debug_menu_id:			; okay, this is it...
	ori a1, zero, 0x0		; first controller? not sure what this param is tbh
	j 0x001fc2b8			; jump to debug menu function (it will jr ra for us)
	mtc1 zero, f12			; zero unknown float thats required?
.close

; TRAMPOLINE
.create "debug_menu_trampoline.bin",0x001b75e4
.org 0x001b75e4
trampoline:
	jal entry				; jump to patch code
	move t1, a0				; save old a0 into t1 (we will need it later)
.close