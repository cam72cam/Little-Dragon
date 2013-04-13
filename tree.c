#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "token.h"
#include "tree.h"


tree_t *make_tree( int type, tree_t *left, tree_t *right )
{
	tree_t *t = (tree_t *)malloc( sizeof(tree_t) );
	assert( t != NULL );

	t->type = type;
	t->left = left;
	t->right = right;

	return t;
}

void print_tree( tree_t *t, int spaces )
{
	int i;

	if ( t == NULL ) return;

	for (i=0 ; i<spaces; i++)
		fprintf( stderr, " " );

	switch (t->type) {
	case '+':
	case '-':
	case '*':
		fprintf( stderr, "[OP:%c]", t->type );
		break;
	case NUM:
		fprintf( stderr, "[NUM:%d]", t->attribute.ival );
		break;
	default:
		fprintf( stderr, "[UNKNOWN]" );
	}
	fprintf( stderr, "\n" );

	print_tree( t->left, spaces+4 );
	print_tree( t->right, spaces+4 );
}










