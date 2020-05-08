# ioccc-korn-best-c-oneliner
Un breve análisis de [korn.c](http://www.ioccc.org/1987/korn/korn.c), ganador del [IOCCC](http://www.ioccc.org/) 1987 y calificado por los jueces como el mejor one-liner jamás enviado. Porqué? [Porque eso](http://www.ioccc.org/1987/korn/hint.html). Porque es una maravilla. Y porque muchos publicaron explicaciones con múltiples fallas y errores conceptuales.

```
#include <stdio.h>
/*
* Revisión de uno de los mejores one-liners del IOCCC.
* Ver International Obfuscated C Code Contest (http://www.ioccc.org)
* ...hallé otras revisiones con errores conceptuales, así que hice la definitiva...
*
* Winners:  http://www.ioccc.org/years.html#1987
* The code: http://www.ioccc.org/1987/korn/korn.c
* Hints:    http://www.ioccc.org/1987/korn/korn.hint
*
* El programa one-liner original (escrito por David Korn, creador del Korn
* Shell) imprime "unix", aunque de una forma incomprensible.
*
*    $ ./korn
*    unix
*
*    $ cat ./korn.c
*    main(){printf(&unix["\021%six\012\0"],(unix)["have"]+"fun"-0x60);}
*
* Rodolfo Alcazar Portillo <rodolfoap@gmail.com>
* Original en http://otbits.blogspot.fr/2009/06/ioccc-best-one-liner.html
*/

main() {
	/* un texto simple */
	printf("%s\n", "unix");

	/* o... */
	printf("%six\n", "un");

	/* añadir un terminador C, innecesario, no cambia la salida */
	printf("%six\n\0", "un");

	/* remplazar \n==\012, lo que es la forma imprimible de un valor octal */
	printf("%six\012\0", "un");

	/* la X adicional X no se imprime por el offset (desplazamiento) +1 */
	printf("X%six\012\0" + 1, "un");

	/* asi como ningún otro caracter */
	printf("\021%six\012\0" + 1, "un");

	/* refraseando la sintaxis como un array de caracteres */
	printf(&"\021%six\012\0"[1], "un");

	/* El procesador de C dice "unix==1". Verificación:
	*
	*   $ cpp -dM /dev/null | grep unix
	*   #define __unix__ 1
	*   #define __unix 1
	*   #define unix 1
	*
	* Por tanto no puede ejecutarse en Windows a no ser que se compile con cygwin o el preprocesador defina:
	* #define unix 1
	*
	* ...y luego, redefinir la variable unix va a devolver un error
	*/
	printf(&"\021%six\012\0"[unix], "un");

	/* &text[n]==&n[text] es adicion básica de punteros, o conmutatividad de la adición */
	printf(&unix["\021%six\012\0"], "un");

	/* 'a'==0x61 o sea que ('a'-0x61)==0 */
	printf(&unix["\021%six\012\0"], "un" + 'a' - 0x61);

	/* Luego, añadir cualquier otro caracter -X- y un offset de 1 (=='a'-0x60) */
	printf(&unix["\021%six\012\0"], "Xun" + 'a' - 0x60);

	/* usar un string entrecomillado, y su offset, lo que da un valor entero: 'a'=="a"[0] */
	printf(&unix["\021%six\012\0"], "Xun" + "a"[0] - 0x60);

	/* o lo mismo, con un texto arbitrario y un offset */
	printf(&unix["\021%six\012\0"], "Xun" + "XaXX"[1] - 0x60);

	/* nuevamente, remplazar 1 con el valor predefinido en el preprocessador unix==1 ...  */
	printf(&unix["\021%six\012\0"], "Xun" + "XaXX"[unix] - 0x60);

	/* reformulando, aritmetica de punteros de arrays, la suma es conmutativa */
	printf(&unix["\021%six\012\0"], "Xun" + (unix)["XaXX"] - 0x60);

	/* idem */
	printf(&unix["\021%six\012\0"], (unix)["XaXX"] + "Xun" - 0x60);

	/* al fin, cambiar los caracteres ignorados a algo significativo */
	/* va a imprimir igualmente "unix" */
	printf(&unix["\021%six\012\0"], (unix)["have"] + "fun" - 0x60);

	return 0;
}
```
