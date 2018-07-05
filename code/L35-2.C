/*
 * Sample program to illustrate EGA/VGA line drawing routines.
 *
 * Compiled with Borland C++
 *
 * By Michael Abrash
 */

#include <dos.h>     /* contains geninterrupt */

#define GRAPHICS_MODE   0x10
#define TEXT_MODE       0x03
#define BIOS_VIDEO_INT  0x10
#define X_MAX           640      /* working screen width */
#define Y_MAX           348      /* working screen height */

extern void EVGALine();

/*
 * Subroutine to draw a rectangle full of vectors, of the specified
 * length and color, around the specified rectangle center.
 */
void VectorsUp(XCenter, YCenter, XLength, YLength, Color)
int XCenter, YCenter;   /* center of rectangle to fill */
int XLength, YLength;   /* distance from center to edge
                           of rectangle */
int Color;              /* color to draw lines in */
{
	int WorkingX, WorkingY;

	/* Lines from center to top of rectangle */
	WorkingX = XCenter - XLength;
	WorkingY = YCenter - YLength;
	for ( ; WorkingX < ( XCenter + XLength ); WorkingX++ )
		EVGALine(XCenter, YCenter, WorkingX, WorkingY, Color);

	/* Lines from center to right of rectangle */
	WorkingX = XCenter + XLength - 1;
	WorkingY = YCenter - YLength;
	for ( ; WorkingY < ( YCenter + YLength ); WorkingY++ )
		EVGALine(XCenter, YCenter, WorkingX, WorkingY, Color);

	/* Lines from center to bottom of rectangle */
	WorkingX = XCenter + XLength - 1;
	WorkingY = YCenter + YLength - 1;
	for ( ; WorkingX >= ( XCenter - XLength ); WorkingX-- )
		EVGALine(XCenter, YCenter, WorkingX, WorkingY, Color);

	/* Lines from center to left of rectangle */
	WorkingX = XCenter - XLength;
	WorkingY = YCenter + YLength - 1;
	for ( ; WorkingY >= ( YCenter - YLength ); WorkingY-- )
		EVGALine(XCenter, YCenter, WorkingX, WorkingY, Color );
}

/*
 * Sample program to draw four rectangles full of lines.
 */
void main()
{
	char temp;

	/* Set graphics mode */
	_AX = GRAPHICS_MODE;
	geninterrupt(BIOS_VIDEO_INT);

	/* Draw each of four rectangles full of vectors */
	VectorsUp(X_MAX / 4, Y_MAX / 4, X_MAX / 4, Y_MAX / 4, 1);
	VectorsUp(X_MAX * 3 / 4, Y_MAX / 4, X_MAX / 4, Y_MAX / 4, 2);
	VectorsUp(X_MAX / 4, Y_MAX * 3 / 4, X_MAX / 4, Y_MAX / 4, 3);
	VectorsUp(X_MAX * 3 / 4, Y_MAX * 3 / 4, X_MAX / 4, Y_MAX / 4, 4);

	/* Wait for the enter key to be pressed */
	scanf("%c", &temp);

	/* Back to text mode */
	_AX = TEXT_MODE;
	geninterrupt(BIOS_VIDEO_INT);
}
