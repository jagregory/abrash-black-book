; Program to put up a mode 10h EGA graphics screen, then save it
; to the file SNAPSHOT.SCR.
;
VGA_SEGMENT     equ   0a000h
GC_INDEX        equ   3ceh              ;Graphics Controller Index register
READ_MAP        equ   4                 ;Read Map register index in GC
DISPLAYED_SCREEN_SIZE equ (640/8)*350   ;# of displayed bytes per plane in a
                                        ; hi-res graphics screen
;
stack   segment para stack 'STACK'
        db      512 dup (?)
stack   ends
;
Data    segment word 'DATA'
SampleText      db      'This is bit-mapped text, drawn in hi-res '
                db      'EGA graphics mode 10h.', 0dh, 0ah, 0ah
                db      'Saving the screen (including this text)...'
                db      0dh, 0ah, '$'
Filename        db      'SNAPSHOT.SCR',0;name of file we're saving to
ErrMsg1         db      "*** Couldn't open SNAPSHOT.SCR ***",0dh,0ah,'$'
ErrMsg2         db      '*** Error writing to SNAPSHOT.SCR ***',0dh,0ah,'$'
WaitKeyMsg      db      0dh, 0ah, 'Done. Press any key to end...',0dh,0ah,'$'
Handle          dw      ?               ;handle of file we're saving to
Plane           db      ?               ;plane being read
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
        mov     ax,10h                  ;AH = 0 means mode set, AL = 10h selects
                                        ; hi-res graphics mode
        int     10h                     ;BIOS video interrupt
;
; Put up some text, so the screen isn't empty.
;
        mov     ah,9                    ;DOS print string function
        mov     dx,offset SampleText
        int     21h
;
; Delete SNAPSHOT.SCR if it exists.
;
        mov     ah,41h                  ;DOS unlink file function
        mov     dx,offset Filename
        int     21h
;
; Create the file SNAPSHOT.SCR.
;
        mov     ah,3ch                  ;DOS create file function
        mov     dx,offset Filename
        sub     cx,cx                   ;make it a normal file
        int     21h
        mov     [Handle],ax             ;save the handle
        jnc     SaveTheScreen           ;we're ready to save if no error
        mov     ah,9                    ;DOS print string function
        mov     dx,offset ErrMsg1
        int     21h                     ;notify of the error
        jmp     short Done              ;and done
;
; Loop through the 4 planes, making each readable in turn and
; writing it to disk. Note that all 4 planes are readable at
; A000:0000; the Read Map register selects which plane is readable
; at any one time.
;
SaveTheScreen:
        mov     [Plane],0               ;start with plane 0
SaveLoop:
        mov     dx,GC_INDEX
        mov     al,READ_MAP     ;set GC Index to Read Map register
        out     dx,al
        inc     dx
        mov     al,[Plane]              ;get the # of the plane we want
                                        ; to save
        out     dx,al                   ;set to read from the desired plane
        mov     ah,40h                  ;DOS write to file function
        mov     bx,[Handle]
        mov     cx,DISPLAYED_SCREEN_SIZE;# of bytes to save
        sub     dx,dx                   ;write all displayed bytes at A000:0000
        push    ds
        mov     si,VGA_SEGMENT
        mov     ds,si
        int     21h                     ;write the displayed portion of this plane
        pop     ds
        cmp     ax,DISPLAYED_SCREEN_SIZE;did all bytes get written?
        jz      SaveLoopBottom
        mov     ah,9                    ;DOS print string function
        mov     dx,offset ErrMsg2
        int     21h                     ;notify about the error
        jmp     short DoClose           ;and done
SaveLoopBottom:
        mov     al,[Plane]
        inc     ax                      ;point to the next plane
        mov     [Plane],al
        cmp     al,3                    ;have we done all planes?
        jbe     SaveLoop                ;no, so do the next plane
;
; Close SNAPSHOT.SCR.
;
DoClose:
        mov     ah,3eh                  ;DOS close file function
        mov     bx,[Handle]
        int     21h
;
; Wait for a keypress.
;
        mov     ah,9                    ;DOS print string function
        mov     dx,offset WaitKeyMsg
        int     21h                     ;prompt
        mov     ah,8                    ;DOS input without echo function
        int     21h
;
; Restore text mode.
;
        mov     ax,3
        int     10h
;
; Done.
;
Done:
        mov     ah,4ch                  ;DOS terminate function
        int     21h
Start   endp
Code    ends
        end     Start
