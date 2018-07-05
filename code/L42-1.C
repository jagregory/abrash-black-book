/* Function to draw an antialiased line from (X0,Y0) to (X1,Y1), using an
 * antialiasing approach published by Xiaolin Wu in the July 1991 issue of
 * Computer Graphics. Requires that the palette be set up so that there
 * are NumLevels intensity levels of the desired drawing color, starting at
 * color BaseColor (100% intensity) and followed by (NumLevels-1) levels of
 * evenly decreasing intensity, with color (BaseColor+NumLevels-1) being 0%
 * intensity of the desired drawing color (black). This code is suitable for
 * use at screen resolutions, with lines typically no more than 1K long; for
 * longer lines, 32-bit error arithmetic must be used to avoid problems with
 * fixed-point inaccuracy. No clipping is performed in DrawWuLine; it must be
 * performed either at a higher level or in the DrawPixel function.
 * Tested with Borland C++ in C compilation mode and the small model.
 */
extern void DrawPixel(int, int, int);

/* Wu antialiased line drawer.
 * (X0,Y0),(X1,Y1) = line to draw
 * BaseColor = color # of first color in block used for antialiasing, the
 *			100% intensity version of the drawing color
 * NumLevels = size of color block, with BaseColor+NumLevels-1 being the
 *			0% intensity version of the drawing color
 * IntensityBits = log base 2 of NumLevels; the # of bits used to describe
 *			the intensity of the drawing color. 2**IntensityBits==NumLevels
 */
void DrawWuLine(int X0, int Y0, int X1, int Y1, int BaseColor, int NumLevels, unsigned int IntensityBits)
{
	unsigned int IntensityShift, ErrorAdj, ErrorAcc;
	unsigned int ErrorAccTemp, Weighting, WeightingComplementMask;
	int DeltaX, DeltaY, Temp, XDir;

	/* Make sure the line runs top to bottom */
	if (Y0 > Y1) {
		Temp = Y0; Y0 = Y1; Y1 = Temp;
		Temp = X0; X0 = X1; X1 = Temp;
	}
	/* Draw the initial pixel, which is always exactly intersected by
	   the line and so needs no weighting */
	DrawPixel(X0, Y0, BaseColor);

	if ((DeltaX = X1 - X0) >= 0) {
		XDir = 1;
	} else {
		XDir = -1;
		DeltaX = -DeltaX; /* make DeltaX positive */
	}
	/* Special-case horizontal, vertical, and diagonal lines, which
	   require no weighting because they go right through the center of
	   every pixel */
	if ((DeltaY = Y1 - Y0) == 0) {
		/* Horizontal line */
		while (DeltaX-- != 0) {
			X0 += XDir;
			DrawPixel(X0, Y0, BaseColor);
		}
		return;
	}
	if (DeltaX == 0) {
		/* Vertical line */
		do {
			Y0++;
			DrawPixel(X0, Y0, BaseColor);
		} while (--DeltaY != 0);
		return;
	}
	if (DeltaX == DeltaY) {
		/* Diagonal line */
		do {
			X0 += XDir;
			Y0++;
			DrawPixel(X0, Y0, BaseColor);
		} while (--DeltaY != 0);
		return;
	}
	/* Line is not horizontal, diagonal, or vertical */
	ErrorAcc = 0;  /* initialize the line error accumulator to 0 */
	/* # of bits by which to shift ErrorAcc to get intensity level */
	IntensityShift = 16 - IntensityBits;
	/* Mask used to flip all bits in an intensity weighting, producing the
	   result (1 - intensity weighting) */
	WeightingComplementMask = NumLevels - 1;
	/* Is this an X-major or Y-major line? */
	if (DeltaY > DeltaX) {
		/* Y-major line; calculate 16-bit fixed-point fractional part of a
		  pixel that X advances each time Y advances 1 pixel, truncating the
		  result so that we won't overrun the endpoint along the X axis */
		ErrorAdj = ((unsigned long) DeltaX << 16) / (unsigned long) DeltaY;
		/* Draw all pixels other than the first and last */
		while (--DeltaY) {
			ErrorAccTemp = ErrorAcc;   /* remember currrent accumulated error */
			ErrorAcc += ErrorAdj;	   /* calculate error for next pixel */
			if (ErrorAcc <= ErrorAccTemp) {
				/* The error accumulator turned over, so advance the X coord */
				X0 += XDir;
			}
			Y0++; /* Y-major, so always advance Y */
			/* The IntensityBits most significant bits of ErrorAcc give us the
			 intensity weighting for this pixel, and the complement of the
			 weighting for the paired pixel */
			Weighting = ErrorAcc >> IntensityShift;
			DrawPixel(X0, Y0, BaseColor + Weighting);
			DrawPixel(X0 + XDir, Y0, BaseColor + (Weighting ^ WeightingComplementMask));
		}
		/* Draw the final pixel, which is always exactly intersected by the line
		  and so needs no weighting */
		DrawPixel(X1, Y1, BaseColor);
		return;
	}
	/* It's an X-major line; calculate 16-bit fixed-point fractional part of a
	   pixel that Y advances each time X advances 1 pixel, truncating the
	   result to avoid overrunning the endpoint along the X axis */
	ErrorAdj = ((unsigned long) DeltaY << 16) / (unsigned long) DeltaX;
	/* Draw all pixels other than the first and last */
	while (--DeltaX) {
		ErrorAccTemp = ErrorAcc;   /* remember currrent accumulated error */
		ErrorAcc += ErrorAdj;	   /* calculate error for next pixel */
		if (ErrorAcc <= ErrorAccTemp) {
			/* The error accumulator turned over, so advance the Y coord */
			Y0++;
		}
		X0 += XDir; /* X-major, so always advance X */
		/* The IntensityBits most significant bits of ErrorAcc give us the
		  intensity weighting for this pixel, and the complement of the
		  weighting for the paired pixel */
		Weighting = ErrorAcc >> IntensityShift;
		DrawPixel(X0, Y0, BaseColor + Weighting);
		DrawPixel(X0, Y0 + 1, BaseColor + (Weighting ^ WeightingComplementMask));
	}
	/* Draw the final pixel, which is always exactly intersected by the line
	   and so needs no weighting */
	DrawPixel(X1, Y1, BaseColor);
}
