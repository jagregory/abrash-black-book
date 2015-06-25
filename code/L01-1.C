/*
 * Program to calculate the 16-bit checksum of all bytes in the
 * specified file. Obtains the bytes one at a time via read(),
 * letting DOS perform all data buffering.
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
	
	/* Initialize the checksum accumulator */
	Checksum = 0;
	
	/* Add each byte in turn into the checksum accumulator */
	while ( (ReadLength = read(Handle, &Byte, sizeof(Byte))) > 0 ) {
		Checksum += (unsigned int) Byte;
	}
	if ( ReadLength == -1 ) {
		printf("Error reading file %s\n", argv[1]);
		exit(1);
	}
	
	/* Report the result */
	printf("The checksum is: %u\n", Checksum);
	exit(0);
}
