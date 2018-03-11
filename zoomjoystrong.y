%{
	#include <stdio.h>
  #include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();
  int num_statements = 0;
%}

%error-verbose
%start statement_list

%union { int i; char* str; float f;}

%token END
%token END_STATEMENT
%token LINE
%token POINT
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%type<i> INT
%type<f> FLOAT
%type<str> LINE
%type<str> POINT
%type<str> CIRCLE
%type<str> RECTANGLE
%type<str> SET_COLOR


%%
statement_list: statement
  | statement statement_list
  | END
;

statement: line END_STATEMENT
  | point END_STATEMENT
  | circle END_STATEMENT
  | rectangle END_STATEMENT
  | set_color END_STATEMENT
;

line: LINE INT INT INT INT
		{ printf("%s %d %d %d %d\n", $1, $2, $3, $4, $5); num_statements++;
      line($2, $3, $4, $5); }
;

point: POINT INT INT
		{ printf("%s %d %d\n", $1, $2, $3); num_statements++;
      point ($2, $3); }
;

circle: CIRCLE INT INT INT
		{ printf("%s %d %d %d\n", $1, $2, $3, $4); num_statements++;
      circle($2, $3, $4); }
;

rectangle: RECTANGLE INT INT INT INT
		{ printf("%s %d %d %d %d\n", $1, $2, $3, $4, $5); num_statements++;
      rectangle($2, $3, $4, $5); }
;

set_color: SET_COLOR INT INT INT
		{ printf("%s %d %d %d\n", $1, $2, $3, $4); num_statements++;
      set_color($2, $3, $4); }
;

end: END
    { finish(); }
;

%%
int main(int argc, char** argv){
	printf("\n==========\n");
	setup();
	yyparse();
  printf("\n\n==========\nFound %d statements.\n\n", num_statements);
	return 0;
}
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
