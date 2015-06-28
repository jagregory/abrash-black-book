; Program to illustrate one use of write mode 2 of the VGA and EGA by
; animating the image of an "A" drawn by copying it from a chunky
; bit-map in system memory to a planar bit-map in VGA or EGA memory.
;
; Assemble with MASM or TASM
;
; By Michael Abrash
;
Stack   segment para stack 'STACK'
        db      512 dup(0)
Stack   ends

SCREEN_WIDTH_IN_BYTES   equ     80
DISPLAY_MEMORY_SEGMENT  equ     0a000h

SC_INDEX        equ     3c4h    ;Sequence Controller Index register
MAP_MASK        equ     2       ;index of Map Mask register
GC_INDEX        equ     03ceh   ;Graphics Controller Index reg
GRAPHICS_MODE   equ     5       ;index of Graphics Mode reg
BIT_MASK        equ     8       ;index of Bit Mask reg

Data    segment para common 'DATA'
;
; Current location of "A" as it is animated across the screen.
;
CurrentX        dw      ?
CurrentY        dw      ?
RemainingLength dw      ?
;
; Chunky bit-map image of a yellow "A" on a bright blue background
;
AImage          label   byte
                dw      13, 13          ;width, height in pixels
                db      000h, 000h, 000h, 000h, 000h, 000h, 000h
                db      009h, 099h, 099h, 099h, 099h, 099h, 000h
                db      009h, 099h, 099h, 099h, 099h, 099h, 000h
                db      009h, 099h, 099h, 0e9h, 099h, 099h, 000h
                db      009h, 099h, 09eh, 0eeh, 099h, 099h, 000h
                db      009h, 099h, 0eeh, 09eh, 0e9h, 099h, 000h
                db      009h, 09eh, 0e9h, 099h, 0eeh, 099h, 000h
                db      009h, 09eh, 0eeh, 0eeh, 0eeh, 099h, 000h
                db      009h, 09eh, 0e9h, 099h, 0eeh, 099h, 000h
                db      009h, 09eh, 0e9h, 099h, 0eeh, 099h, 000h
                db      009h, 099h, 099h, 099h, 099h, 099h, 000h
                db      009h, 099h, 099h, 099h, 099h, 099h, 000h
                db      000h, 000h, 000h, 000h, 000h, 000h, 000h
Data    ends

Code    segment para public 'CODE'
        assume  cs:Code, ds:Data
Start   proc    near
        mov     ax,Data
        mov     ds,ax
        mov     ax,10h
        int     10h             ;select video mode 10h (640x350)
;
; Prepare for animation.
;
        mov     [CurrentX],0
        mov     [CurrentY],200
        mov     [RemainingLength],600   ;move 600 times
;
; Animate, repeating RemainingLength times. It's unnecessary to erase
; the old image, since the one pixel of blank fringe around the image
; erases the part of the old image not overlapped by the new image.
;
AnimationLoop:
        mov     bx,[CurrentX]
        mov     cx,[CurrentY]
        mov     si,offset AImage
        call    DrawFromChunkyBitmap    ;draw the "A" image
        inc     [CurrentX]              ;move one pixel to the right

        mov     cx,0                    ;delay so we don't move the
DelayLoop:                              ; image too fast; adjust as
                                        ; needed
        loop    DelayLoop

        dec     [RemainingLength]
        jnz     AnimationLoop
;
; Wait for a key before returning to text mode and ending.
;
        mov     ah,01h
        int     21h
        mov     ax,03h
        int     10h
        mov     ah,4ch
        int     21h
