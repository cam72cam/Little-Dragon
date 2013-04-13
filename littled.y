%code requires
{
#include "tree.h"
}

%{
#include <stdio.h>
#include <string.h>
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

%token RPAREN LPAREN ADDOP SUBOP MULOP ASSIGNOP PRINTOP IDENT NUM ENDSTMT

%%

commands:
	/*empty*/ | commands command ENDSTMT { printf("=========================================\n"); }
	;
command:
	print | expr | stmt;

print:
	 PRINTOP expr { print_tree($2, 0); }
stmt:
	IDENT ASSIGNOP expr { printf("stmt\n"); $$ = $1; $$ -> left = $3; print_tree($$, 0); }
	;
expr:
	term expr_
	{
		if($2 == NULL) {
			$$ = $1;
		} else {
			$$=$2;
			$$->left = $1;
		}
	}
	;
expr_:
	/*empty*/{ $$ = NULL; }
	|
	ADDOP term expr_
	{
		if($3 == NULL) {
			$$ = make_tree(ADDOP, NULL, $2);
		} else {
			$3 -> left = $2;
			$$ = make_tree(ADDOP, NULL, $3);
		}
	}
	|
	SUBOP term expr_
	{
		if($3 == NULL) {
			$$ = make_tree(SUBOP, NULL, $2);
		} else {
			$3 -> left = $2;
			$$ = make_tree(SUBOP, NULL, $3);
		}
	}
	;
term:
	factor term_
	{
		if($2 == NULL) {
			$$ = $1;
		} else {
			$2 -> left = $1;
			$$ = $2;
		}
	}
	;
term_:
	/*empty*/ { $$=NULL; }
	|
	MULOP term
	{
		$$=make_tree(MULOP, NULL, $2);
	}
	;
factor:
	RPAREN expr LPAREN { $$=$2; }
	|
	NUM { $$=$1; }
	|
	IDENT { $$=$1; }
	;

%%
