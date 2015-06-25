; Assembler subroutine to perform a 16-bit checksum on a block of
; bytes 1 to 64K in size. Adds checksum for block into passed-in
; checksum.
;
; Call as:
;     void ChecksumChunk(unsigned char *Buffer,
;     unsigned int BufferLength, unsigned int *Checksum);
;
; where:
;     Buffer = pointer to start of block of bytes to checksum
;     BufferLength = # of bytes to checksum (0 means 64K, not 0)
;     Checksum = pointer to unsigned int variable checksum is
;stored in
;
; Parameter structure:
;
Parms struc
		dw	?	;pushed BP
		dw	?	;return address
Buffer		dw	?
BufferLength	dw	?
Checksum	dw	?
Parms ends
;
	.model	small
	.code
	public	_ChecksumChunk
_ChecksumChunk	proc near
	push	bp
	mov	bp,sp
	push	si			;save C's register variable
;
	cld				;make LODSB increment SI
	mov	si,[bp+Buffer]		;point to buffer
	mov	cx,[bp+BufferLength]	;get buffer length
	mov	bx,[bp+Checksum]	;point to checksum variable
	mov	dx,[bx]			;get the current checksum
	sub	ah,ah			;so AX will be a 16-bit value after LODSB
ChecksumLoop:
	lodsb			;get the next byte
	add	dx,ax		;add it into the checksum total
	loop	ChecksumLoop	;continue for all bytes in block
	mov	[bx],dx		;save the new checksum
;
	pop	si		;restore C's register variable
	pop	bp
	ret
_ChecksumChunk	endp
	end
