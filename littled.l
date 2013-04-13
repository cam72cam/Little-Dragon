%{
#include <stdio.h>
#include "y.tab.h"
%}

%%


[0-9]+		return NUM;
[a-zA-Z]+	return IDENT;

\(			return RPAREN;
\)			return LPAREN;

\+			return ADDOP;
\-			return SUBOP;
\*			return MULOP;

=			return ASSIGNOP;

\n                      /* ignore end of line */;
[ \t]+                  /* ignore whitespace */;
%%


