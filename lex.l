%option yylineno
letter          [a-zA-Z]
digit           [0-9]
true            ("true")
false           ("false")
bool            {true}|{false}
type            ("bool")
for_each        ("for each")
operations      {and}|{or}|{not}|{implies}|{double_implies}
and             ("and")|(\%\%)
or              ("or")|(\|\|)
not             ("not")|(\!)
implies         ("implies")|(\-\>)
double_implies  ("double_implies")|(\<\-\>)
assign          (\=)
string_constant (\")+(.)*(\")+
variable        {letter}+({letter}*{digit}*(\_)*)*
comment         (\#)+([^\n])*
%%
\;                  printf("SC ");
\(                  printf("LP ");
\)                  printf("RP ");
\{                  printf("LCB ");
\}                  printf("RCB ");
\[                  printf("LSB ");
\]                  printf("RSB ");
\:                  printf("COLON ");
\%                  printf("PERCENT ");
\,                  printf("COMMA ");
\.                  printf("DOT ");
\$                  printf("DOLLOR ");
\&                  printf("AND ");
\<                  printf("LB ");
\>                  printf("RB ");
\*                  printf("START ");
\+                  printf("PLUS ");
\-                  printf("MINUS ");
\_                  printf("US ");
\/                  printf("SLASH ");
\\                  printf("BSLASH ");
\?                  printf("QMARK ");
\@                  printf("AT ");
\|                  printf("OR ");
\^                  printf("CARET ");
\~                  printf("TILDE ");
if                  printf("IF ");
in                  printf("IN ");
else                printf("ELSE ");
while               printf("WHILE ");
func                printf("FUNC ");
input               printf("INPUT ");
print               printf("PRINT ");
{assign}            printf("ASSIGN ");
{for_each}          printf("FOR_EACH ");
{type}              printf("TYPE ");
{bool}              printf("BOOL ");
{and}               printf("AND_OP ");
{or}                printf("OR_OP ");
{implies}           printf("IMP_OP ");
{double_implies}    printf("DIMP_OP ");
{not}               printf("NOT ");
{variable}          printf("VAR ");
{comment}           printf("COMMENT ");
{string_constant}   printf("STRING_CONSTANT ");
[ \t]               ;
%%
int yywrap(){return 1;}

int main(){
    yylex();
    return 0;
}