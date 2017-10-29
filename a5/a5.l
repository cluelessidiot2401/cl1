%{
	#include<ctype.h>
	#include<stdio.h>
	#include "y.tab.h"
%}

Digit [0-9]+
Letter [a-zA-Z]+

%% //end of declaration section

{Digit} 	{yylval.p=(char)yytext[0];return Digit;}
{Letter} 	{yylval.p=(char)yytext[0];return Letter;}
. 		{return yytext[0];}
\n 		{return 0;}

%%
