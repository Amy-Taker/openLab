NAME = 
# SRCS = 01_CommonGround.md 02_Grounding.md 03_ComputeModel.md
SRCS = 0*.md
OBJ = Submit.pdf

all: $(OBJ)

$(OBJ): $(SRCS)
	pandoc $^ -o $@ --pdf-engine=lualatex -V documentclass=ltjsarticle

# $(SRCS):
# 	pandoc ${@:=.md} -o ${@:=.pdf} --pdf-engine=lualatex -V documentclass=ltjsarticle

clean:
	rm -f $(OBJ)

re:	clean all

%.pdf:
	pandoc $*.md -o $@ --pdf-engine=lualatex -V documentclass=ltjsarticle

#%:
#	pandoc ${@:=.md} -o ${@:=.pdf} --pdf-engine=lualatex -V documentclass=ltjsarticle
