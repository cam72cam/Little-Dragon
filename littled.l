%{
#include <stdio.h>
#include "y.tab.h"
#define MAX_IDENT 40
%}

%%


[0-9]+		{ yylval = make_tree(NUM, NULL, NULL); yylval->attribute.ival = atof(yytext); return NUM; }
[a-zA-Z]+	{ 
				yylval = make_tree(IDENT, NULL, NULL);
				yylval->attribute.sval = malloc(sizeof(char) * (strnlen(yytext, MAX_IDENT) + 1));
				strncpy(yylval->attribute.sval, yytext, strnlen(yytext, MAX_IDENT)); return IDENT;
			}

\(			return RPAREN;
\)			return LPAREN;

[+]			return ADDOP;
[-]			return SUBOP;
[*]			return MULOP;
[;]			return ENDSTMT;

[=]			return ASSIGNOP;
[>]			return PRINTOP;

\n                      /* ignore end of line */;
[ \t]+                  /* ignore whitespace */;
%%


