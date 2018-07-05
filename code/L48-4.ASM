; Mode X (320x240, 256 colors) system memory to display memory copy
; routine. Uses approach of changing the plane for each pixel copied;
; this is slower than copying all pixels in one plane, then all pixels
; in the next plane, and so on, but it is simpler; besides, images for
; which performance is critical should be stored in off-screen memory
; and copied to the screen via the latches. Copies up to but not
; including the column at SourceEndX and the row at SourceEndY. No
; clipping is performed. C near-callable as:
;
;    void CopySystemToScreenX(int SourceStartX, int SourceStartY,
;       int SourceEndX, int SourceEndY, int DestStartX,
;       int DestStartY, char* SourcePtr, unsigned int DestPageBase,
;       int SourceBitmapWidth, int DestBitmapWidth);

SC_INDEX        equ     03c4h           ;Sequence Controller Index register port
MAP_MASK        equ     02h             ;index in SC of Map Mask register
SCREEN_SEG      equ     0a000h          ;segment of display memory in Mode X

parms   struc
                dw      2 dup (?)       ;pushed BP and return address
SourceStartX    dw      ?               ;X coordinate of upper left corner of source
SourceStartY    dw      ?               ;Y coordinate of upper left corner of source
SourceEndX      dw      ?               ;X coordinate of lower right corner of source
                                        ; (the row at EndX is not copied)
SourceEndY      dw      ?               ;Y coordinate of lower right corner of source
                                        ; (the column at EndY is not copied)
DestStartX      dw      ?               ;X coordinate of upper left corner of dest
DestStartY      dw      ?               ;Y coordinate of upper left corner of dest
SourcePtr       dw      ?               ;pointer in DS to start of bitmap in which
                                        ; source resides
DestPageBase    dw      ?               ;base offset in display memory of page in
                                        ; which dest resides
SourceBitmapWidth dw    ?               ;# of pixels across source bitmap
DestBitmapWidth   dw    ?               ;# of pixels across dest bitmap
                                        ; (must be a multiple of 4)
parms   ends

RectWidth       equ    -2               ;local storage for width of rectangle
LeftMask        equ    -4               ;local storage for left rect edge plane mask
STACK_FRAME_SIZE equ    4

        .model  small
        .code
        public  _CopySystemToScreenX
_CopySystemToScreenX proc    near
        push    bp                      ;preserve caller's stack frame
        mov     bp,sp                   ;point to local stack frame
        sub     sp,STACK_FRAME_SIZE     ;allocate space for local vars
        push    si                      ;preserve caller's register variables
        push    di

        cld
        mov     ax,SCREEN_SEG           ;point ES to display memory
        mov     es,ax
        mov     ax,[bp+SourceBitmapWidth]
        mul     [bp+SourceStartY]       ;top source rect scan line
        add     ax,[bp+SourceStartX]
        add     ax,[bp+SourcePtr]       ;offset of first source rect pixel
        mov     si,ax                   ; in DS

        mov     ax,[bp+DestBitmapWidth]
        shr     ax,1                    ;convert to width in addresses
        shr     ax,1
        mov     [bp+DestBitmapWidth],ax ;remember address width
        mul     [bp+DestStartY]         ;top dest rect scan line
        mov     di,[bp+DestStartX]
        mov     cx,di
        shr     di,1                    ;X/4 = offset of first dest rect pixel in
        shr     di,1                    ; scan line
        add     di,ax                   ;offset of first dest rect pixel in page
        add     di,[bp+DestPageBase]    ;offset of first dest rect pixel
                                        ; in display memory
        and     cl,011b                 ;CL = first dest pixel's plane
        mov     al,11h                  ;upper nibble comes into play when plane wraps
                                        ; from 3 back to 0
        shl     al,cl                   ;set the bit for the first dest pixel's plane
        mov     [bp+LeftMask],al        ; in each nibble to 1

        mov     cx,[bp+SourceEndX]      ;calculate # of pixels across
        sub     cx,[bp+SourceStartX]    ; rect
        jle     CopyDone                ;skip if 0 or negative width
        mov     [bp+RectWidth],cx
        mov     bx,[bp+SourceEndY]
        sub     bx,[bp+SourceStartY]    ;BX = height of rectangle
        jle     CopyDone                ;skip if 0 or negative height
        mov     dx,SC_INDEX             ;point to SC Index register
        mov     al,MAP_MASK
        out     dx,al                   ;point SC Index reg to the Map Mask
        inc     dx                      ;point DX to SC Data reg
CopyRowsLoop:
        mov     ax,[bp+LeftMask]
        mov     cx,[bp+RectWidth]
        push    si                      ;remember the start offset in the source
        push    di                      ;remember the start offset in the dest
CopyScanLineLoop:
        out     dx,al                   ;set the plane for this pixel
        movsb                           ;copy the pixel to the screen
        rol     al,1                    ;set mask for next pixel's plane
        cmc                             ;advance destination address only when
        sbb     di,0                    ; wrapping from plane 3 to plane 0
                                        ; (else undo INC DI done by MOVSB)
        loop    CopyScanLineLoop
        pop     di                      ;retrieve the dest start offset
        add     di,[bp+DestBitmapWidth] ;point to the start of the
                                        ; next scan line of the dest
        pop     si                      ;retrieve the source start offset
        add     si,[bp+SourceBitmapWidth] ;point to the start of the
                                        ; next scan line of the source
        dec     bx                      ;count down scan lines
        jnz     CopyRowsLoop
CopyDone:
        pop     di                      ;restore caller's register variables
        pop     si
        mov     sp,bp                   ;discard storage for local variables
        pop     bp                      ;restore caller's stack frame
        ret
_CopySystemToScreenX endp
        end
