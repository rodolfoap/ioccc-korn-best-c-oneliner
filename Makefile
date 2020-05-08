all: korn original

korn: korn.c
	cc korn.c -o korn

original: original.c
	cc original.c -o original

clean:
	rm -f korn
