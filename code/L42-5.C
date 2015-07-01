/* Mode set and pixel-drawing functions for the 640x480 256-color mode of
 * Tseng Labs ET4000-based SuperVGAs.
 * Tested with Borland C++ in C compilation mode and the small model.
 */
#include <dos.h>

/* Screen dimension globals, used in main program to scale */
int ScreenWidthInPixels = 640;
int ScreenHeightInPixels = 480;

/* ET4000 640x480 256-color draw pixel function. */
void DrawPixel(int X, int Y, int Color)
{
	#define SCREEN_SEGMENT		  0xA000
	#define GC_SEGMENT_SELECT	  0x3CD /* ET4000 segment (bank) select reg */
	unsigned char far *ScreenPtr;
	unsigned int Bank;
	unsigned long BitmapAddress;

	/* Full bitmap address of pixel, as measured from address 0 to 0xFFFFF */
	BitmapAddress = (unsigned long) Y * ScreenWidthInPixels + X;
	/* Bank # is upper word of bitmap addr */
	Bank = BitmapAddress >> 16;
	/* Upper nibble is read bank #, lower nibble is write bank # */
	outp(GC_SEGMENT_SELECT, (Bank << 4) | Bank);
	/* Draw into the bank */
	FP_SEG(ScreenPtr) = SCREEN_SEGMENT;
	FP_OFF(ScreenPtr) = (unsigned int) BitmapAddress;
	*ScreenPtr = Color;
}

/* ET4000 640x480 256-color mode-set function. */
void SetMode()
{
	union REGS regset;

	/* Set to 640x480 256-color graphics mode */
	regset.x.ax = 0x002E;
	int86(0x10, &regset, &regset);
}
