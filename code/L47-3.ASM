; Mode X (320x240, 256 colors) read pixel routine. Works on all VGAs.
; No clipping is performed.
; C near-callable as:
;
;    unsigned int ReadPixelX(int X, int Y, unsigned int PageBase);

GC_INDEX        equ     03ceh   ;Graphics Controller Index
READ_MAP        equ     04h     ;index in GC of the Read Map register
SCREEN_SEG      equ     0a000h  ;segment of display memory in mode X
SCREEN_WIDTH    equ     80      ;width of screen in bytes from one scan line
                                ; to the next
parms   struc
        dw      2 dup (?)       ;pushed BP and return address
X       dw      ?               ;X coordinate of pixel to read
Y       dw      ?               ;Y coordinate of pixel to read
PageBase dw     ?               ;base offset in display memory of page from
                                ; which to read pixel
parms   ends

        .model  small
        .code
        public  _ReadPixelX
_ReadPixelX     proc    near
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

        mov     ah,byte ptr [bp+X]
        and     ah,011b         ;AH = pixel's plane
        mov     al,READ_MAP     ;AL = index in GC of the Read Map reg
        mov     dx,GC_INDEX     ;set the Read Map to read the pixel's
        out     dx,ax           ; plane

        mov     al,es:[bx]      ;read the pixel's color
        sub     ah,ah           ;convert it to an unsigned int

        pop     bp              ;restore caller's stack frame
        ret
_ReadPixelX     endp
        end
