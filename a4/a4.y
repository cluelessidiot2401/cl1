%{
	#include<stdio.h>
%}

%token DATATYPE,IDENTIFIER,NUMBER,EOL,LB,RB,COMMA,HASH,LT,GT,INCLUDE,BLOCK,HEADER_FILE,DEFINE,OCB,CCB,STATEMENT

%%
	pgm: header other {printf("\nValid Expression\n");} 
	header: HASH INCLUDE LT HEADER_FILE GT header|HASH DEFINE IDENTIFIER NUMBER header| ; 
	other:fun_name part other|  ;
	fun_name: declaration LB parameters RB ;
	part: block|EOL ;
	block: OCB stmt CCB ;
	stmt: STATEMENT stmt|block stmt| ;
	parameters: declaration t| ;
	t:COMMA declaration t| ;
	declaration: DATATYPE IDENTIFIER ;
%%

extern FILE *yyin;
extern char *yytext;

void main()
{
	char fname[25];
	printf("\nENter File Name: ");
	scanf("%s",fname);
	yyin=fopen(fname,"r");
	yyparse();
	fclose(yyin);
	printf("\nString Parsed Successfully: ");
}

void yyerror(char *s)
{
	printf("ERROR");
}

