LEX = lex
YACC = yacc -d

CC = gcc

all: parser clean

parser: y.tab.o lex.yy.o
	$(CC) -o parser y.tab.o lex.yy.o
	./parser < test.txt

lex.yy.o: lex.yy.c y.tab.h
lex.yy.o y.tab.o: y.tab.c

y.tab.c y.tab.h: y.y
	$(YACC) -v y.y

lex.yy.c: lex.l
	$(LEX) lex.l

clean:
	-rm -f *.o lex.yy.c *.tab.* parser *.output