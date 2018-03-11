%{
	#include <stdio.h>
    #include "zoomjoystrong.h"

	/** Throws errors **/
	void yyerror(const char* msg);

	/** Generates tokens **/
	int yylex();

	/** The number of statements parsed **/
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
	{ printf("Exiting program..."); finish(); return 0; }
;

statement: line END_STATEMENT
  | point END_STATEMENT
  | circle END_STATEMENT
  | rectangle END_STATEMENT
  | set_color END_STATEMENT
;

line: LINE INT INT INT INT
		{
			printf("%s %d %d %d %d\n", $1, $2, $3, $4, $5);
			num_statements++;
			// Check points are within screen bounds
			if ($2 < WIDTH && $3 < HEIGHT && $4 < WIDTH && $5 < HEIGHT) {
					line($2, $3, $4, $5);
					printf("Line drawn\n");
			} else {
					printf("The parameters are not within %d and %d\n", HEIGHT, WIDTH);
			}
		}
;

point: POINT INT INT
		{
			printf("%s %d %d\n", $1, $2, $3);
			num_statements++;
			// Check points are within screen bounds
			if ($2 < WIDTH && $3 < HEIGHT) {
					point($2, $3);
					printf("Point drawn\n");
			} else {
					printf("The parameters are not within %d and %d\n", HEIGHT, WIDTH);
			}
		}
;

circle: CIRCLE INT INT INT
		{
			printf("%s %d %d %d\n", $1, $2, $3, $4);
			num_statements++;
			// Check points are within screen bounds
			if ($2 < WIDTH && $3 < HEIGHT) {
					circle ($2, $3, $4);
					printf("Circle drawn\n");
			} else {
					printf("The parameters are not within %d and %d\n", HEIGHT, WIDTH);
			}

    }
;

rectangle: RECTANGLE INT INT INT INT
		{
			printf("%s %d %d %d %d\n", $1, $2, $3, $4, $5);
			num_statements++;
			// Check points are within screen bounds
			if ($2 < WIDTH && $3 < HEIGHT) {
					rectangle($2, $3, $4, $5);
					printf("Rectangle drawn\n");
			} else {
					printf("The parameters are not within %d and %d\n", HEIGHT, WIDTH);
			}
		}
;

set_color: SET_COLOR INT INT INT
		{
			printf("%s %d %d %d\n", $1, $2, $3, $4);
			num_statements++;
			// Check values are within RGB bounds
			if ($2 >= 0 && $3 >= 0 && $4 >= 0 && $2 <= 255 && $3 <= 255 && $4 <= 255) {
					set_color($2, $3, $4);
					printf("Color set\n");
			} else {
					printf("The parameters are not within RGB range of 0 and 255\n");
			}

		}
;

%%
/**
 * Prints out the instructions for the program.
 */
void startUpDialog() {
	printf("Valid Commands:\n");
	printf("line x y u v;\n");
	printf("point x y;\n");
	printf("circle x y r;\n");
	printf("rectangle x y w h;\n");
	printf("set_color r g b;\n");
	printf("Type: 'END' to end the program\n\n");
}

/**
 * Sets up the program.
 *
 * argc The number of arguments
 * argv Vector of arguments
 */
int main(int argc, char** argv){
	printf("\n===========[START]===========\n");
	startUpDialog();
	setup();
	yyparse();
  printf("\n\n===========[END]===========\nFound %d statements.\n\n", num_statements);
	return 0;
}

/**
 * Prints out an error if an invalid input is detected.
 *
 * msg The error message thrown
 */
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
