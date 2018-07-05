; Mode X (320x240, 256 colors) write pixel routine. Works on all VGAs.
; No clipping is performed.
; C near-callable as:
;
;    void WritePixelX(int X, int Y, unsigned int PageBase, int Color);

SC_INDEX        equ     03c4h   ;Sequence Controller Index
MAP_MASK        equ     02h     ;index in SC of Map Mask register
SCREEN_SEG      equ     0a000h  ;segment of display memory in mode X
SCREEN_WIDTH    equ     80      ;width of screen in bytes from one scan line
                                ; to the next

parms   struc
        dw      2 dup (?)       ;pushed BP and return address
X       dw      ?               ;X coordinate of pixel to draw
Y       dw      ?               ;Y coordinate of pixel to draw
PageBase dw     ?               ;base offset in display memory of page in
                                ; which to draw pixel
Color   dw      ?               ;color in which to draw pixel
parms   ends

        .model  small
        .code
        public  _WritePixelX
_WritePixelX    proc    near
        push    bp              ;preserve caller's stack frame
        mov     bp,sp           ;point to local stack frame

        mov     ax,SCREEN_WIDTH
        mul     [bp+Y]          ;offset of pixel's scan line in page
        mov     bx,[bp+X]
        shr     bx,1
        shr     bx,1            ;X/4 = offset of pixel in scan line
        add     bx,ax           ;offset of pixel in page
        add     bx,[bp+PageBase] ;offset of pixel in display memory
        mov     ax,SCREEN_SEG
        mov     es,ax           ;point ES:BX to the pixel's address

        mov     cl,byte ptr [bp+X]
        and     cl,011b         ;CL = pixel's plane
        mov     ax,0100h + MAP_MASK ;AL = index in SC of Map Mask reg
        shl     ah,cl           ;set only the bit for the pixel's plane to 1
        mov     dx,SC_INDEX     ;set the Map Mask to enable only the
        out     dx,ax           ; pixel's plane

        mov     al,byte ptr [bp+Color]
        mov     es:[bx],al      ;draw the pixel in the desired color

        pop     bp              ;restore caller's stack frame
        ret
_WritePixelX    endp
        end
