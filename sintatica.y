%{
#include <iostream>
#include <string>
#include <sstream>

#define YYSTYPE atributos

using namespace std;

struct atributos
{
	string label;
	string traducao;
};

int yylex(void);
void yyerror(string);
%}

%token TK_INT TK_FLOAT TK_BOOLEAN TK_CHAR TK_STRING
%token TK_MAIN TK_ID TK_TIPO_INT TK_TIPO_FLOAT TK_TIPO_BOOLEAN TK_TIPO_CHAR TK_TIPO_STRING TK_TIPO_VOID
%token TK_FIM TK_ERROR
%token TK_MENOR TK_MAIOR TK_MENOR_IGUAL TK_MAIOR_IGUAL TK_IGUAL TK_DIFERENTE TK_OU TK_E
%token TK_INC TK_DEC 
%token TK_DOIS_PONTOS


%start MAIN

%right '='
%left '+' '-'
%left '*' '/' '%'

%%

MAIN			: TK_TIPO_INT TK_MAIN '(' ')' BLOCO
			{
				cout << "/*Compilador FOCA*/\n" << "#include <iostream>\n#include<string.h>\n#include<stdio.h>\nint main(void)\n{\n" << $5.traducao << "\treturn 0;\n}" << endl; 
		}
			;

			


BLOCO		: '{' COMANDOS '}'
			{
				$$.traducao = $2.traducao;
			}
			;

COMANDOS	: COMANDO COMANDOS
			|
			;

COMANDO 	: E ';'
		;

E : E '*' E {$$.traducao = $1.traducao + $3.traducao + "\ta = b * c;\n";}
			| E '-' E {$$.traducao = $1.traducao + $3.traducao + "\ta = b - c;\n";}
			| E '+' E {$$.traducao = $1.traducao + $3.traducao + "\ta = b + c;\n";}
			| E '/' E {$$.traducao = $1.traducao + $3.traducao + "\ta = b / c;\n";}


			| TK_FLOAT {$$.traducao = "\ta = " + $1.traducao + ";\n";}
		

			| TK_ID
			;

TIPO				: TK_TIPO_INT
					{
						$$.label = "int";
						$$.tipo = "int";
					}
					|	TK_TIPO_FLOAT
					{
						$$.label = "float";
						$$.tipo = "float";
					}
					|	TK_TIPO_BOOLEAN
					{
						$$.label = "boolean";
						$$.tipo = "boolean";
					}
					|	TK_TIPO_STRING
					{
						$$.label = "string";
						$$.tipo = "string";
					}
					|	TK_TIPO_CHAR
					{
						$$.label = "char";
						$$.tipo = "char";
					}
					|	TK_TIPO_VOID
					{
						$$.label = "void";
						$$.tipo = "void";
					}
					; 

%%

#include "lex.yy.c"

int yyparse();

int main( int argc, char* argv[] )
{
	yyparse();

	return 0;
}

void yyerror( string MSG )
{
	cout << MSG << endl;
	exit (0);
}				
