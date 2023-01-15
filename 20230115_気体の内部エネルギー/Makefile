MD = $(wildcard ./*.md)

TEX = $(MD:.md=.pdf)
DRIVER = lualatex
OPTION = -shell-escape

PDF = $(TEX:.tex=.pdf)
AUX = $(TEX:.tex=.aux)
LOG = $(TEX:.tex=.log)

# MD = text.md
MDTEX = $(MD:.md=_md.tex)

ADOC = $(MD:.md=_md.adoc)
ADOCTEX = $(ADOC:.adoc=_ad.tex)
ADTEXOPTION = -a header=no

ADOPTION = -a scripts=cjk -r asciidoctor-diagram -a stylesheet=github.css -a stylesdir=/stylesheets/
# -a pdf-theme=default-with-fallback-font

# .PHONY: clean

# all: $(PDF)

# $(PDF): $(TEX) $(MDTEX) 
# # $(PDF): $(TEX) $(ADOCTEX)
# 	$(DRIVER) $(OPTION) $< -o $(NAME).pdf

# $(MDTEX): $(MD)
# 	$ pandoc $< -o $(MDTEX) 

# $(ADOCTEX): $(ADOC)
# 	$ asciidoctor-latex $< $(ADOCTEXOPTION) -o $(ADOCTEX)

# $(ADOC): $(MD)
# 	$ pandoc $(MD) -o $(MD:.md=_md.adoc)

# clean:
# 	rm $(PDF) $(AUX) $(LOG)


# .SUFFIXES: .tex .dvi .pdf

# NAME = zentai_template
# OPTION = -kanji=euc

# # 標準のターゲット
# all: $(NAME).pdf

# # pdfの依存関係
# $(NAME).pdf: $(NAME).tex $(NAME).dvi
# # 	引数無しでmakeを実行すると、allがターゲットに
# # 	.pdfの作成には、texからdvi、dviからpdfへ変換する必要がある

# # dviが必要ならtexから作成する
# .tex.dvi: 
# 	$ platex $(OPTION) $<

# # pdfが必要ならdviから作成する
# .dvi.pdf:
# 	$ dvipdfmx $<

# clean:
# 	$ rm -rf *.aux *.dvi *.log

# DIR = text
# MD = $(DIR).md
# # ADOC = $(DIR).adoc
# TEX = $(DIR).tex

URL = https://pandoc-doc-ja.readthedocs.io/ja/latest/users-guide.html

PD = pandoc
AD = asciidoctor


MDOPTION = --pdf-engine=$(DRIVER) -V documentclass=ltjsarticle

DRIVER = lualatex
OPTION = -shell-escape

# PDF = $(TEX:.tex=.pdf)
# AUX = $(TEX:.tex=.aux)
# LOG = $(TEX:.tex=.log)

.PHONY: mdad, mdhtml, adhtml, mdadhtml, mdpdf, adpdf, adpdfcss, mdtex, adtex, mddocx, urlmd, texpdf, fclean, clean, re, mdall, adall, all

# Markdown -> asciidoc
mdad: 
	pandoc $(MD) -o $(MD:.md=_md.adoc)

# Markdown -> html
mdhtml: 
	pandoc $(MD) -o $(MD:.md=_md.html)

# Markdown -> asciidoc -> html
mdadhtml: 
	pandoc $(MD) -o $(MD:.md=_md.adoc) && asciidoctor $(ADOC:.adoc=_md.adoc) -o $(ADOC:.adoc=_mdad.html)

# asciidoc -> html
adhtml: 
	$ asciidoctor $(ADOC) -o $(ADOC:.adoc=_ad.html)

# Markdown -> PDF
mdpdf: 
	$ pandoc $(MD) -o $(MD:.md=_md.pdf) $(MDOPTION) 

# asciidoc -> PDF(不調)
adpdf: 
	asciidoctor $(ADOC) -b docbook5 -o - | pandoc -s -f docbook $(MDOPTION) -o $(ADOC:.adoc=_ad.pdf)
# 	asciidoctor-pdf $(ADOC) -o $(ADOC:.adoc=_ad.pdf) $(ADOPTION)

# Markdown->tex
mdtex: $(MD)
	pandoc $< -o $(MD:.md=_md.tex) 
# mdtex: $(MD)
# 	pandoc $< -o $(MD:.md=_md.tex) 

# asciidoc -> tex
adtex: $(ADOC)
	$ asciidoctor-latex $(ADOC) $(ADTEXOPTION) -o $(ADOC:.adoc=_ad.tex)



# URL->Markdown
urlmd:
	$ pandoc $(URL) -o url.md -f html -t markdown

# tex->PDF
texpdf: $(TEX1)
	$(DRIVER) $(OPTION) $<

fclean:
	rm $(PDF) $(AUX) $(LOG)

# clean
clean:
	rm -rf *.aux *.dvi *.log *.pdf

re:
	fclean texpdf

mdall: mdad mdhtml mdadhtml mddocx mdtex mdpdf

adall: adhtml adtex adpdf

all: mdall, adall

# DRIVER = lualatex
# DOCUMENTCLASS = ltjsarticle

# PD = pandoc
# MARKDOWN = 知ってるつもり ｰ無知の科学ｰ.md
# URL = https://pandoc-doc-ja.readthedocs.io/ja/latest/users-guide.html

# .PHONY: all, pdf, tex, docx, fURL, clean

# $(PDF): $(TEX)
# 	$(DRIVER) $(OPTION) $<

# all:
# 	$(PD) $(MARKDOWN) -o $(MARKDOWN:.md=.docx) && $(PD) $(MARKDOWN) -o $(MARKDOWN:.md=.html) && $(PD) $(MARKDOWN) -o $(MARKDOWN:.md=.pdf) --pdf-engine=$(DRIVER) -V documentclass=$(DOCUMENTCLASS) 

# pdf: 
# 	$(PD) $(MARKDOWN) -o $(MARKDOWN:.md=.pdf) --pdf-engine=$(DRIVER) -V documentclass=ltjsarticle 

# tex: 
# 	$(PD) -o $(MARKDOWN:.md=.tex) $(MARKDOWN) 

# docx: 
# 	$(PD) -o $(MARKDOWN:.md=.docx) $(MARKDOWN) 

# fURL:
# 	$(PD) -o url.md -f html -t markdown $(URL)

# clean:
# 	rm $(PDF) $(AUX) $(LOG)