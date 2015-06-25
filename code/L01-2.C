/*
 * Program to calculate the 16-bit checksum of the stream of bytes
 * from the specified file. Obtains the bytes one at a time in
 * assembler, via direct calls to DOS.
 */

#include <stdio.h>
#include <fcntl.h>

main(int argc, char *argv[]) {
	int Handle;
	unsigned char Byte;
	unsigned int Checksum;
	int ReadLength;
	
	if ( argc != 2 ) {
		printf("usage: checksum filename\n");
		exit(1);
	}
	if ( (Handle = open(argv[1], O_RDONLY | O_BINARY)) == -1 ) {
		printf("Can't open file: %s\n", argv[1]);
		exit(1);
	}
	if ( !ChecksumFile(Handle, &Checksum) ) {
		printf("Error reading file %s\n", argv[1]);
		exit(1);
	}
	
	/* Report the result */
	printf("The checksum is: %u\n", Checksum);
	exit(0);
}
