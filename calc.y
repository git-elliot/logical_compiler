%{
 #include <stdio.h>
void yyerror(char *);
int yylex(void);
int sym[26];
%}

%token INTEGER VARIABLE
%left '+' '-'
%left '*' '/'

%%
program:
program statement '\n'
|
;
statement:
expr { printf("%d\n", $1); }
| VARIABLE '=' expr { sym[$1] = $3; }
;


expr: 
INTEGER
| VARIABLE        { $$ = sym[$1];}
| VARIABLE '+' '+' {$$ = sym[$1]+1;}
| expr '+' expr   { $$ = $1 + $3;}
| expr '-' expr   { $$ = $1 - $3;}
| expr '*' expr   { $$ = $1 * $3;}
| expr '/' expr   { if($3==0){yyerror("Division by 0 error");} else{$$ = $1/$3;} }
| '(' expr ')'    { $$ = $2; }
;
%%
#include "lex.yy.c"
void yyerror(char *s) {
fprintf(stderr, "%s\n", s);
}
int main(int argc , char * argv[]) {
    if(argv[1] != "console"){
		
		yyin = fopen(argv[1],"r");
	}
	
    if(!yyparse()){
		
		printf("Parsing Complete\n");
	}
	else{
		
		printf("Parsing Failed\n");
	}
	
	fclose(yyin);
return 0;
}
