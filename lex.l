%{
    #include <stdio.h>
    void yyerror(char *);
%}
letter          [a-zA-Z]
digit           [0-9]
true            ("true")
false           ("false")
bool            {true}|{false}
variable        {letter}+({letter}*{digit}*{\_}*)*
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
%option yylineno
%%
variable        printf("VAR ");
type            printf("TYPE ");
if              printf("IF ");
for             printf("FOR ");
each            printf("EACH ");
in              printf("IN ");
else            printf("ELSE ");
while           printf("WHILE ");
bool            printf("BOOL ");
and             printf("AND_OP ");
or              printf("OR_OP ");
implies         printf("IMP_OP ");
double_implies  printf("DIMP_OP ");
not             printf("NOT ");
\;              printf("SC ");
%%
int yywrap(void){return 1;}