main: lex yacc
	cc lex.yy.c y.tab.c tree.c -o littled -DYYSTYPE=tree_t*
lex: littled.l
	lex littled.l
yacc: littled.y
	yacc -d -y littled.y
clean:
	rm lex.yy.c littled  y.tab.c  y.tab.h
