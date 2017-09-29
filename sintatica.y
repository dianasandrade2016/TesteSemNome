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
%token TK_MAIN TK_ID TK_TIPO_INT TK_TIPO_FLOAT
%token TK_FIM TK_ERROR

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
