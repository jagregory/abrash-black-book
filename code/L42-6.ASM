; C near-callable function to draw an antialiased line from
; (X0,Y0) to (X1,Y1), in mode 13h, the VGA's standard 320x200 256-color
; mode. Uses an antialiasing approach published by Xiaolin Wu in the July
; 1991 issue of Computer Graphics. Requires that the palette be set up so
; that there are NumLevels intensity levels of the desired drawing color,
; starting at color BaseColor (100% intensity) and followed by (NumLevels-1)
; levels of evenly decreasing intensity, with color (BaseColor+NumLevels-1)
; being 0% intensity of the desired drawing color (black). No clipping is
; performed in DrawWuLine. Handles a maximum of 256 intensity levels per
; antialiased color. This code is suitable for use at screen resolutions,
; with lines typically no more than 1K long; for longer lines, 32-bit error
; arithmetic must be used to avoid problems with fixed-point inaccuracy.
; Tested with TASM.
;
; C near-callable as:
;   void DrawWuLine(int X0, int Y0, int X1, int Y1, int BaseColor,
;      int NumLevels, unsigned int IntensityBits);

SCREEN_WIDTH_IN_BYTES equ 320   ;# of bytes from the start of one scan line
; to the start of the next
SCREEN_SEGMENT   equ   0a000h   ;segment in which screen memory resides

; Parameters passed in stack frame.
parms   struc
        dw   2 dup (?)          ;pushed BP and return address
X0      dw   ?                  ;X coordinate of line start point
Y0      dw   ?                  ;Y coordinate of line start point
X1      dw   ?                  ;X coordinate of line end point
Y1      dw   ?                  ;Y coordinate of line end point
BaseColor dw   ?                ;color # of first color in block used for
                                ;antialiasing, the 100% intensity version of the
                                ;drawing color
NumLevels dw   ?                ;size of color block, with BaseColor+NumLevels-1
                                ; being the 0% intensity version of the drawing color
                                ; (maximum NumLevels = 256)
IntensityBits dw ?              ;log base 2 of NumLevels; the # of bits used to
                                ; describe the intensity of the drawing color.
                                ; 2**IntensityBits==NumLevels
                                ; (maximum IntensityBits = 8)
parms   ends

        .model   small
        .code
; Screen dimension globals, used in main program to scale.
_ScreenWidthInPixels    dw      320
_ScreenHeightInPixels   dw      200

        .code
        public   _DrawWuLine
_DrawWuLine proc near
        push    bp                      ;preserve caller's stack frame
        mov     bp,sp                   ;point to local stack frame
        push    si                      ;preserve C's register variables
        push    di
        push    ds                      ;preserve C's default data segment
        cld                             ;make string instructions increment their pointers

; Make sure the line runs top to bottom.
        mov     si,[bp].X0
        mov     ax,[bp].Y0
        cmp     ax,[bp].Y1              ;swap endpoints if necessary to ensure that
        jna     NoSwap                  ; Y0 <= Y1
        xchg    [bp].Y1,ax
        mov     [bp].Y0,ax
        xchg    [bp].X1,si
        mov     [bp].X0,si
NoSwap:

; Draw the initial pixel, which is always exactly intersected by the line
; and so needs no weighting.
        mov     dx,SCREEN_SEGMENT
        mov     ds,dx                   ;point DS to the screen segment
        mov     dx,SCREEN_WIDTH_IN_BYTES
        mul     dx                      ;Y0 * SCREEN_WIDTH_IN_BYTES yields the offset
                                        ; of the start of the row start the initial
                                        ; pixel is on
        add     si,ax                   ;point DS:SI to the initial pixel
        mov     al,byte ptr [bp].BaseColor      ;color with which to draw
        mov     [si],al                 ;draw the initial pixel

        mov     bx,1                    ;XDir = 1; assume DeltaX >= 0
        mov     cx,[bp].X1
        sub     cx,[bp].X0              ;DeltaX; is it >= 1?
        jns     DeltaXSet               ;yes, move left->right, all set
                                        ;no, move right->left
        neg     cx                      ;make DeltaX positive
        neg     bx                              ;XDir = -1
DeltaXSet:

