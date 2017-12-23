all: korn

korn: korn.c
	cc korn.c -o korn

clean:
	rm -f korn
