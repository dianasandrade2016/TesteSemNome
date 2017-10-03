%{
#include <string>

%}

ESPACO [ \t]
DIGITO [0-9]
LETRA [A-Za-z_]
PONTUACAO [!?.,;:]

DELIM 		{ESPACO}+
NUM 		{DIGITO}+
TAMANHO 	{DIGITO}+

CARACTERE {LETRA}|{NUM}|{PONTUACAO}

REAL 		{NUM}+("."{NUM}+)?
CHAR 		\'({CARACTERE})\'
ID 		{LETRA}({LETRA}|{NUM})*
BOOLEAN 	"TRUE"|"FALSE"
STRING 		\'{DELIM}*{CARACTERE}+({DELIM}*{CARACTERE}+)*{DELIM}*\'|\"{DELIM}*{CARACTERE}+({DELIM}*{CARACTERE}+)*{DELIM}*\"

%%

"\n"		{}
{DELIM} 	{}
"return"
"break"		{return TK_BREAK;}
"switch"	{return TK_SWITCH;}
"case"		{return TK_CASE;}
"do"		{return TK_DO;}
"while"		{return TK_WHILE;}
"for"		{return TK_FOR;}
"if"		{return TK_IF;}
"else"		{return TK_ELSE;}
"scanf"		{return TK_SCANF;}
"define"	{return TK_DEFINE;}
"exit"		{return TK_EXIT;}
"void"		{return TK VOId;}
"char"		{return TK CHAR;}

"main"		{return TK_MAIN;}

"int"		{return TK_TIPO_INT;}

"float"		{ return TK_TIPO_FLOAT; }

[(){}[\];,]	{ return *yytext; }

[+\-*/]		{ return *yytext; }
"<"		{ return TK_MENOR; }
">"		{ return TK_MAIOR; }
"<="		{ return TK_MENOR_IGUAL; }
">="		{ return TK_MAIOR_IGUAL; }
"=="		{ return TK_IGUAL; }
"!="		{ return TK_DIFERENTE; }
"||"		{ return TK_OU; }
"&&"		{ return TK_E; }

"++"		{ return TK_INC; }
"--"		{ return TK_DEC; }
":"		{ return TK_DOIS_PONTOS; }

"=+"		{ return TK_ADD_ATRIBUICAO; }
"=-"		{ return TK_DEL_ATRIBUICAO; }

{NUM}		{ yylval.tradicao = yytext; return TK_INT; }
{REAL}		{ yylval.tradicao = yytext; return TK_FLOAT; }
{BOOLEAN}	{ yylval.tradicao = yytext; return TK_BOOLEAN; }
{CHAR}		{ yylval.tradicao = yytext; return TK_CHAR; }
{STRING}	{ yylval.tradicao = yytext; return TK_STRING; }
{ID}		{ yylval.rotulo = yytext; return TK_ID; }

.		{ *yytext; }

%%
