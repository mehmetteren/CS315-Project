LEX = lex
YACC = yacc -d

CC = gcc

all: parser clean

parser: y.tab.o lex.yy.o
	$(CC) -o parser y.tab.o lex.yy.o

lex.yy.o: lex.yy.c y.tab.h
lex.yy.o y.tab.o: y.tab.c

y.tab.c y.tab.h: CS315_S23_Team10.y
	$(YACC) -v CS315_S23_Team10.y

lex.yy.c: CS315_S23_Team10.lex
	$(LEX) CS315_S23_Team10.lex

clean:
	-rm -f *.o lex.yy.c *.tab.* *.output