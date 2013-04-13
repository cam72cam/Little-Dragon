%{
#include <stdio.h>
#include "y.tab.h"
%}

%%


[0-9]+		yylval.number = atof(yytext); return NUM;
[a-zA-Z]+	yylval.string = yytext; return IDENT;

\(			return RPAREN;
\)			return LPAREN;

\+			return ADDOP;
\-			return SUBOP;
\*			return MULOP;

\=			return ASSIGNOP;
\>			return PRINTOP;

\n                      /* ignore end of line */;
[ \t]+                  /* ignore whitespace */;
%%


