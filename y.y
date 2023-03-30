%{
    #include "stdio.h"
    #include <stdlib.h>
    void yyerror(char *);
    extern int yylineno;
    #include "y.tab.h"
	int yylex(void);
%}
%token BGN END RETURN BREAK BOOL ASSIGN PIPE BOOL_TYPE VOID_TYPE
%token SC LP RP LCB RCB LSB RSB COLON PERCENT COMMA DOT DOLLAR AMPERSAND LB RB
%token STAR PLUS MINUS US SLASH BSLASH QMARK AT OR CARET TILDE EQUAL NOT_EQUAL
%token IF IN ELSE WHILE FOR_EACH FUNC PRINT INPUT COMMENT STRING_CONSTANT VAR
%token DIMP_OP IMP_OP OR_OP AND_OP NOT
%start program
%%

/* INITIAL PROGRAM */
program:
	BGN SC statement_list END SC {printf("\rProgram is valid.\n");};

statement_list:	statement
	|	statement statement_list

statement:	declaration
	|	assignment
	|	conditional_statement
	|	loop_statement
	|	output_statement
	|	input_statement
	|	function_call SC
	|	COMMENT
	|	end_statement

end_statement:	BREAK SC
	|	RETURN bool_expression SC
	|	RETURN array SC

/* DECLARATION & ASSIGNMENT*/
declaration:	BOOL_TYPE variable_list SC // BOOL means "true" or "false", does not mean "bool"
	|	BOOL_TYPE assignment
	|	BOOL_TYPE variable_name LSB RSB SC
	|	function_declaration

assignment:	bool_assignment
	|	array_assignment

bool_assignment:	variable_name ASSIGN bool_expression SC

array_assignment:	variable_name ASSIGN array SC

/* EXPRESSIONS */ 
bool_expressions:	bool_expression 
		| 	bool_expression COMMA bool_expressions
bool_expression:	bool_term
		|	bool_term DIMP_OP bool_expression
		|	bool_term EQUAL bool_expression
		|	bool_term NOT_EQUAL bool_expression
bool_term:	bool_factor
	|	bool_factor IMP_OP bool_term
bool_factor:	bool_secondary
	|	bool_secondary OR_OP bool_factor
bool_secondary:	bool_primary
	|	bool_primary AND_OP bool_secondary
bool_primary:	BOOL
	|	variable_name
	|	NOT bool_primary
	|	LP bool_expression RP
	|	function_call
array:		LSB bool_expressions RSB


/* CONDITIONAL STATEMENTS */
conditional_statement:	if_statement
		|	if_statement else_statement
if_statement:		IF bool_expression LCB statement_list RCB
		|	if_statement ELSE IF bool_expression LCB statement_list RCB
else_statement:		ELSE LCB statement_list RCB


/* LOOPS */
loop_statement:		while_loop | foreach_loop
while_loop:		WHILE bool_expression LCB statement_list RCB
foreach_loop:		FOR_EACH variable_name IN variable_name LCB statement_list RCB
		|	FOR_EACH variable_name IN array LCB statement_list RCB
// function_name is replaced with VAR since they are the same
/* FUNCTION */
function_declaration:	bool_function | void_function
bool_function:		function_identifier BOOL_TYPE function_signature LCB statement_list RCB
void_function:		function_identifier VOID_TYPE function_signature LCB statement_list RCB
function_signature:	VAR LP variable_list RP
function_call:		VAR LP bool_expressions RP //potential conflict with function_signature?
variable_list:		variable_name | variable_name COMMA variable_list 


/* INPUT OUTPUT STATEMENTS */
input_statement:	INPUT LP variable_list RP SC
output_statement:	PRINT LP print_content RP SC
print_content:		STRING_CONSTANT | bool_expression
				|	print_content COMMA STRING_CONSTANT
				|	print_content COMMA bool_expression


/* SYMBOLS */
variable_name: VAR
function_identifier: FUNC

%%
int lineno;
void yyerror(char *s) { fprintf(stderr,"%s on line %d!\n",s, yylineno); };
int main() {
	return yyparse();
}