; Special-case horizontal, vertical, and diagonal lines, which require no
; weighting because they go right through the center of every pixel.
        mov     dx,[bp].Y1
        sub     dx,[bp].Y0              ;DeltaY; is it 0?
        jnz     NotHorz                 ;no, not horizontal
                                        ;yes, is horizontal, special case
        and     bx,bx                   ;draw from left->right?
        jns     DoHorz                  ;yes, all set
        std                             ;no, draw right->left
DoHorz:
        lea     di,[bx+si]              ;point DI to next pixel to draw
        mov     ax,ds
        mov     es,ax                   ;point ES:DI to next pixel to draw
        mov     al,byte ptr [bp].BaseColor ;color with which to draw
                                        ;CX = DeltaX at this point
        rep stosb                       ;draw the rest of the horizontal line
        cld                             ;restore default direction flag
        jmp     Done                    ;and we're done

        align   2
NotHorz:
        and     cx,cx                   ;is DeltaX 0?
        jnz     NotVert                 ;no, not a vertical line
                                        ;yes, is vertical, special case
        mov     al,byte ptr [bp].BaseColor ;color with which to draw
VertLoop:
        add     si,SCREEN_WIDTH_IN_BYTES ;point to next pixel to draw
        mov     [si],al                 ;draw the next pixel
        dec     dx                      ;--DeltaY
        jnz     VertLoop
        jmp     Done                    ;and we're done

        align   2
NotVert:
        cmp     cx,dx                   ;DeltaX == DeltaY?
        jnz     NotDiag                 ;no, not diagonal
                                        ;yes, is diagonal, special case
        mov     al,byte ptr [bp].BaseColor ;color with which to draw
DiagLoop:
        lea     si,[si+SCREEN_WIDTH_IN_BYTES+bx]
                                        ;advance to next pixel to draw by
                                        ; incrementing Y and adding XDir to X
        mov     [si],al                 ;draw the next pixel
        dec     dx                      ;--DeltaY
        jnz     DiagLoop
        jmp     Done                    ;and we're done

; Line is not horizontal, diagonal, or vertical.
        align   2
NotDiag:
; Is this an X-major or Y-major line?
        cmp     dx,cx
        jb      XMajor                  ;it's X-major

; It's a Y-major line. Calculate the 16-bit fixed-point fractional part of a
; pixel that X advances each time Y advances 1 pixel, truncating the result
; to avoid overrunning the endpoint along the X axis.
        xchg    dx,cx                   ;DX = DeltaX, CX = DeltaY
        sub     ax,ax                   ;make DeltaX 16.16 fixed-point value in DX:AX
        div     cx                      ;AX = (DeltaX << 16) / DeltaY. Won't overflow
                                        ; because DeltaX < DeltaY
        mov     di,cx                   ;DI = DeltaY (loop count)
        sub     si,bx                   ;back up the start X by 1, as explained below
        mov     dx,-1                   ;initialize the line error accumulator to -1,
                                        ; so that it will turn over immediately and
                                        ; advance X to the start X. This is necessary
                                        ; properly to bias error sums of 0 to mean
                                        ; "advance next time" rather than "advance
                                        ; this time," so that the final error sum can
                                        ; never cause drawing to overrun the final X
                                        ; coordinate (works in conjunction with
                                        ; truncating ErrorAdj, to make sure X can't
                                        ; overrun)
        mov     cx,8                    ;CL = # of bits by which to shift
        sub     cx,[bp].IntensityBits   ; ErrorAcc to get intensity level (8
                                        ; instead of 16 because we work only
                                        ; with the high byte of ErrorAcc)
        mov     ch,byte ptr [bp].NumLevels ;mask used to flip all bits in an
        dec     ch                      ; intensity weighting, producing
                                        ; result (1 - intensity weighting)
        mov     bp,BaseColor[bp]        ;***stack frame not available***
                                        ;***from now on              ***
        xchg    bp,ax                   ;BP = ErrorAdj, AL = BaseColor,
                                        ; AH = scratch register

; Draw all remaining pixels.
YMajorLoop:
        add     dx,bp                   ;calculate error for next pixel
        jnc     NoXAdvance              ;not time to step in X yet
                                        ;the error accumulator turned over,
                                        ;so advance the X coord
        add     si,bx                   ;add XDir to the pixel pointer
NoXAdvance:
        add     si,SCREEN_WIDTH_IN_BYTES ;Y-major, so always advance Y

