; patch asm
; (c) 2025 Lily Tsuru <lily@crustywindo.ws>.

.ps2

.create "trampoline.bin",0x0041cac4
.org 0x0041cac4
trampoline:
	; this trampolines cRider::checkForReset(bool bShouldReset, eAutoResetType type)
	; a0 - cRider* this (we don't care about this yet)
	; a1 - bool bShouldReset
	; a2 - eAutoResetType type

	ori t1, t0, 1		; set t1 to 1 (in this case, t1 = t0 | 1 which 
				; will always end up 1)

	; TODO: uber fall recovery has an autoreset, so we should also check
	; for that and fall back for that
	beq a2, t0, .detour	; make sure auto reset type is not equal to 0
	nop			; if it is, detour back to the original game code
				; (since it's the player resetting, not the game)

	jr ra			; if this is an autoreset and the game is trying to reset
	li v0, 0x0		; just return 0 and ignore it entirely :)
	
.detour:			; detour back to the original implementation
	addiu sp, sp, -32	; setup the stack
	j 0x00116fb0		; trampoline back
	sq s0, 0x10(sp)		; set this up so it's good
.close


.create "trampoline_entry.bin",0x00116fa8
.org 0x00116fa8
trampoline_entry:
	j trampoline		; jump to trampoline
	move t0, zero		; do some register setup while we're here
				; to actually use the branch delay slot
.close