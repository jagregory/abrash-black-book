; Program that draws a diagonal line to illustrate the use of a
; Color Don't Care register setting of 0FFH to support fast
; read-modify-write operations to VGA memory in write mode 3 by
; drawing a diagonal line.
;
; Note: Works on VGAs only.
;
; By Michael Abrash
;
stack   segment word stack 'STACK'
        db      512 dup (?)
stack   ends
;
VGA_SEGMENT      EQU    0a000h
SCREEN_WIDTH     EQU    80      ;in bytes
GC_INDEX         EQU    3ceh    ;Graphics Controller Index register
SET_RESET        EQU    0       ;Set/Reset register index in GC
ENABLE_SET_RESET EQU    1       ;Enable Set/Reset register index in GC
GRAPHICS_MODE    EQU    5       ;Graphics Mode register index in GC
COLOR_DONT_CARE  EQU    7       ;Color Don't Care register index in GC
;
code    segment word 'CODE'
        assume  cs:code
Start   proc    near
;
; Select graphics mode 12h.
;
        mov     ax,12h
        int     10h
;
; Select write mode 3 and read mode 1.
;
        mov     dx,GC_INDEX
        mov     al,GRAPHICS_MODE
        out     dx,al
        inc     dx
        in      al,dx           ;VGA registers are readable, bless them!
        or      al,00001011b    ;bit 3=1 selects read mode 1, and
                                ; bits 1 & 0=11 selects write mode 3
        jmp     $+2             ;delay between IN and OUT to same port
        out     dx,al
        dec     dx
;
; Set up set/reset to always draw in white.
;
        mov     al,SET_RESET
        out     dx,al
        inc     dx
        mov     al,0fh
        out     dx,al
        dec     dx
        mov     al,ENABLE_SET_RESET
        out     dx,al
        inc     dx
        mov     al,0fh
        out     dx,al
        dec     dx
;
; Set Color Don't Care to 0, so reads of VGA memory always return 0FFH.
;
        mov     al,COLOR_DONT_CARE
        out     dx,al
        inc     dx
        sub     al,al
        out     dx,al
;
; Set up the initial memory pointer and pixel mask.
;
        mov     ax,VGA_SEGMENT
        mov     ds,ax
        sub     bx,bx
        mov     al,80h
;
; Draw 400 points on a diagonal line sloping down and to the right.
;
        mov     cx,400
DrawDiagonalLoop:
        and     [bx],al         ;reads display memory, loading the latches,
                                ; then writes AL to the VGA. AL becomes the
                                ; bit mask, and set/reset provides the
                                ; actual data written
        add     bx,SCREEN_WIDTH
                                ; point to the next scan line
        ror     al,1            ;move the pixel mask one pixel to the right
        adc     bx,0            ;advance to the next byte if the pixel mask wrapped
        loop    DrawDiagonalLoop
;
; Wait for a key to be pressed to end, then return to text mode and
; return to DOS.
;
WaitKeyLoop:
        mov     ah,1
        int     16h
        jz      WaitKeyLoop
        sub     ah,ah
        int     16h             ;clear the key
        mov     ax,3
        int     10h             ;return to text mode
        mov     ah,4ch
        int     21h             ;done
Start   endp
code    ends
        end     Start
