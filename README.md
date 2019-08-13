# Michael Abrash's Graphics Programming Black Book

This is the source for an ebook version of Michael Abrash's Black Book of Graphics Programming (Special Edition), originally published in 1997 and [released online for free in 2001](http://www.drdobbs.com/parallel/graphics-programming-black-book/184404919).

Reproduced with blessing of Michael Abrash, converted and maintained by [James Gregory](mailto:james@jagregory.com).

The [GitHub releases list](https://github.com/jagregory/abrash-black-book/releases) has an EPUB and Mobi version available for download, and you can find a mirror of the HTML version at [www.jagregory.com/abrash-black-book](http://www.jagregory.com/abrash-black-book/).

## How does this differ from the previously released versions?

The book is now out of print, and hard to come by. Last time I checked, it was going for over $200 on eBay.

The version which Michael and Dr. Dobbs released in 2001 was a collection of PDF files. That version is [still available](http://www.drdobbs.com/parallel/graphics-programming-black-book/184404919).  However, the structure (multiple files) and the format (PDF) result in a poor user experience on an ebook reader or other mobile device.

This version has been thoroughly cleaned of artifacts and condensed into something which can easily be converted into an ebook-friendly format. You can read this version online at GitHub, or download any of the EPUB or Mobi releases. You can clone the repository and generate your own version with [pandoc](http://johnmacfarlane.net/pandoc/) if necessary.

## Contributing

Changes are welcome, especially conversion-related ones. If you spot any problems while reading, please [submit an issue](https://github.com/jagregory/abrash-black-book/issues) and I'll correct it. Pull requests are always welcome.

Some larger changes could be made to improve the content. I'd love to see some of the images converted to a vector representation so we can provide higher-resolution versions.  Formulas and equations could be typeset with [MathJax](http://www.mathjax.org/).

## Generating your own ebook

You need to have the following software installed and on your `PATH` before you begin:

  * [pandoc](http://johnmacfarlane.net/pandoc/) version 2.0 or greater for Markdown to HTML and EPUB conversion.
  * [kindlegen](http://www.amazon.com/gp/feature.html?docId=1000765211) for Epub to Mobi conversion.

To generate an e-reader friendly version of the book, you can use `make` with one of the following options:

  * `html` - build an HTML5 single-page version of the book
  * `epub` - build an EPUB3 ebook
  * `mobi` - build a Kindle-friendly Mobi
  * `all`  - do all of the above

Once complete, there will be an `out` directory with a `black-book.epub`, a `black-book.mobi` and an `html` directory with a `black-book.html` file.

> Note: Generating a Mobi requires an EPUB to already exist. Also, Mobi generation can be *slow* because of compression. If you want a quick Mobi conversion you can just run `kindlegen out/black-book.epub`.
