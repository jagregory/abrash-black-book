; Program to illustrate the color mapping capabilities of the
; EGA's palette registers.
;
VGA_SEGMENT     equ     0a000h
SC_INDEX        equ     3c4h            ;Sequence Controller Index register
MAP_MASK        equ     2               ;Map Mask register index in SC
BAR_HEIGHT      equ     14              ;height of each bar
TOP_BAR         equ     BAR_HEIGHT*6    ;start the bars down a bit to
                                        ; leave room for text
;
stack   segment para stack 'STACK'
        db      512 dup (?)
stack   ends
;
Data    segment word 'DATA'
KeyMsg  db      'Press any key to see the next color set. '
        db      'There are 64 color sets in all.'
        db      0dh, 0ah, 0ah, 0ah, 0ah
        db      13 dup (' '), 'Attribute'
        db      38 dup (' '), 'Color$'
;
; Used to label the attributes of the color bars.
;
AttributeNumbers        label   byte
x=      0
        rept    16
if x lt 10
        db      '0', x+'0', 'h', 0ah, 8, 8, 8
else
        db      '0', x+'A'-10, 'h', 0ah, 8, 8, 8
endif
x=      x+1
        endm
        db      '$'
;
; Used to label the colors of the color bars. (Color values are
; filled in on the fly.)
;
ColorNumbers    label   byte
        rept    16
        db      '000h', 0ah, 8, 8, 8, 8
        endm
COLOR_ENTRY_LENGTH      equ     ($-ColorNumbers)/16
        db      '$'
;
CurrentColor    db      ?
;
; Space for the array of 16 colors we'll pass to the BIOS, plus
; an overscan setting of black.
;
ColorTable      db      16 dup (?), 0
Data    ends
;
Code    segment
        assume  cs:Code, ds:Data
Start   proc    near
        cld
        mov     ax,Data
        mov     ds,ax
;
; Go to hi-res graphics mode.
;
        mov     ax,10h          ;AH = 0 means mode set, AL = 10h selects
                                ; hi-res graphics mode
        int     10h             ;BIOS video interrupt
;
; Put up relevant text.
;
        mov     ah,9            ;DOS print string function
        mov     dx,offset KeyMsg
        int     21h
