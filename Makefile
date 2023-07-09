NAME = 
SRCS = 0*.md
OBJ = CommonGround.pdf

%:
	pandoc ${@:=.md} -o ${@:=.pdf} --pdf-engine=lualatex -V documentclass=ltjsarticle

all: $(OBJ)

$(OBJ):
	pandoc $(SRCS) -o $(OBJ) --pdf-engine=lualatex -V documentclass=ltjsarticle

clean:
	rm -f $(OBJ)

fclean:	clean
	rm -f $(NAME)

re:	fclean all