Start   endp
;
; Draw an image stored in a chunky-bit map into planar VGA/EGA memory
; at the specified location.
;
; Input:
;       BX = X screen location at which to draw the upper-left corner
;               of the image
;       CX = Y screen location at which to draw the upper-left corner
;               of the image
;       DS:SI = pointer to chunky image to draw, as follows:
;               word at 0: width of image, in pixels
;               word at 2: height of image, in pixels
;               byte at 4: msb/lsb = first & second chunky pixels,
;                       repeating for the remainder of the scan line
;                       of the image, then for all scan lines. Images
;                       with odd widths have an unused null nibble
;                       padding each scan line out to a byte width
;
; AX, BX, CX, DX, SI, DI, ES destroyed.
;
DrawFromChunkyBitmap    proc    near
        cld
;
; Select write mode 2.
;
        mov     dx,GC_INDEX
        mov     al,GRAPHICS_MODE
        out     dx,al
        inc     dx
        mov     al,02h
        out     dx,al
;
; Enable writes to all 4 planes.
;
        mov     dx,SC_INDEX
        mov     al,MAP_MASK
        out     dx,al
        inc     dx
        mov     al,0fh
        out     dx,al
;
; Point ES:DI to the display memory byte in which the first pixel
; of the image goes, with AH set up as the bit mask to access that
; pixel within the addressed byte.
;
        mov     ax,SCREEN_WIDTH_IN_BYTES
        mul     cx              ;offset of start of top scan line
        mov     di,ax
        mov     cl,bl
        and     cl,111b
        mov     ah,80h          ;set AH to the bit mask for the
        shr     ah,cl           ; initial pixel
        shr     bx,1
        shr     bx,1
        shr     bx,1            ;X in bytes
        add     di,bx           ;offset of upper-left byte of image
        mov     bx,DISPLAY_MEMORY_SEGMENT
        mov     es,bx           ;ES:DI points to the byte at which the
                                ; upper left of the image goes
;
; Get the width and height of the image.
;
        mov     cx,[si]         ;get the width
        inc     si
        inc     si
        mov     bx,[si]         ;get the height
        inc     si
        inc     si
        mov     dx,GC_INDEX
        mov     al,BIT_MASK
        out     dx,al           ;leave the GC Index register pointing
        inc     dx              ; to the Bit Mask register
RowLoop:

        push    ax              ;preserve the left column's bit mask
        push    cx              ;preserve the width
        push    di              ;preserve the destination offset

ColumnLoop:
        mov     al,ah
        out     dx,al           ;set the bit mask to draw this pixel
        mov     al,es:[di]      ;load the latches
        mov     al,[si]         ;get the next two chunky pixels
        shr     al,1
        shr     al,1
        shr     al,1
        shr     al,1            ;move the first pixel into the lsb
        stosb                   ;draw the first pixel
        ror     ah,1            ;move mask to next pixel position
        jc      CheckMorePixels ;is next pixel in the adjacent byte?
        dec     di              ;no

CheckMorePixels:
        dec     cx              ;see if there are any more pixels
        jz      AdvanceToNextScanLine ; across in image
        mov     al,ah
        out     dx,al           ;set the bit mask to draw this pixel
        mov     al,es:[di]      ;load the latches
        lodsb                   ;get the same two chunky pixels again
                                ; and advance pointer to the next
                                ; two pixels
        stosb                   ;draw the second of the two pixels
        ror     ah,1            ;move mask to next pixel position
        jc      CheckMorePixels2;is next pixel in the adjacent byte?
        dec     di              ;no

CheckMorePixels2:
        loop    ColumnLoop      ;see if there are any more pixels
                                ; across in the image
        jmp     short CheckMoreScanLines

AdvanceToNextScanLine:
        inc     si              ;advance to the start of the next
                                ; scan line in the image

CheckMoreScanLines:
        pop     di              ;get back the destination offset
        pop     cx              ;get back the width
        pop     ax              ;get back the left column's bit mask
        add     di,SCREEN_WIDTH_IN_BYTES
                                ;point to the start of the next scan
                                ; line of the image
        dec     bx              ;see if there are any more scan lines
        jnz     RowLoop         ; in the image
        ret
DrawFromChunkyBitmap    endp
Code    ends
        end     Start