; The IntensityBits most significant bits of ErrorAcc give us the intensity
; weighting for this pixel, and the complement of the weighting for the
; paired pixel.
        mov     ah,dh                   ;msb of ErrorAcc
        shr     ah,cl                   ;Weighting = ErrorAcc >> IntensityShift;
        add     ah,al                   ;BaseColor + Weighting
        mov     [si],ah                 ;DrawPixel(X, Y, BaseColor + Weighting);
        mov     ah,dh                   ;msb of ErrorAcc
        shr     ah,cl                   ;Weighting = ErrorAcc >> IntensityShift;
        xor     ah,ch                   ;Weighting ^ WeightingComplementMask
        add     ah,al                   ;BaseColor + (Weighting ^ WeightingComplementMask)
        mov     [si+bx],ah              ;DrawPixel(X+XDir, Y,
; BaseColor + (Weighting ^ WeightingComplementMask));
        dec     di                      ;--DeltaY
        jnz     YMajorLoop
        jmp     Done                    ;we're done with this line

; It's an X-major line.
        align   2
XMajor:
; Calculate the 16-bit fixed-point fractional part of a pixel that Y advances
; each time X advances 1 pixel, truncating the result to avoid overrunning
; the endpoint along the X axis.
        sub     ax,ax                   ;make DeltaY 16.16 fixed-point value in DX:AX
        div     cx                      ;AX = (DeltaY << 16) / Deltax. Won't overflow
                                        ; because DeltaY < DeltaX
        mov     di,cx                   ;DI = DeltaX (loop count)
        sub     si,SCREEN_WIDTH_IN_BYTES;back up the start X by 1, as
                                        ; explained below
        mov     dx,-1                   ;initialize the line error accumulator to -1,
                                        ; so that it will turn over immediately and
                                        ; advance Y to the start Y. This is necessary
                                        ; properly to bias error sums of 0 to mean
                                        ; "advance next time" rather than "advance
                                        ; this time," so that the final error sum can
                                        ; never cause drawing to overrun the final Y
                                        ; coordinate (works in conjunction with
                                        ; truncating ErrorAdj, to make sure Y can't
                                        ; overrun)
        mov     cx,8                    ;CL = # of bits by which to shift
        sub     cx,[bp].IntensityBits   ; ErrorAcc to get intensity level (8
                                        ; instead of 16 because we work only
                                        ; with the high byte of ErrorAcc)
        mov     ch,byte ptr [bp].NumLevels ;mask used to flip all bits in an
        dec     ch                      ; intensity weighting, producing
                                        ; result (1 - intensity weighting)
        mov     bp,BaseColor[bp]        ;***stack frame not available***
                                        ;***from now on              ***
        xchg    bp,ax                   ;BP = ErrorAdj, AL = BaseColor,
                                        ; AH = scratch register
; Draw all remaining pixels.
XMajorLoop:
        add     dx,bp                   ;calculate error for next pixel
        jnc     NoYAdvance              ;not time to step in Y yet
                                        ;the error accumulator turned over,
                                        ; so advance the Y coord
        add     si,SCREEN_WIDTH_IN_BYTES;advance Y
NoYAdvance:
        add     si,bx                   ;X-major, so add XDir to the pixel pointer

; The IntensityBits most significant bits of ErrorAcc give us the intensity
; weighting for this pixel, and the complement of the weighting for the
; paired pixel.
        mov     ah,dh                   ;msb of ErrorAcc
        shr     ah,cl                   ;Weighting = ErrorAcc >> IntensityShift;
        add     ah,al                   ;BaseColor + Weighting
        mov     [si],ah                 ;DrawPixel(X, Y, BaseColor + Weighting);
        mov     ah,dh                   ;msb of ErrorAcc
        shr     ah,cl                   ;Weighting = ErrorAcc >> IntensityShift;
        xor     ah,ch                   ;Weighting ^ WeightingComplementMask
        add     ah,al                   ;BaseColor + (Weighting ^ WeightingComplementMask)
        mov     [si+SCREEN_WIDTH_IN_BYTES],ah

; DrawPixel(X, Y+SCREEN_WIDTH_IN_BYTES, BaseColor + (Weighting ^ WeightingComplementMask));
        dec     di                      ;--DeltaX
        jnz     XMajorLoop

Done:                                   ;we're done with this line
        pop     ds                      ;restore C's default data segment
        pop     di                      ;restore C's register variables
        pop     si
        pop     bp                      ;restore caller's stack frame
        ret                             ;done
_DrawWuLine endp
        end
