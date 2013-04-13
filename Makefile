main: lex yacc
	cc lex.yy.c y.tab.c -o littled
lex: littled.l
	lex littled.l
yacc: littled.y
	yacc -d -y littled.y
clean:
	rm lex.yy.c littled  y.tab.c  y.tab.h
