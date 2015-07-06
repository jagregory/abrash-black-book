; Mode X (320x240, 256 colors) rectangle fill routine. Works on all
; VGAs. Uses slow approach that selects the plane explicitly for each
; pixel. Fills up to but not including the column at EndX and the row
; at EndY. No clipping is performed.
; C near-callable as:
;
;    void FillRectangleX(int StartX, int StartY, int EndX, int EndY,
;       unsigned int PageBase, int Color);

SC_INDEX        equ     03c4h   ;Sequence Controller Index
MAP_MASK        equ     02h     ;index in SC of Map Mask register
SCREEN_SEG      equ     0a000h  ;segment of display memory in mode X
SCREEN_WIDTH    equ     80      ;width of screen in bytes from one scan line
                                ; to the next
parms   struc
        dw      2 dup (?)       ;pushed BP and return address
StartX  dw      ?               ;X coordinate of upper left corner of rect
StartY  dw      ?               ;Y coordinate of upper left corner of rect
EndX    dw      ?               ;X coordinate of lower right corner of rect
                                ; (the row at EndX is not filled)
EndY    dw      ?               ;Y coordinate of lower right corner of rect
                                ; (the column at EndY is not filled)
PageBase dw     ?               ;base offset in display memory of page in
                                ; which to fill rectangle
Color   dw      ?               ;color in which to draw pixel
parms   ends

        .model  small
        .code
        public  _FillRectangleX
_FillRectangleX proc    near
        push    bp              ;preserve caller's stack frame
        mov     bp,sp           ;point to local stack frame
        push    si              ;preserve caller's register variables
        push    di

        mov     ax,SCREEN_WIDTH
        mul     [bp+StartY]     ;offset in page of top rectangle scan line
        mov     di,[bp+StartX]
        shr     di,1
        shr     di,1            ;X/4 = offset of first rectangle pixel in scan
                                ; line
        add     di,ax           ;offset of first rectangle pixel in page
        add     di,[bp+PageBase] ;offset of first rectangle pixel in
                                ; display memory
        mov     ax,SCREEN_SEG
        mov     es,ax           ;point ES:DI to the first rectangle pixel's
                                ; address
        mov     dx,SC_INDEX     ;set the Sequence Controller Index to
        mov     al,MAP_MASK     ; point to the Map Mask register
        out     dx,al
        inc     dx              ;point DX to the SC Data register
        mov     cl,byte ptr [bp+StartX]
        and     cl,011b         ;CL = first rectangle pixel's plane
        mov     al,01h
        shl     al,cl           ;set only the bit for the pixel's plane to 1
        mov     ah,byte ptr [bp+Color] ;color with which to fill
        mov     bx,[bp+EndY]
        sub     bx,[bp+StartY]  ;BX = height of rectangle
        jle     FillDone        ;skip if 0 or negative height
        mov     si,[bp+EndX]
        sub     si,[bp+StartX]  ;CX = width of rectangle
        jle     FillDone        ;skip if 0 or negative width
FillRowsLoop:
        push    ax              ;remember the plane mask for the left edge
        push    di              ;remember the start offset of the scan line
        mov     cx,si           ;set count of pixels in this scan line
FillScanLineLoop:
        out     dx,al           ;set the plane for this pixel
        mov     es:[di],ah      ;draw the pixel
        shl     al,1            ;adjust the plane mask for the next pixel's
        and     al,01111b       ; bit, modulo 4
        jnz     AddressSet      ;advance address if we turned over from
        inc     di              ; plane 3 to plane 0
        mov     al,00001b       ;set plane mask bit for plane 0
AddressSet:
        loop    FillScanLineLoop
        pop     di              ;retrieve the start offset of the scan line
        add     di,SCREEN_WIDTH ;point to the start of the next scan
                                ; line of the rectangle
        pop     ax              ;retrieve the plane mask for the left edge
        dec     bx              ;count down scan lines
        jnz     FillRowsLoop
FillDone:
        pop     di              ;restore caller's register variables
        pop     si
        pop     bp              ;restore caller's stack frame
        ret
_FillRectangleX endp
        end
