; template for patch which runs asm in codecave
; (c) 2025 Lily Tsuru <lily@crustywindo.ws>.

.ps2

; TRAMPOLINE FUNCTION
; This code is jumped to by the TRAMPOLINE ENTRY
; and can be put in a static cave. 
.create "trampoline.bin",[TRAMPOLINE_ADDRESS]
.org [TRAMPOLINE_ADDRESS]
trampoline:
	jr ra	; put your own code in here
	nop
.close

; TRAMPOLINE ENTRY
.create "trampoline_entry.bin",[TRAMPOLINE_ENTRY_ADDRESS]
.org [TRAMPOLINE_ENTRY_ADDRESS]
trampoline_entry:
	jal trampoline			; jump to trampoline
	nop						; ...
.close
