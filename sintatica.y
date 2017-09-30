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
	string trad;
};

int yylex(void);
void yyerror(string);
%}

%token TK_INT TK_FLOAT TK_BOOLEAN TK_CHAR TK_STRING
%token TK_MAIN TK_ID TK_TIPO_INT TK_TIPO_FLOAT TK_TIPO_BOOLEAN TK_TIPO_CHAR TK_TIPO_STRING TK_TIPO_VOID
%token TK_FIM TK_ERROR
%token TK_MENOR TK_MAIOR TK_MENOR_IGUAL TK_MAIOR_IGUAL TK_IGUAL TK_DIFERENTE TK_OU TK_E
%token TK_INC TK_DEC 
%token TK_COUT
%token TK_DOIS_PONTOS

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
ALGORITMO	:INICIO ALGORITMO {cout << "\t teste1 \n" << endl;}
		|DECLARACAO_VARIAVEIS
		|FUNCAO
		|DECLARACAO_VARIAVEIS ALGORITMO
		|FUNCAO ALGORITMO
		;

INICIO		:MAIN
		:TK_TIPO_INT TK_MAIN '(' ')'
		{cout <<"\t teste2 \n" << endl;}
		;

FUNCAO		:TIPO ID PARAMETROS '(' COMANDOS ')'
		|TIPO ID PARAMETROS '(' TIPO_FUNCAO COMANDOS ')'
		;

TIPO_FUNCAO	:DECLARACAO_VARIAVEIS
		|DECLARACAO_VARIAVEIS TIPO_FUNCAO
		;

PARAMETROS	:'(' ')'
		|'(' ')'
		;

TIPO_PARAMETROS	:TIPO ID
		|TIPO ID SEP_EXPR TIPO_PARAMETROS
		;

COMANDOS	:LISTA_COMANDOS
		|LISTA_COMANDOS COMANDOS
		;
BLOCO:		:'{' COMANDOS '}'
		;
	
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
