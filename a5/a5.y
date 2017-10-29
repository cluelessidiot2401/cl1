%{
	#include<stdio.h>
	#include<string.h>
	#include <stdlib.h>
	#include <ctype.h>
	char addintotable(char,char,char);
	int search(char);

	struct icode
	{
		char op1;
		char op2;
		char op;
		char res;
	}code[20];
	int yylex();
	void yyerror(const char *);
	//int yywrap();

	int index1=0;
%}

%union
{
	char p;
}

%token <p> Letter Digit
%type <p> expr
%left '-''+'
%left '*''/'
%% //end of declaration section

	stat:Letter '=' expr ';' {addintotable((char)$1,(char)$3,'=');}
	|expr ';'
	; 
	expr:expr '+' expr {$$=addintotable((char)$1,(char)$3,'+');}
	|expr '-' expr {$$=addintotable((char)$1,(char)$3,'-');}
	|expr '*' expr {$$=addintotable((char)$1,(char)$3,'*');}
	|expr '/' expr {$$=addintotable((char)$1,(char)$3,'/');}
	|'('expr')' {$$=(char)$2;}
	|Digit {$$=(char)$1;}
	|Letter {$$=(char)$1;}
	; 
%% //end of rules section

int yywrap()
{
	return 1;
}

void yyerror(const char *s)
{
	printf("hey vaibhav!! error %s",s);
}

char temp='A';
char addintotable(char op1,char op2,char op)
{
	temp++;
	code[index1].op1=op1;
	code[index1].op2=op2;
	code[index1].op=op;
	code[index1].res=temp;
	index1++;
	return temp;
}

void threeaddress()
{
	int cnt=0;
	char temp='A';
	temp++;
	printf("\nThe three address code is:\n");
	while(cnt<index1)
	{
		printf("%c:=\t",temp);
		printf("%c\t",code[cnt].op1);
		printf("%c\t",code[cnt].op);

		printf("%c\t",code[cnt].op2);
		temp++;
		cnt++;
		printf("\n");
	}
}

void quadruple()
{
	int cnt=0;
	char temp='A';
	temp++;
	printf("\nThe Quadruple format is:\n");
	printf("Operator\tArg1\tArg2\tResult\n");
	while(cnt<index1)
	{
		printf("%c\t\t",code[cnt].op);
		printf("%c\t",code[cnt].op1);
		printf("%c\t",code[cnt].op2);
		printf("%c\t",code[cnt].res);
		temp++;
		cnt++;
		printf("\n");
	}
}

void triple()
{
	int cnt=0;
	int flag;
	char temp='A';
	temp++;
	printf("\nThe Triple format is:\n");
	printf("Arg1\tArg2\toperator\n");
	while(cnt<index1)
	{
		if(isalpha(code[cnt].op1) && isupper(code[cnt].op1))
		{
			flag= search(code[cnt].op1);
			printf("%d\t",flag);
		}

		else //if(isalpha(code[cnt].op1))
			printf("%c\t",code[cnt].op1);

		if(isalpha(code[cnt].op2) && isupper(code[cnt].op2))
		{
			flag= search(code[cnt].op2);

			printf("%d\t",flag);
		}

		else //if(isalpha(code[cnt].op2))
			printf("%c\t",code[cnt].op2);

		printf("%c\t",code[cnt].op);
		printf("\n");
		cnt++;
	}
}

int search(char find)
{
	int i;

	for(i=0;i<index1;i++)
	{
		if(code[i].res==find)
		return(i);
	}

	return 0;
}

int main()
{
	yyparse();
	threeaddress();
	quadruple();
	triple();
}
