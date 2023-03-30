%option yylineno
letter          [a-zA-Z]
digit           [0-9]
true            ("true")
false           ("false")
bool            {true}|{false}
type            ("bool")|("void")
for_each        ("for each")
operations      {and}|{or}|{not}|{implies}|{double_implies}
and             ("and")|(\&\&)
or              ("or")|(\|\|)
not             ("not")|(\!)
implies         ("implies")|(\-\>)
double_implies  ("double-implies")|(\<\-\>)
assign          (\=)
string_constant ((\")+(.)*(\")+)|((\“)+(.)*(\”)+)
variable        {letter}+({letter}*{digit}*(\_)*)*
comment         (\#)+([^\n])*
%%
\;                  return(SC);
\(                  return(LP);
\)                  return(RP);
\{                  return(LCB);
\}                  return(RCB);
\[                  return(LSB);
\]                  return(RSB);
\:                  return(COLON);
\%                  return(PERCENT);
\,                  return(COMMA);
\.                  return(DOT);
\$                  return(DOLLOR);
\&                  return(AND);
\<                  return(LB);
\>                  return(RB);
\*                  return(START);
\+                  return(PLUS);
\-                  return(MINUS);
\_                  return(US);
\/                  return(SLASH);
\\                  return(BSLASH);
\?                  return(QMARK);
\@                  return(AT);
\|                  return(OR);
\^                  return(CARET);
\~                  return(TILDE);
\=\=                return(EQUAL);
\!\=                return(NOT_EQUAL);
break               return(BREAK);
begin               return(BEGIN);
end                 return(END);
return              return(RETURN);
if                  return(IF);
in                  return(IN);
else                return(ELSE);
while               return(WHILE);
func                return(FUNC);
input               return(INPUT);
print               return(PRINT);
{assign}            return(ASSIGN);
{for_each}          return(FOR_EACH);
{type}              return(TYPE);
{bool}              return(BOOL);
{and}               return(AND_OP);
{or}                return(OR_OP);
{implies}           return(IMP_OP);
{double_implies}    return(DIMP_OP);
{not}               return(NOT);
{variable}          return(VAR);
{comment}           return(COMMENT);
{string_constant}   return(STRING_CONSTANT);
[ \t]               ;
%%
int yywrap(){return 1;}

int main(){
    yylex();
    return 0;
}