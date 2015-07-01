/* Function to draw a non-antialiased line from (X0,Y0) to (X1,Y1), using a
 * simple fixed-point error accumulation approach.
 * Tested with Borland C++ in C compilation mode and the small model.
 */
extern void DrawPixel(int, int, int);

/* Non-antialiased line drawer.
 * (X0,Y0),(X1,Y1) = line to draw, Color = color in which to draw
 */
void DrawLine(int X0, int Y0, int X1, int Y1, int Color)
{
	unsigned long ErrorAcc, ErrorAdj;
	int DeltaX, DeltaY, XDir, Temp;

	/* Make sure the line runs top to bottom */
	if (Y0 > Y1) {
		Temp = Y0; Y0 = Y1; Y1 = Temp;
		Temp = X0; X0 = X1; X1 = Temp;
	}
	DrawPixel(X0, Y0, Color);  /* draw the initial pixel */
	if ((DeltaX = X1 - X0) >= 0) {
		XDir = 1;
	} else {
		XDir = -1;
		DeltaX = -DeltaX; /* make DeltaX positive */
	}
	if ((DeltaY = Y1 - Y0) == 0)  /* done if only one point in the line */
		if (DeltaX == 0) return;

	ErrorAcc = 0x8000;	 /* initialize line error accumulator to .5, so we can
						   advance when we get halfway to the next pixel */
	/* Is this an X-major or Y-major line? */
	if (DeltaY > DeltaX) {
		/* Y-major line; calculate 16-bit fixed-point fractional part of a
		 pixel that X advances each time Y advances 1 pixel */
		ErrorAdj = ((((unsigned long)DeltaX << 17) / (unsigned long)DeltaY) + 1) >> 1;
		/* Draw all pixels between the first and last */
		do {
			ErrorAcc += ErrorAdj;	   /* calculate error for this pixel */
			if (ErrorAcc & ~0xFFFFL) {
				/* The error accumulator turned over, so advance the X coord */
				X0 += XDir;
				ErrorAcc &= 0xFFFFL;	/* clear integer part of result */
			}
			Y0++;					   /* Y-major, so always advance Y */
			DrawPixel(X0, Y0, Color);
		} while (--DeltaY);
		return;
	}
	/* It's an X-major line; calculate 16-bit fixed-point fractional part of a
	  pixel that Y advances each time X advances 1 pixel */
	ErrorAdj = ((((unsigned long)DeltaY << 17) / (unsigned long)DeltaX) + 1) >> 1;
	/* Draw all remaining pixels */
	do {
		ErrorAcc += ErrorAdj;	   /* calculate error for this pixel */
		if (ErrorAcc & ~0xFFFFL) {
			/* The error accumulator turned over, so advance the Y coord */
			Y0++;
			ErrorAcc &= 0xFFFFL;	/* clear integer part of result */
		}
		X0 += XDir;				   /* X-major, so always advance X */
		DrawPixel(X0, Y0, Color);
	} while (--DeltaX);
}
