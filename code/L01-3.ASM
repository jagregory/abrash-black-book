; Assembler subroutine to perform a 16-bit checksum on the file
; opened on the passed-in handle. Stores the result in the
; passed-in checksum variable. Returns 1 for success, 0 for error.
;
; Call as:
;	    int ChecksumFile(unsigned int Handle, unsigned int *Checksum);
;
; where:
;	    Handle = handle # under which file to checksum is open
;	    Checksum = pointer to unsigned int variable checksum is
;	    to be stored in
;
; Parameter structure:
;
Parms	   struc
		dw	?	;pushed BP
		dw	?	;return address
Handle		dw	?
Checksum	dw	?
Parms	   ends
;
		.model small
		.data
TempWord label	word
TempByte	db	?	;each byte read by DOS will be stored here
		db	0	;high byte of TempWord is always 0
				; for 16-bit adds
;
		 .code
		public _ChecksumFile
_ChecksumFile	proc near
		push	bp
		mov	bp,sp
		push	si			;save C's register variable
;
		mov	bx,[bp+Handle]		;get file handle
		sub	si,si			;zero the checksum ;accumulator
		mov	cx,1			;request one byte on each ;read
		mov	dx,offset TempByte	;point DX to the byte in
						;which DOS should store
						;each byte read
ChecksumLoop:
		mov	ah,3fh			;DOS read file function #
		int	21h			;read the byte
		jc	ErrorEnd		;an error occurred
		and	ax,ax			;any bytes read?
		jz	Success			;no-end of file reached-we're done
		add	si,[TempWord]		;add the byte into the
						;checksum total
		jmp	ChecksumLoop
ErrorEnd:
		sub	ax,ax			;error
		jmp	short Done
Success:
		mov	bx,[bp+Checksum]	;point to the checksum variable
		mov	[bx],si			;save the new checksum
		mov	ax,1			;success
;
Done:
		pop	si			;restore C's register variable
		pop	bp
		ret
_ChecksumFile	endp
		end
