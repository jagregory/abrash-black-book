; Program to illustrate operation of ALUs and latches of the VGA's
;  Graphics Controller.  Draws a variety of patterns against
;  a horizontally striped background, using each of the 4 available
;  logical functions (data unmodified, AND, OR, XOR) in turn to combine
;  the images with the background.
; By Michael Abrash.
;
stack	segment para stack ‘STACK'
	db	512 dup(?)
stack	ends
;
VGA_VIDEO_SEGMENT	equ	0a000h	;VGA display memory segment
SCREEN_HEIGHT		equ	350
SCREEN_WIDTH_IN_BYTES	equ	80
DEMO_AREA_HEIGHT	equ	336	;# of scan lines in area
					; logical function operation
					; is demonstrated in
DEMO_AREA_WIDTH_IN_BYTES equ	40	;width in bytes of area
					; logical function operation
					; is demonstrated in
VERTICAL_BOX_WIDTH_IN_BYTES equ 10	;width in bytes of the box used to
					; demonstrate each logical function
;
; VGA register equates.
;
GC_INDEX	equ	3ceh	;GC index register
GC_ROTATE	equ	3	;GC data rotate/logical function
				; register index
GC_MODE		equ	5	;GC mode register index
;
dseg	segment para common ‘DATA'
;
; String used to label logical functions.
;
LabelString	label	byte
	db	‘UNMODIFIED	 AND	   OR	     XOR   '
LABEL_STRING_LENGTH	equ	$-LabelString
;
; Strings used to label fill patterns.
;
FillPatternFF	db	‘Fill Pattern: 0FFh'
FILL_PATTERN_FF_LENGTH	equ	$ - FillPatternFF
FillPattern00	db	‘Fill Pattern: 000h'
FILL_PATTERN_00_LENGTH	equ	$ - FillPattern00
FillPatternVert db	‘Fill Pattern: Vertical Bar'
FILL_PATTERN_VERT_LENGTH	equ	$ - FillPatternVert
FillPatternHorz db	‘Fill Pattern: Horizontal Bar'
FILL_PATTERN_HORZ_LENGTH equ	$ - FillPatternHorz
;
dseg	ends
;
; Macro to set indexed register INDEX of GC chip to SETTING.
;
SETGC	macro	INDEX, SETTING
	mov	dx,GC_INDEX
	mov	ax,(SETTING SHL 8) OR INDEX
	out	dx,ax
	endm
;
;
; Macro to call BIOS write string function to display text string
;  TEXT_STRING, of length TEXT_LENGTH, at location ROW,COLUMN.
;
TEXT_UP macro	TEXT_STRING, TEXT_LENGTH, ROW, COLUMN
	mov	ah,13h			;BIOS write string function
	mov	bp,offset TEXT_STRING	;ES:BP points to string
	mov	cx,TEXT_LENGTH
	mov	dx,(ROW SHL 8) OR COLUMN	;position
	sub	al,al		;string is chars only, cursor not moved
	mov	bl,7		;text attribute is white (light gray)
	int	10h
	endm
;
cseg	segment para public ‘CODE'
	assume	cs:cseg, ds:dseg
start	proc	near
	mov	ax,dseg
	mov	ds,ax
;
; Select 640x350 graphics mode.
;
	mov	ax,010h
	int	10h
;
; ES points to VGA memory.
;
	mov	ax,VGA_VIDEO_SEGMENT
	mov	es,ax
;
; Draw background of horizontal bars.
;
	mov	dx,SCREEN_HEIGHT/4
				;# of bars to draw (each 4 pixels high)
	sub	di,di		;start at offset 0 in display memory
	mov	ax,0ffffh	;fill pattern for light areas of bars
	mov	bx,DEMO_AREA_WIDTH_IN_BYTES / 2 ;length of each bar
	mov	si,SCREEN_WIDTH_IN_BYTES - DEMO_AREA_WIDTH_IN_BYTES
	mov	bp,(SCREEN_WIDTH_IN_BYTES * 3) - DEMO_AREA_WIDTH_IN_BYTES
BackgroundLoop:
	mov	cx,bx		;length of bar
    rep stosw			;draw top half of bar
	add	di,si		;point to start of bottom half of bar
	mov	cx,bx		;length of bar
    rep stosw			;draw bottom half of bar
	add	di,bp		;point to start of top of next bar
	dec	dx
	jnz	BackgroundLoop
;
; Draw vertical boxes filled with a variety of fill patterns
;  using each of the 4 logical functions in turn.
;
	SETGC	GC_ROTATE, 0		;select data unmodified
					; logical function...
	mov	di,0
	call	DrawVerticalBox		;...and draw box
;
	SETGC	GC_ROTATE, 08h		;select AND logical function...
	mov	di,10
	call	DrawVerticalBox		;...and draw box
;
	SETGC	GC_ROTATE, 10h		;select OR logical function...
	mov	di,20
	call	DrawVerticalBox		;...and draw box
;
	SETGC	GC_ROTATE, 18h		;select XOR logical function...
	mov	di,30
	call	DrawVerticalBox		;...and draw box
