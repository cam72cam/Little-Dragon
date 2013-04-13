%{
#include <stdio.h>
#include <string.h>
#include "tree.h"
#define YYSTYPE tree_t*

void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
        return 1;
}
  
main()
{
	printf("start\n");
	yyparse();
} 

%}

%token RPAREN LPAREN ADDOP SUBOP MULOP ASSIGNOP PRINTOP IDENT NUM

%union 
{
	double number;
	char *string;
}

%type<number> NUM
%type<string> IDENT

%%

commands:
	/*empty*/ { printf("empty\n"); }
	|
	commands command { printf("commands\n"); }
	;
command:
	PRINTOP print
	|
	expr
	|
	stmt
	;

print:
	 expr { printf("print"); }

stmt:
	ASSIGNOP IDENT expr { printf("stmt\n");}
	;
expr:
	term expr_ { printf("expr\n"); }
	;
expr_:
	/*empty*/
	|
	ADDOP term expr_ { printf("addop\n"); $$=$2}
	|
	SUBOP term expr_ {printf("subop\n");}
	;
term:
	factor term_{} {printf("term\n");}
	;
term_:
	/*empty*/ { printf("empty\n"); }
	|
	MULOP term { printf("mulop\n"); }
	;
factor:
	RPAREN expr LPAREN { printf("(expr)\n"); $$=$2; }
	|
	NUM { printf("num %d\n", $1); $$=make_tree(0,NULL,NULL); }
	|
	IDENT { printf("ident %s\n", $1); $$=1; } /*TODO LOOKUP*/
	;

%%
