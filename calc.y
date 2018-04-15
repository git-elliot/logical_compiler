%{
 #include <stdio.h>
void yyerror(char *);
int yylex(void);
int sym[26];
%}

%token INTEGER VARIABLE BOOLEAN
%left '+' '-'
%left '*' '/'
%left '<' '>' LE GE EQ NE LT GT
%%
program:
program statement '\n'
|
;
statement:
expr { printf("%d\n", $1); }
| lexpr { printf("%d\n",$1);}
| statement ',' statement
| VARIABLE '=' expr { sym[$1] = $3; }
| VARIABLE '=' lexpr { sym[$1] =$3; }
;

   
lexpr : INTEGER         
| lexpr GT lexpr { if($1 > $3){ $$ = 1;}else { $$ =0;}}
| lexpr LT lexpr { if($1 < $3){ $$ = 1;}else { $$ =0;}}
| lexpr EQ lexpr {if($1 == $3){ $$ = 1;}else { $$ =0;} }
| lexpr '?' INTEGER ':' INTEGER {  if($1==1){ $$=$3;}else{ $$=$5;} } 
| lexpr '>' lexpr { if($1 > $3){ $$ = 1;}else { $$ =0;}}
| lexpr '<' lexpr { if($1 < $3){ $$ = 1;}else { $$ =0;}}
| lexpr '=' '=' lexpr {if($1 == $4){ $$ = 1;}else { $$ =0;} }
| lexpr '?' INTEGER ':' INTEGER {  if($1==1){ $$=$3;}else{ $$=$5;} } 
| '(' lexpr ')'    { $$ = $2; }

;

expr: 
INTEGER
| VARIABLE        { $$ = sym[$1];}
| VARIABLE '+' '+' {$$ = sym[$1]+1;}
| VARIABLE '+' '=' expr { $$ = sym[$1]+$4; sym[$1]=$$;}
| VARIABLE '*' '=' expr { $$ = sym[$1]*$4; sym[$1]=$$;}
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
