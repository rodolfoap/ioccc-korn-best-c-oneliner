# ioccc-korn-best-c-oneliner
A brief analysis of [korn.c](http://www.ioccc.org/1987/korn/korn.c), winner of the 1987 [IOCCC](http://www.ioccc.org/). Why? [Because](http://www.ioccc.org/1987/korn/hint.html). Because it's beautiful. And because many people who shot some explanations have many flaws and conceptual mistakes.

The one-liner:
```
main() { printf(&unix["\021%six\012\0"],(unix)["have"]+"fun"-0x60);}
```
The output:
```
unix
```
Judges' comments:
http://www.ioccc.org/1987/korn/hint.html
