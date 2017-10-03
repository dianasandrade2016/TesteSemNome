
%{
#include <iostream>
#include <string>
#include <sstream>
#include <map>
#define YYSTYPE init
using namespace std;

struct init
{	
	string rotulo;
	string traducao;
};

int yylex(void);
void yyerror(string);
%}

%token TK_INT TK_FLOAT TK_BOOLEAN TK_CHAR TK_STRING TK_VOID
%token TK_MAIN TK_ID TK_TIPO_INT TK_TIPO_FLOAT TK_TIPO_BOOLEAN TK_TIPO_CHAR TK_TIPO_STRING TK_TIPO_VOID
%token TK_FIM TK_ERROR
%token TK_MENOR TK_MAIOR TK_MENOR_IGUAL TK_MAIOR_IGUAL TK_IGUAL TK_DIFERENTE TK_OU TK_E
%token TK_INC TK_DEC 
%token TK_COUT
%token TK_DOIS_PONTOS
%token TK_ADD_ATRIBUICAO TK_DEL_ATRIBUICAO
%token TK_OR TK_AND

%start ALGORITMO

%right '='
%left '+' '-'
%left '*' '/' '%'
%left TK_INC TK_DEC
%left TK_OU
%left TK_E
%left TK_IGUAL TK_DIFERENTE
%left TK_MENOR TK_MAIOR TK_MENOR_IGUAL TK_MAIOR_IGUAL
%left '(' ')'

%%
%%

#include "lex.yy.c"
int main( int argc, char* argv[] )
{
  	yyparse();
	return 0;
}
void yyerror( string MSG )
{
	cout << MSG << endl;
	exit(0);
}