;
; Reset the logical function to data unmodified, the default state.
;
	SETGC	GC_ROTATE, 0
;
; Label the screen.
;
	push	ds
	pop	es	;strings we'll display are passed to BIOS
			; by pointing ES:BP to them
;
; Label the logical functions, using the VGA BIOS's
;  write string function.
;
	TEXT_UP LabelString, LABEL_STRING_LENGTH, 24, 0
;
; Label the fill patterns, using the VGA BIOS's
;  write string function.
;
	TEXT_UP FillPatternFF, FILL_PATTERN_FF_LENGTH, 3, 42
	TEXT_UP FillPattern00, FILL_PATTERN_00_LENGTH, 9, 42
	TEXT_UP FillPatternVert, FILL_PATTERN_VERT_LENGTH, 15, 42
	TEXT_UP FillPatternHorz, FILL_PATTERN_HORZ_LENGTH, 21, 42
;
; Wait until a key's been hit to reset screen mode & exit.
;
WaitForKey:
	mov	ah,1
	int	16h
	jz	WaitForKey
;
; Finished.  Clear key, reset screen mode and exit.
;
Done:
	mov	ah,0	;clear key that we just detected
	int	16h
;
	mov	ax,3	;reset to text mode
	int	10h
;
	mov	ah,4ch	;exit to DOS
	int	21h
;
start	endp
;
; Subroutine to draw a box 80x336 in size, using currently selected
;  logical function, with upper left corner at the display memory offset
;  in DI.  Box is filled with four patterns.  Top quarter of area is
;  filled with 0FFh (solid) pattern, next quarter is filled with 00h
;  (empty) pattern, next quarter is filled with 33h (double pixel wide
;  vertical bar) pattern, and bottom quarter is filled with double pixel
;  high horizontal bar pattern.
;
; Macro to draw a column of the specified width in bytes, one-quarter
;  of the height of the box, with the specified fill pattern.
;
DRAW_BOX_QUARTER	macro	FILL, WIDTH
	local	RowLoop, ColumnLoop
	mov	al,FILL			;fill pattern
	mov	dx,DEMO_AREA_HEIGHT / 4 ;1/4 of the full box height
RowLoop:
	mov	cx,WIDTH
ColumnLoop:
	mov	ah,es:[di]	;load display memory contents into
				; GC latches (we don't actually care
				; about value read into AH)
	stosb			;write pattern, which is logically
				; combined with latch contents for each
				; plane and then written to display
				; memory
	loop	ColumnLoop
	add	di,SCREEN_WIDTH_IN_BYTES - WIDTH
				;point to start of next line down in box
	dec	dx
	jnz	RowLoop
	endm
;
DrawVerticalBox proc	near
	DRAW_BOX_QUARTER	0ffh, VERTICAL_BOX_WIDTH_IN_BYTES
					;first fill pattern: solid fill
	DRAW_BOX_QUARTER	0, VERTICAL_BOX_WIDTH_IN_BYTES
					;second fill pattern: empty fill
	DRAW_BOX_QUARTER	033h, VERTICAL_BOX_WIDTH_IN_BYTES
					;third fill pattern: double-pixel
					; wide vertical bars
	mov	dx,DEMO_AREA_HEIGHT / 4 / 4
				;fourth fill pattern: horizontal bars in
				; sets of 4 scan lines
	sub	ax,ax
	mov	si,VERTICAL_BOX_WIDTH_IN_BYTES	;width of fill area
HorzBarLoop:
	dec	ax		;0ffh fill (smaller to do word than byte DEC)
	mov	cx,si		;width to fill
HBLoop1:
	mov	bl,es:[di]	;load latches (don't care about value)
	stosb			;write solid pattern, through ALUs
	loop	HBLoop1
	add	di,SCREEN_WIDTH_IN_BYTES - VERTICAL_BOX_WIDTH_IN_BYTES
	mov	cx,si		;width to fill
HBLoop2:
	mov	bl,es:[di]	;load latches
	stosb			;write solid pattern, through ALUs
	loop	HBLoop2
	add	di,SCREEN_WIDTH_IN_BYTES - VERTICAL_BOX_WIDTH_IN_BYTES
	inc	ax		;0 fill (smaller to do word than byte DEC)
	mov	cx,si		;width to fill
HBLoop3:
	mov	bl,es:[di]	;load latches
	stosb			;write empty pattern, through ALUs
	loop	HBLoop3
	add	di,SCREEN_WIDTH_IN_BYTES - VERTICAL_BOX_WIDTH_IN_BYTES
	mov	cx,si		;width to fill
HBLoop4:
	mov	bl,es:[di]	;load latches
	stosb			;write empty pattern, through ALUs
	loop	HBLoop4
	add	di,SCREEN_WIDTH_IN_BYTES - VERTICAL_BOX_WIDTH_IN_BYTES
	dec	dx
	jnz	HorzBarLoop
;
	ret
DrawVerticalBox endp
cseg	ends
	end	start
