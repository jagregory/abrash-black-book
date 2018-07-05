/* VGA mode 13h pixel-drawing and mode set functions.
 * Tested with Borland C++ in C compilation mode and the small model.
 */
#include <dos.h>

/* Screen dimension globals, used in main program to scale. */
int ScreenWidthInPixels = 320;
int ScreenHeightInPixels = 200;

/* Mode 13h draw pixel function. */
void DrawPixel(int X, int Y, int Color)
{
	#define SCREEN_SEGMENT	0xA000
	unsigned char far *ScreenPtr;

	FP_SEG(ScreenPtr) = SCREEN_SEGMENT;
	FP_OFF(ScreenPtr) = (unsigned int) Y * ScreenWidthInPixels + X;
	*ScreenPtr = Color;
}

/* Mode 13h mode-set function. */
void SetMode()
{
	union REGS regset;

	/* Set to 320x200 256-color graphics mode */
	regset.x.ax = 0x0013;
	int86(0x10, &regset, &regset);
}
