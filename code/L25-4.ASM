; Program to illustrate operation of set/reset circuitry in conjunction
;  with CPU data to modify setting of memory that already contains data.
; By Michael Abrash.
;
stack	segment para stack ‘STACK#146;
	db	512 dup(?)
stack	ends
;
EGA_VIDEO_SEGMENT	equ	0a000h	;EGA display memory segment
;
; EGA register equates.
;
SC_INDEX	equ	3c4h	;SC index register
SC_MAP_MASK	equ	2	;SC map mask register
GC_INDEX	equ	3ceh	;GC index register
GC_SET_RESET	equ	0	;GC set/reset register
GC_ENABLE_SET_RESET equ 1	;GC enable set/reset register
;
; Macro to set indexed register INDEX of SC chip to SETTING.
;
SETSC	macro	INDEX, SETTING
	mov	dx,SC_INDEX
	mov	al,INDEX
	out	dx,al
	inc	dx
	mov	al,SETTING
	out	dx,al
	dec	dx
	endm
;
; Macro to set indexed register INDEX of GC chip to SETTING.
;
SETGC	macro	INDEX, SETTING
	mov	dx,GC_INDEX
	mov	al,INDEX
	out	dx,al
	inc	dx
	mov	al,SETTING
	out	dx,al
	dec	dx
	endm
;
cseg	segment para public ‘CODE#146;
	assume	cs:cseg
start	proc	near
;
; Select 640x350 graphics mode.
;
	mov	ax,010h
	int	10h
;
	mov	ax,EGA_VIDEO_SEGMENT
	mov	es,ax			;point to video memory
;
; Draw 18 10-scan-line high horizontal bars in green, 10 scan lines apart.
;
	SETSC	SC_MAP_MASK,02h;map mask setting enables only
; plane 1, the green plane
	sub	di,di;start at beginning of video memory
	mov	al,0ffh
	mov	bp,18;# bars to draw
HorzBarLoop:
	mov	cx,80*10;# bytes per horizontal bar
	rep stosb;draw bar
	add	di,80*10;point to start of next bar
	dec	bp
	jnz	HorzBarLoop
;
; Fill screen with alternating bars of red and brown, using CPU data
; to set plane 1 and set/reset to set planes 0, 2 & 3.
;
	SETSC	SC_MAP_MASK,0fh		;must set map mask to enable all
					; planes, so set/reset values can
					; be written to planes 0, 2 & 3
					; and CPU data can be written to
					; plane 1 (the green plane)
	SETGC	GC_ENABLE_SET_RESET,0dh	   ;CPU data to planes 0, 2 & 3 will be
					   ; replaced by set/reset value
	SETGC	GC_SET_RESET,04h	;set/reset value is 0ffh for plane 2
					; (the red plane) and 0 for other
					; planes
	sub	di,di
	mov	cx,80*350/2		;# words per screen
	mov	ax,07e0h		;CPU data controls only plane 1;
					; set/reset controls other planes
	rep stosw			;perform fill (affects all planes)
;
; Turn off set/reset.
;
	SETGC	GC_ENABLE_SET_RESET,0
;
; Wait for a keystroke.
;
	mov	ah,1
	int	21h
;
; Restore text mode.
;
	mov	ax,03h
	int	10h
;
; Exit to DOS.
;
	mov	ah,4ch
	int	21h
start	endp
cseg	ends
	end	start
