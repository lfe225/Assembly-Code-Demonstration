AFLAGS=-g -o
FLAGS=-g -o
CFLAGS=-g -c -Wall -Wextra -Wwrite-strings
LFLAGS=-g -o prog2

prog2: prog2.o abs.o mult7div8.o area.o max.o sort.o reverse.o sum.o product.o
	gcc ${LFLAGS} prog2.o abs.o mult7div8.o area.o max.o sort.o reverse.o sum.o product.o

prog2.o: prog2.c 
	gcc ${CFLAGS} prog2.c

abs.o: abs.S
	as ${AFLAGS} abs.o abs.S

mult7div8.o: mult7div8.S
	as ${AFLAGS} mult7div8.o mult7div8.S

area.o: area.S
	as ${AFLAGS} area.o area.S

max.o: max.S
	as ${AFLAGS} max.o max.S

sort.o: sort.S
	as ${AFLAGS} sort.o sort.S

reverse.o: reverse.S
	as ${AFLAGS} reverse.o reverse.S

sum.o: sum.S
	as ${AFLAGS} sum.o sum.S

product.o: product.S
	as ${AFLAGS} product.o product.S

clean:
	rm -rf prog1
	rm -rf *.o