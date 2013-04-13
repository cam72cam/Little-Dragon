#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "tree.h"
#include "y.tab.h"


tree_t *make_tree( int type, tree_t *left, tree_t *right )
{
	tree_t *t = (tree_t *)malloc( sizeof(tree_t) );
	assert( t != NULL );

	t->type = type;
	t->left = left;
	t->right = right;

	return t;
}

char op(int id) {
	switch(id){
		case ADDOP:
			return '+';
		case SUBOP:
			return '-';
		case MULOP:
			return '*';
	}
}

void print_tree( tree_t *t, int spaces )
{
	int i;

	if ( t == NULL ) return;

	for (i=0 ; i<spaces; i++)
		fprintf( stderr, " " );

	switch (t->type) {
		case ADDOP:
		case SUBOP:
		case MULOP:
			fprintf( stderr, "[OP:%c]", op(t->type) );
			break;
		case NUM:
			fprintf( stderr, "[NUM:%d]", t->attribute.ival );
			break;
		case IDENT:
			fprintf( stderr, "[IDENT:%s]", t->attribute.sval );
			break;
		default:
			fprintf( stderr, "[UNKNOWN]" );
	}
	fprintf( stderr, "\n" );

	print_tree( t->left, spaces+4 );
	print_tree( t->right, spaces+4 );
}










