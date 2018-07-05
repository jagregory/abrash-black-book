FILES=intro.md about.md about_author.md chapter-01.md chapter-02.md chapter-03.md chapter-04.md chapter-05.md chapter-06.md chapter-07.md chapter-08.md chapter-09.md chapter-10.md chapter-11.md chapter-12.md chapter-13.md chapter-14.md chapter-15.md chapter-16.md chapter-17.md chapter-18.md chapter-19.md chapter-20.md chapter-21.md chapter-22.md chapter-23.md chapter-24.md chapter-25.md chapter-26.md chapter-27.md chapter-28.md chapter-29.md chapter-30.md chapter-31.md chapter-32.md chapter-33.md chapter-34.md chapter-35.md chapter-36.md chapter-37.md chapter-38.md chapter-39.md chapter-40.md chapter-41.md chapter-42.md chapter-43.md chapter-44.md chapter-45.md chapter-46.md chapter-47.md chapter-48.md chapter-49.md chapter-50.md chapter-51.md chapter-52.md chapter-53.md chapter-54.md chapter-55.md chapter-56.md chapter-57.md chapter-58.md chapter-59.md chapter-60.md chapter-61.md chapter-62.md chapter-63.md chapter-64.md chapter-65.md chapter-66.md chapter-67.md chapter-68.md chapter-69.md chapter-70.md appendix-a.md copyright.md

.PHONY: html epub

all: html epub mobi

html:
	rm -rf out/html && mkdir -p out/html
	cp html/book.css out/html/
	cd src && pandoc -f markdown+smart --to html5 -o ../out/html/black-book.html --section-divs --toc --standalone --template=../html/template.html $(FILES)

epub:
	mkdir -p out
	rm -f out/black-book.epub
	cd src && pandoc -f markdown+smart --to epub3 -o ../out/black-book.epub --epub-cover-image ../images/cover.png --toc --epub-chapter-level=2 --data-dir=epub --template=../epub/template.html $(FILES)
	
mobi:
	rm -f out/black-book.mobi
	kindlegen out/black-book.epub -c2
