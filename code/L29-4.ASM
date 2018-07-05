; Program to demonstrate screen blanking via bit 5 of the
; Attribute Controller Index register.
;
AC_INDEX        equ     3c0h    ;Attribute Controller Index register
INPUT_STATUS_1  equ     3dah    ;color-mode address of the Input
                                ; Status 1 register
;
; Macro to wait for and clear the next keypress.
;
WAIT_KEY macro
        mov     ah,8            ;DOS input without echo function
        int     21h
        endm
;
stack   segment para stack 'STACK'
        db      512 dup (?)
stack   ends
;
Data    segment word 'DATA'
SampleText db   'This is bit-mapped text, drawn in hi-res '
        db      'EGA graphics mode 10h.', 0dh, 0ah, 0ah
        db      'Press any key to blank the screen, then '
        db      'any key to unblank it,', 0dh, 0ah
        db      'then any key to end.$'
Data    ends
;
Code    segment
        assume  cs:Code, ds:Data
Start   proc    near
        mov     ax,Data
        mov     ds,ax
;
; Go to hi-res graphics mode.
;
        mov     ax,10h          ;AH = 0 means mode set, AL = 10h selects
                                ; hi-res graphics mode
        int     10h             ;BIOS video interrupt
;
; Put up some text, so the screen isn't empty.
;
        mov     ah,9            ;DOS print string function
        mov     dx,offset SampleText
        int     21h
;
        WAIT_KEY
;
; Blank the screen.
;
        mov     dx,INPUT_STATUS_1
        in      al,dx           ;reset port 3c0h to index (rather than data)
                                ; mode
        mov     dx,AC_INDEX
        sub     al,al           ;make bit 5 zero...
        out     dx,al           ;...which blanks the screen
;
        WAIT_KEY
;
; Unblank the screen.
;
        mov     dx,INPUT_STATUS_1
        in      al,dx           ;reset port 3c0h to Index (rather than data)
                                ; mode
        mov     dx,AC_INDEX
        mov     al,20h          ;make bit 5 one...
        out     dx,al           ;...which unblanks the screen
;
        WAIT_KEY
;
; Restore text mode.
;
        mov     ax,2
        int     10h
;
; Done.
;
Done:
        mov     ah,4ch          ;DOS terminate function
        int     21h
Start   endp
Code    ends
        end     Start
