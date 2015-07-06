/* Program to demonstrate mode X (320x240, 256-colors) rectangle
   fill by drawing adjacent 20x20 rectangles in successive colors from
   0 on up across and down the screen
*/
#include <conio.h>
#include <dos.h>

void Set320x240Mode(void);
void FillRectangleX(int, int, int, int, unsigned int, int);

void main() {
	int i,j;
	union REGS regset;

	Set320x240Mode();
	FillRectangleX(0,0,320,240,0,0); /* clear the screen to black */
	for (j = 1; j < 220; j += 21) {
		for (i = 1; i < 300; i += 21) {
			FillRectangleX(i, j, i+20, j+20, 0, ((j/21*15)+i/21) & 0xFF);
		}
	}
	getch();
	regset.x.ax = 0x0003;   /* switch back to text mode and done */
	int86(0x10, &regset, &regset);
}
