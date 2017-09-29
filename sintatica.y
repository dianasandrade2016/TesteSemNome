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
	string tipo;
};


//info:
//int hashCode(KeyType key);
//HashMap<KeyType, ValueType> map;

typedef struct init atributos;
typedef map<string, atributos> cadeiaMAPA;
cadeiaMAPA RotulosMapa;


int yylex(void);
void yyerror(string);
int tipoToIndice(string tipo);

%}

%token TK_INT TK_FLOAT TK_BOOLEAN TK_CHAR TK_STRING
%token TK_MAIN TK_ID TK_TIPO_INT TK_TIPO_FLOAT TK_TIPO_BOOLEAN TK_TIPO_CHAR TK_TIPO_STRING TK_TIPO_VOID
%token TK_FIM TK_ERROR
%token TK_MENOR TK_MAIOR TK_MENOR_IGUAL TK_MAIOR_IGUAL TK_IGUAL TK_DIFERENTE TK_OU TK_E
%token TK_INC TK_DEC 
%token TK_COUT
%token TK_DOIS_PONTOS


%start BEGIN

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

BEGIN			: MAIN


MAIN			: TK_TIPO_INT TK_MAIN '(' ')' BLOCO
			{
				cout << "/*Compilador FOCA*/\n" << "#include <iostream>\n#include<string.h>\n#include<stdio.h>\nint main(void)\n{\n" << $5.trad << "\treturn 0;\n}" << endl; 
		}
			;

BLOCO		: '{' COMANDOS '}'
			{
				$$.trad = $2.trad;
			}
			;

COMANDOS	: COMANDO COMANDOS
			|
			;

COMANDO 	: E ';'
		;

E : E '*' E {$$.trad = $1.trad + $3.trad + "\ta = b * c;\n";}
			| E '-' E {$$.trad = $1.trad + $3.trad + "\ta = b - c;\n";}
			| E '+' E {$$.trad = $1.trad + $3.trad + "\ta = b + c;\n";}
			| E '/' E {$$.trad = $1.trad + $3.trad + "\ta = b / c;\n";}


			| TK_FLOAT {$$.trad = "\ta = " + $1.trad + ";\n";}
		

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

COUT		 		: TK_COUT '(' E ')'	
					{

						$$.trad = "\tcout << " + $3.rotulo+ " << endl;";

					}
					;

%%

#include "lex.yy.c"

int main( int argc, char* argv[] )
{
	yyparse();

	return 0;
}

int tipoToIndice(string tipo)
{
	if(tipo == "int") 
		return 1;
	else if(tipo == "float") 
		return 2;
	else if(tipo == "string") 
		return 3;
	else if(tipo == "char") 
		return 4;
	else if(tipo == "boolean") 
		return 5;
}

void yyerror( string MSG )
{
	cout << MSG << endl;
	exit (0);
}				