;
; Put up the color bars, one in each of the 16 possible pixel values
; (which we'll call attributes).
;
        mov     cx,16           ;we'll put up 16 color bars
        sub     al,al           ;start with attribute 0
BarLoop:
        push    ax
        push    cx
        call    BarUp
        pop     cx
        pop     ax
        inc     ax              ;select the next attribute
        loop    BarLoop
;
; Put up the attribute labels.
;
        mov     ah,2            ;video interrupt set cursor position function
        sub     bh,bh           ;page 0
        mov     dh,TOP_BAR/14   ;counting in character rows, match to
                                ; top of first bar, counting in
                                ; scan lines
        mov     dl,16           ;just to left of bars
        int     10h
        mov     ah,9            ;DOS print string function
        mov     dx,offset AttributeNumbers
        int     21h
;
; Loop through the color set, one new setting per keypress.
;
        mov     [CurrentColor],0        ;start with color zero
ColorLoop:
;
; Set the palette registers to the current color set, consisting
; of the current color mapped to attribute 0, current color + 1
; mapped to attribute 1, and so on.
;
        mov     al,[CurrentColor]
        mov     bx,offset ColorTable
        mov     cx,16           ;we have 16 colors to set
PaletteSetLoop:
        and     al,3fh          ;limit to 6-bit color values
        mov     [bx],al         ;built the 16-color table used for setting
        inc     bx              ; the palette registers
        inc     ax
        loop    PaletteSetLoop
        mov     ah,10h          ;video interrupt palette function
        mov     al,2            ;subfunction to set all 16 palette registers
                                ; and overscan at once
        mov     dx,offset ColorTable
        push    ds
        pop     es              ;ES:DX points to the color table
        int     10h             ;invoke the video interrupt to set the palette
;
; Put up the color numbers, so we can see how attributes map
; to color values, and so we can see how each color # looks
; (at least on this particular screen).
;
        call    ColorNumbersUp
;
; Wait for a keypress, so they can see this color set.
;
WaitKey:
        mov     ah,8            ;DOS input without echo function
        int     21h
;
; Advance to the next color set.
;
        mov     al,[CurrentColor]
        inc     ax
        mov     [CurrentColor],al
        cmp     al,64
        jbe     ColorLoop
;
; Restore text mode.
;
        mov     ax,3
        int     10h
;
; Done.
;
Done:
        mov     ah,4ch          ;DOS terminate function
        int     21h
;
; Puts up a bar consisting of the specified attribute (pixel value),
; at a vertical position corresponding to the attribute.
;
; Input: AL = attribute
;
BarUp   proc    near
        mov     dx,SC_INDEX
        mov     ah,al
        mov     al,MAP_MASK
        out     dx,al
        inc     dx
        mov     al,ah
        out     dx,al           ;set the Map Mask register to produce
                                ; the desired color
        mov     ah,BAR_HEIGHT
        mul     ah              ;row of top of bar
        add     ax,TOP_BAR      ;start a few lines down to leave room for
                                ; text
        mov     dx,80           ;rows are 80 bytes long
        mul     dx              ;offset in bytes of start of scan line bar
                                ; starts on
        add     ax,20           ;offset in bytes of upper left corner of bar
        mov     di,ax
        mov     ax,VGA_SEGMENT
        mov     es,ax           ;ES:DI points to offset of upper left
                                ; corner of bar
        mov     dx,BAR_HEIGHT
        mov     al,0ffh
BarLineLoop:
        mov     cx,40           ;make the bars 40 wide
        rep     stosb           ;do one scan line of the bar
        add     di,40           ;point to the start of the next scan line
                                ; of the bar
        dec     dx
        jnz     BarLineLoop
        ret
BarUp   endp
;
; Converts AL to a hex digit in the range 0-F.
;
BinToHexDigit   proc    near
        cmp     al,9
        ja      IsHex
        add     al,'0'
        ret
IsHex:
        add     al,'A'-10
        ret
BinToHexDigit   endp
;
; Displays the color values generated by the color bars given the
; current palette register settings off to the right of the color
; bars.
;
ColorNumbersUp  proc    near
        mov     ah,2            ;video interrupt set cursor position function
        sub     bh,bh           ;page 0
        mov     dh,TOP_BAR/14   ;counting in character rows, match to
                                ; top of first bar, counting in
                                ; scan lines
        mov     dl,20+40+1      ;just to right of bars
        int     10h
        mov     al,[CurrentColor]       ;start with the current color
        mov     bx,offset ColorNumbers+1
                                ;build the color number text string on the fly
        mov     cx,16           ;we've got 16 colors to do
ColorNumberLoop:
        push    ax              ;save the color #
        and     al,3fh          ;limit to 6-bit color values
        shr     al,1
        shr     al,1
        shr     al,1
        shr     al,1            ;isolate the high nibble of the
                                ; color #
        call    BinToHexDigit   ;convert the high color # nibble
        mov     [bx],al         ; and put it into the text
        pop     ax              ;get back the color #
        push    ax              ;save the color #
        and     al,0fh          ;isolate the low color # nibble
        call    BinToHexDigit   ;convert the low nibble of the
                                ; color # to ASCII
        mov     [bx+1],al       ; and put it into the text
        add     bx,COLOR_ENTRY_LENGTH   ;point to the next entry
        pop     ax              ;get back the color #
        inc     ax              ;next color #
        loop    ColorNumberLoop
        mov     ah,9            ;DOS print string function
        mov     dx,offset ColorNumbers
        int     21h             ;put up the attribute numbers
        ret
ColorNumbersUp  endp
;
Start   endp
Code    ends
        end     Start
