; Program to illustrate operation of Map Mask register when drawing
;  to memory that already contains data.
; By Michael Abrash.
;
stack	segment para stack 'STACK'
	db	512 dup(?)
stack	ends
;
EGA_VIDEO_SEGMENT	equ	0a000h	;EGA display memory segment
;
; EGA register equates.
;
SC_INDEX	equ	3c4h	;SC index register
SC_MAP_MASK	equ	2	;SC map mask register
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
cseg	segment para public 'CODE'
	assume	cs:cseg
start	proc	near
;
; Select 640x480 graphics mode.
;
	mov	ax,012h
	int	10h
;
	mov	ax,EGA_VIDEO_SEGMENT
	mov	es,ax			;point to video memory
;
; Draw 24 10-scan-line high horizontal bars in green, 10 scan lines apart.
;
	SETSC	SC_MAP_MASK,02h		;map mask setting enables only
					; plane 1, the green plane
	sub	di,di			;start at beginning of video memory
	mov	al,0ffh
	mov	bp,24			;# bars to draw
HorzBarLoop:
	mov	cx,80*10		;# bytes per horizontal bar
	rep stosb			;draw bar
	add	di,80*10		;point to start of next bar
	dec	bp
	jnz	HorzBarLoop
;
; Fill screen with blue, using Map Mask register to enable writes
; to blue plane only.
;
	SETSC	SC_MAP_MASK,01h		;map mask setting enables only
					; plane 0, the blue plane
	sub	di,di
	mov	cx,80*480		;# bytes per screen
	mov	al,0ffh
	rep stosb			;perform fill (affects only
					; plane 0, the blue plane)
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
