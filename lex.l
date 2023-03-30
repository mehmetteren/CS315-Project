%{
    #include <stdio.h>
    #include "y.tab.h"
    void yyerror(char *);
%}
letter          [a-zA-Z]
digit           [0-9]
true            ("true")
false           ("false")
bool            {true}|{false}
bool_type       ("bool")
void_type       ("void")
for_each        ("for each")
operations      {and}|{or}|{not}|{implies}|{double_implies}
and             ("and")|(\&\&)
or              ("or")|(\|\|)
not             ("not")|(\!)
newline         \n
implies         ("implies")|(\-\>)
double_implies  ("double-implies")|(\<\-\>)
assign          (\=)
string_constant ((\")+(.)*(\")+)|((\“)+(.)*(\”)+)
variable        {letter}+({letter}*{digit}*(\_)*)*
comment         (\#)+([^\n])*
%option yylineno
%%
\;                  return SC;
\(                  return LP;
\)                  return RP;
\{                  return LCB;
\}                  return RCB;
\[                  return LSB;
\]                  return RSB;
\:                  return COLON;
\%                  return PERCENT;
\,                  return COMMA;
\.                  return DOT;
\$                  return DOLLAR;
\&                  return AMPERSAND;
\<                  return LB;
\>                  return RB;
\*                  return STAR;
\+                  return PLUS;
\-                  return MINUS;
\_                  return US;
\/                  return SLASH;
\\                  return BSLASH;
\?                  return QMARK;
\@                  return AT;
\|                  return PIPE;
\^                  return CARET;
\~                  return TILDE;
\=\=                return EQUAL;
\!\=                return NOT_EQUAL;
break               return BREAK;
begin               return BGN;
end                 return END;
return              return RETURN;
if                  return IF;
in                  return IN;
else                return ELSE;
while               return WHILE;
func                return FUNC;
input               return INPUT;
print               return PRINT;
{assign}            return ASSIGN;
{for_each}          return FOR_EACH;
{bool_type}         return BOOL_TYPE;
{void_type}         return VOID_TYPE;
{bool}              return BOOL;
{and}               return AND_OP;
{or}                return OR_OP;
{implies}           return IMP_OP;
{double_implies}    return DIMP_OP;
{not}               return NOT;
{variable}          return VAR;
{comment}           return COMMENT;
{string_constant}   return STRING_CONSTANT;
{newline}           ;
[ \t]               ;
%%
int yywrap(){return 1;}