# ioccc-korn-best-c-oneliner
A brief analysis of [korn.c](http://www.ioccc.org/1987/korn/korn.c), winner of the 1987 [IOCCC](http://www.ioccc.org/). Why? [Because](http://www.ioccc.org/1987/korn/hint.html). Because it's beautiful. And because many people who shot some explanations have many flaws and conceptual mistakes.

```
#include <stdio.h>
/*
* Review of one of the best IOCCC one liner winners.
* See International Obfuscated C Code Contest (http://www.ioccc.org)
* ...found other reviews with conceptual mistakes, so I wrote mine...
*
* Winners:  http://www.ioccc.org/years.html#1987
* The code: http://www.ioccc.org/1987/korn.c
* Hints:    http://www.ioccc.org/1987/korn.hint
*
* Rodolfo Alcazar Portillo <rodolfoap@gmail.com>
* Original post in http://otbits.blogspot.fr/2009/06/ioccc-best-one-liner.html
*/

main() {
	/* a simple text */
	printf("%s\n", "unix");

	/* or... */
	printf("%six\n", "un");

	/* adding an unnecesary C text terminator does not change output */
	printf("%six\n\0", "un");

	/* replace \n==\012 which is a printable form of an octal value */
	printf("%six\012\0", "un");

	/* the additional X won't print due to +1 offset */
	printf("X%six\012\0" + 1, "un");

	/* nor any other character */
	printf("\021%six\012\0" + 1, "un");

	/* rephrasing syntax as a text array */
	printf(&"\021%six\012\0"[1], "un");

	/* And the preprocessor said "Let unix==1". Verification
	*      $ cpp -dM /dev/null | grep unix
	*   #define __unix__ 1
	*   #define __unix 1
	*   #define unix 1
	*
	* Therefore it won't run on Windows unless compiled with cygwin or defined in preprocessor as:
	* #define unix 1
	*
	* ...and therefore redefining the unix variable would raise an error.
	*/
	printf(&"\021%six\012\0"[unix], "un");

	/* &text[n]==&n[text] is basic pointer arithmetics, or addition communitivity */
	printf(&unix["\021%six\012\0"], "un");

	/* 'a'==0x61 then ('a'-0x61)==0 */
	printf(&unix["\021%six\012\0"], "un" + 'a' - 0x61);

	/* Then add any char -X- and a offset of 1 (=='a'-0x60) */
	printf(&unix["\021%six\012\0"], "Xun" + 'a' - 0x60);

	/* use a double-quoted string, and its offset, which gives an integer value: 'a'=="a"[0] */
	printf(&unix["\021%six\012\0"], "Xun" + "a"[0] - 0x60);

	/* or the same, with an arbitrary text and offset */
	printf(&unix["\021%six\012\0"], "Xun" + "XaXX"[1] - 0x60);

	/* again, replace 1 with the predefined preprocessor unix==1 value...  */
	printf(&unix["\021%six\012\0"], "Xun" + "XaXX"[unix] - 0x60);

	/* rephrasing, array pointer arithmetics, addition is communitive */
	printf(&unix["\021%six\012\0"], "Xun" + (unix)["XaXX"] - 0x60);

	/* ditto */
	printf(&unix["\021%six\012\0"], (unix)["XaXX"] + "Xun" - 0x60);

	/* at last, change ignored chars to something meaningful */
	printf(&unix["\021%six\012\0"], (unix)["have"] + "fun" - 0x60);

	return 0;
}
```
