FILES=src/intro.md src/about.md src/about_author.md src/chapter-01.md src/chapter-02.md src/chapter-03.md src/chapter-04.md src/chapter-05.md src/chapter-06.md src/chapter-07.md src/chapter-08.md src/chapter-09.md src/chapter-10.md src/chapter-11.md src/chapter-12.md src/chapter-13.md src/chapter-14.md src/chapter-15.md src/chapter-16.md src/chapter-17.md src/chapter-18.md src/chapter-19.md src/chapter-20.md src/chapter-21.md src/chapter-22.md src/chapter-23.md src/chapter-24.md src/chapter-25.md src/chapter-26.md src/chapter-27.md src/chapter-28.md src/chapter-29.md src/chapter-30.md src/chapter-31.md src/chapter-32.md src/chapter-33.md src/chapter-34.md src/chapter-35.md src/chapter-36.md src/chapter-37.md src/chapter-38.md src/chapter-39.md src/chapter-40.md src/chapter-41.md src/chapter-42.md src/chapter-43.md src/chapter-44.md src/chapter-45.md src/chapter-46.md src/chapter-47.md src/chapter-48.md src/chapter-49.md src/chapter-50.md src/chapter-51.md src/chapter-52.md src/chapter-53.md src/chapter-54.md src/chapter-55.md src/chapter-56.md src/chapter-57.md src/chapter-58.md src/chapter-59.md src/chapter-60.md src/chapter-61.md src/chapter-62.md src/chapter-63.md src/chapter-64.md src/chapter-65.md src/chapter-66.md src/chapter-67.md src/chapter-68.md src/chapter-69.md src/chapter-70.md src/appendix-a.md src/copyright.md

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
