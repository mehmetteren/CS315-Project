%option yylineno
letter          [a-zA-Z]
digit           [0-9]
true            ("true")
false           ("false")
bool            {true}|{false}
type            ("bool")
operations      {and}|{or}|{not}|{implies}|{double_implies}
and             ("and")|(\%\%)
or              ("or")|(\|\|)
not             ("not")|(\!)
implies         ("implies")|(\-\>)
double_implies  ("double_implies")|(\<\-\>)
assign          (\=)
string_constant (\"(.)*\")
comment         (\#)+([^\n])*
variable        {letter}+({letter}*{digit}*)*
%%
\;                  printf("SC ");
\(                  printf("LP ");
\)                  printf("RP ");
if                  printf("IF ");
for                 printf("FOR ");
each                printf("EACH ");
in                  printf("IN ");
else                printf("ELSE ");
while               printf("WHILE ");
{type}              printf("TYPE ");
{bool}              printf("BOOL ");
{and}               printf("AND_OP ");
{or}                printf("OR_OP ");
{implies}           printf("IMP_OP ");
{double_implies}    printf("DIMP_OP ");
{not}               printf("NOT ");
{variable}          printf("VAR ");
%%
int yywrap(){return 1;}

int main(){
    yylex();
    return 0;
}