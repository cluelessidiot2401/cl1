%{
	#include "y.tab.h"
%}

%%
[\t\n]+ ;
int|float|char|long|double {return DATATYPE; }
\# {return HASH; }
include {return INCLUDE; }
define {return DEFINE;}
printf\(.*\)\; {return STATEMENT; }
\< {return LT;}
\> {return GT; }
\( {return LB;}
\) {return RB;}
\, {return COMMA; }
\{ {return OCB;}
\} {return CCB;}
\; {return EOL; }
[a-zA-Z_]+[a-zA-Z0-9_]*\.h {return HEADER_FILE;}
[a-zA-Z_]+[a-zA-Z0-9_]* {return IDENTIFIER;}
[0-9]+ {return NUMBER;}
[0-9]+\.[0-9]+ {return NUMBER;}
%%

