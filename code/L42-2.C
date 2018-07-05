/* Sample line-drawing program to demonstrate Wu antialiasing. Also draws
 * non-antialiased lines for comparison.
 * Tested with Borland C++ in C compilation mode and the small model.
 */
#include <dos.h>
#include <conio.h>

void SetPalette(struct WuColor *);
extern void DrawWuLine(int, int, int, int, int, int, unsigned int);
extern void DrawLine(int, int, int, int, int);
extern void SetMode(void);
extern int ScreenWidthInPixels;	 /* screen dimension globals */
extern int ScreenHeightInPixels;

#define NUM_WU_COLORS 2 /* # of colors we'll do antialiased drawing with */
struct WuColor {		/* describes one color used for antialiasing */
	int BaseColor;		/* # of start of palette intensity block in DAC */
	int NumLevels;		/* # of intensity levels */
	int IntensityBits;	/* IntensityBits == log2 NumLevels */
	int MaxRed;			/* red component of color at full intensity */
	int MaxGreen;		/* green component of color at full intensity */
	int MaxBlue;		/* blue component of color at full intensity */
};
enum {WU_BLUE=0, WU_WHITE=1};			  /* drawing colors */
struct WuColor WuColors[NUM_WU_COLORS] =  /* blue and white */
	{{192, 32, 5, 0, 0, 0x3F}, {224, 32, 5, 0x3F, 0x3F, 0x3F}};

void main()
{
	int CurrentColor, i;
	union REGS regset;

	/* Draw Wu-antialiased lines in all directions */
	SetMode();
	SetPalette(WuColors);
	for (i=5; i<ScreenWidthInPixels; i += 10) {
		DrawWuLine(ScreenWidthInPixels/2-ScreenWidthInPixels/10+i/5,
			ScreenHeightInPixels/5, i, ScreenHeightInPixels-1,
			WuColors[WU_BLUE].BaseColor, WuColors[WU_BLUE].NumLevels,
			WuColors[WU_BLUE].IntensityBits);
	}
	for (i=0; i<ScreenHeightInPixels; i += 10) {
		DrawWuLine(ScreenWidthInPixels/2-ScreenWidthInPixels/10, i/5, 0, i,
			WuColors[WU_BLUE].BaseColor, WuColors[WU_BLUE].NumLevels,
			WuColors[WU_BLUE].IntensityBits);
	}
	for (i=0; i<ScreenHeightInPixels; i += 10) {
		DrawWuLine(ScreenWidthInPixels/2+ScreenWidthInPixels/10, i/5,
			ScreenWidthInPixels-1, i, WuColors[WU_BLUE].BaseColor,
			WuColors[WU_BLUE].NumLevels, WuColors[WU_BLUE].IntensityBits);
	}
	for (i=0; i<ScreenWidthInPixels; i += 10) {
		DrawWuLine(ScreenWidthInPixels/2-ScreenWidthInPixels/10+i/5,
			ScreenHeightInPixels, i, 0, WuColors[WU_WHITE].BaseColor,
			WuColors[WU_WHITE].NumLevels,
			WuColors[WU_WHITE].IntensityBits);
	}
	getch();				/* wait for a key press */

	/* Now clear the screen and draw non-antialiased lines */
	SetMode();
	SetPalette(WuColors);
	for (i=0; i<ScreenWidthInPixels; i += 10) {
		DrawLine(ScreenWidthInPixels/2-ScreenWidthInPixels/10+i/5,
			ScreenHeightInPixels/5, i, ScreenHeightInPixels-1,
			WuColors[WU_BLUE].BaseColor);
	}
	for (i=0; i<ScreenHeightInPixels; i += 10) {
		DrawLine(ScreenWidthInPixels/2-ScreenWidthInPixels/10, i/5, 0, i,
			WuColors[WU_BLUE].BaseColor);
	}
	for (i=0; i<ScreenHeightInPixels; i += 10) {
		DrawLine(ScreenWidthInPixels/2+ScreenWidthInPixels/10, i/5,
			ScreenWidthInPixels-1, i, WuColors[WU_BLUE].BaseColor);
	}
	for (i=0; i<ScreenWidthInPixels; i += 10) {
		DrawLine(ScreenWidthInPixels/2-ScreenWidthInPixels/10+i/5,
			ScreenHeightInPixels, i, 0, WuColors[WU_WHITE].BaseColor);
	}
	getch();				/* wait for a key press */

	regset.x.ax = 0x0003;	/* AL = 3 selects 80x25 text mode */
	int86(0x10, &regset, &regset);	 /* return to text mode */
}

/* Sets up the palette for antialiasing with the specified colors.
 * Intensity steps for each color are scaled from the full desired intensity
 * of the red, green, and blue components for that color down to 0%
 * intensity; each step is rounded to the nearest integer. Colors are
 * corrected for a gamma of 2.3. The values that the palette is programmed
 * with are hardwired for the VGA's 6 bit per color DAC.
 */
void SetPalette(struct WuColor * WColors)
{
	int i, j;
	union REGS regset;
	struct SREGS sregset;
	static unsigned char PaletteBlock[256][3];	 /* 256 RGB entries */
	/* Gamma-corrected DAC color components for 64 linear levels from 0% to 100% intensity */
	static unsigned char GammaTable[] = {
		0, 10, 14, 17, 19, 21, 23, 24, 26, 27, 28, 29, 31, 32, 33, 34,
		35, 36, 37, 37, 38, 39, 40, 41, 41, 42, 43, 44, 44, 45, 46, 46,
		47, 48, 48, 49, 49, 50, 51, 51, 52, 52, 53, 53, 54, 54, 55, 55,
		56, 56, 57, 57, 58, 58, 59, 59, 60, 60, 61, 61, 62, 62, 63, 63};

	for (i=0; i<NUM_WU_COLORS; i++) {
		for (j=0; j<WColors[i].NumLevels; j++) {
			PaletteBlock[j][0] = GammaTable[((double)WColors[i].MaxRed * (1.0 -
			   (double)j / (double)(WColors[i].NumLevels - 1))) + 0.5];
			PaletteBlock[j][1] = GammaTable[((double)WColors[i].MaxGreen * (1.0 -
			   (double)j / (double)(WColors[i].NumLevels - 1))) + 0.5];
			PaletteBlock[j][2] = GammaTable[((double)WColors[i].MaxBlue * (1.0 -
			   (double)j / (double)(WColors[i].NumLevels - 1))) + 0.5];
		}
		/* Now set up the palette to do Wu antialiasing for this color */
		regset.x.ax = 0x1012;						/* set block of DAC registers function */
		regset.x.bx = WColors[i].BaseColor;			/* first DAC location to load */
		regset.x.cx = WColors[i].NumLevels;			/* # of DAC locations to load */
		regset.x.dx = (unsigned int)PaletteBlock;	/* offset of array from which
													   to load RGB settings */
		sregset.es = _DS;							/* segment of array from which to load settings */
		int86x(0x10, &regset, &regset, &sregset);	/* load the palette block */
	}
}
