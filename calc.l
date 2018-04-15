%{
#include <stdlib.h>
void yyerror(char *);
#include "calc.tab.h"
%}
%%
[a-z] {
          yylval = *yytext - 'a';
          return VARIABLE;
       }

[0-9]+ {
           yylval = atoi(yytext);
           return INTEGER;
        }
<<<<<<< HEAD
[-+()=/,:*\n] { return *yytext; }
=======
[-+()=/<>,*:?\n] { return *yytext; }
>>>>>>> 1c1f6ac102e3ed7d65d0f002bb035f888a0bf894
[ \t] ;
"<="    return LE;
">="    return GE;
"=="    return EQ;
"!="    return NE;
">"	return GT;
"<"	return LT;
. yyerror("invalid character");
%%
int yywrap(void) {
return 1;
}
