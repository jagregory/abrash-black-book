FILES := $(shell cat filelist.txt)

.PHONY: html epub

all: html epub mobi

html:
	rm -rf out/html && mkdir -p out/html
	cp -r images html/book.css out/html/
	pandoc --to html5+smart -o out/html/black-book.html --section-divs --toc --standalone --template=html/template.html $(FILES)

epub:
	mkdir -p out
	rm -f out/black-book.epub
	pandoc --to epub3+smart -o out/black-book.epub --epub-cover-image images/cover.png --toc --epub-chapter-level=2 --data-dir=epub --template=epub/template.html $(FILES)

mobi:
	rm -f out/black-book.mobi
	kindlegen out/black-book.epub -c2
