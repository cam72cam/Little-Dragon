%{
#include <stdio.h>
#include <string.h>
 
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

%token NUM IDENT RPAREN LPAREN ADDOP SUBOP MULOP ASSIGNOP
%%

commands:
	/*empty*/ { printf("empty\n"); }
	|
	commands command { printf("commands\n"); }
	;
command:
	expr
	|
	stmt 
	;

stmt:
	ASSIGNOP IDENT expr { printf("stmt\n");}
	;
expr:
	term expr_ { printf("expr\n"); }
	;
expr_:
	/*empty*/
	|
	ADDOP term expr_ { printf("addop\n"); }
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
	RPAREN expr LPAREN { printf("(expr)\n");}
	|
	NUM { printf("num\n"); }
	|
	IDENT { printf("ident\n"); }
	;

%%
