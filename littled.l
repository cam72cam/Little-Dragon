%{
#include <stdio.h>
#include "y.tab.h"
%}

%%


[0-9]+		{ yylval = make_tree(NUM, NULL, NULL); yylval->attribute.ival = atof(yytext); return NUM; }
[a-zA-Z]+	{ yylval = make_tree(IDENT, NULL, NULL); yylval->attribute.sval = yytext; return IDENT; }

\(			return RPAREN;
\)			return LPAREN;

[+]			return ADDOP;
[-]			return SUBOP;
[*]			return MULOP;
[;]			return ENDSTMT;

\=			return ASSIGNOP;
\>			return PRINTOP;

\n                      /* ignore end of line */;
[ \t]+                  /* ignore whitespace */;
%%


