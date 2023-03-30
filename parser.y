/* parser.y */
%{
	int yylex();
	void yyerror();
	#include <stdio.h>
	int lineno;
%}
%token BEGIN END RETURN BREAK BOOL ASSIGN
%token SC LP RP LCB RCB LSB RSB COLON PERCENT COMMA DOT DOLLOR AND LB RB
%token STAR PLUS MINUS US SLASH BSLASH QMARK AT OR CARET TILDE EQUAL NOT_EQUAL
%token IF IN ELSE WHILE FUNC INPUT VOID

%start program
%%

/* INITIAL PROGRAM */
program:
	BEGIN SC statement_list END SC {printf("\rProgram is valid.\n");};

statement_list:	statement
	|	statement statement_list
	;

statement:	declaration
	|	assignment
	|	if_statement
	|	loop_statement
	|	output_statement
	|	input_statement
	|	function_signature
	|	LINE_COMMENT
	|	end_statement
	;

end_statement:	BREAK SC
	|	RETURN bool_expression SC
	|	RETURN array SC
	;

/* DECLARATION & ASSIGNMENT*/
declaration:	BOOL variable_list SC
	|	BOOL assignment SC
	|	BOOL variable_name LSB RSB SC
	|	function_declaration
	;

assignment:	bool_assignment
	|	array_assignment
	;

bool_assignment:	variable_name ASSIGN bool_expression SC;

array_assignment:	variable_name ASSIGN array SC;

/* EXPRESSIONS */ 
bool_expressions:	bool_expression 
		| 	bool_expression COMMA bool_expressions
		;
bool_expression:	bool_term
		|	bool_term double_imp_op bool_expression
		|	bool_term equal_op bool_expression
		|	bool_term not_equal_op bool_expression
		;
bool_term:	bool_factor
	|	bool_factor imp_op bool_term
	;
bool_factor:	bool_secondary
	|	bool_secondary or_op bool_factor
	;
bool_secondary:	bool_primary
	|	bool_primary and_op bool_secondary
	;
bool_primary:	bool_literal
	|	variable_name
	|	not_op bool_primary
	|	lp bool_expression rp
	|	func_call
	;
array:		lsquare bool_expressions rsquare;
/* CONDITIONAL STATEMENTS */
conditional_statement:	if_statement
		|	if_statement else_statement
		;
if_statement:		IF bool_expression LCB statement_list RCB
		|	if_statement ELSE IF bool_expression LCB statement_list RCB
		;
else_statement:		ELSE LCB statement_list RCB;
/* LOOPS */
loop_statement:		while_loop | foreach_loop;
while_loop:		WHILE bool_expression LCB statement_list RCB;
foreach_loop:		FOR_EACH variable_name IN variable_name LCB statement_list RCB
		|	FOR_EACH variable_name IN array LCB statement_list RCB
		;
/* FUNCTION */
function_declaration:	bool_function | void_function;
bool_function:		function_identifier BOOL function_signature LCB statement_list RCB;
void_function:		function_identifier VOID function_signature LCB statement_list RCB;
function_signature:	function_name LP variable_list RP;
function_call:		function_name LP bool_expressions RP;
variable_list:		variable_name | variable_name COMMA variable_list;
%%
#include "lex.yy.c"
void yyerror(char *s) { printf("%s", s); }
int main() {
	return yyparse();
}
