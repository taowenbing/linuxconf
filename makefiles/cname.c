#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getlen(int);		/* get number length */
char *i2a(int, char*s);		/* number to string */
void help(void);

int nflag, eflag, number, width;
char *PROGNAME;
char *newname, *suffix, suffix2[16], number2[16], filename[128];

int
main(int argc, char *argv[])
{
	int d;
	char *p, *q;
	
	number = 1;
	width = 3;
	PROGNAME = argv[0];
	while (argc > 1 && argv[1][0] == '-') {
		switch (argv[1][1]) {
		case 'e':
			eflag = 1;
			if (argv[1][2])
				suffix = &argv[1][2];
			else {
				suffix = argv[2];
				--argc;
				++argv;
			}
			break;
		case 's':
			if (argv[1][2])
				number = atoi(&argv[1][2]);
			else {
				number = atoi(argv[2]);
				--argc;
				++argv;
			}
			break;
		case 'w':
			if (argv[1][2])
				width = atoi(&argv[1][2]);
			else {
				width = atoi(argv[2]);
				--argc;
				++argv;
			}
			break;
		case 'n':
			nflag = 1;
			if (argv[1][2])
				newname = &argv[1][2];
			else {
				newname = argv[2];
				--argc;
				++argv;
			}
			break;
		default:
			help();
		}
		--argc;
		++argv;
	}
	if (argc < 2 || (!nflag && !eflag))
		help();

	if (eflag)
		strcpy(suffix2, suffix);
	else if ((p = strrchr(argv[1], '.')) != NULL)
		strcpy(suffix2, p);
	
	if (!nflag) {				/* nflag == 0, eflag == 1 */
		for (; --argc; ++argv) {
			strcpy(filename, argv[1]);
			if ((p = strrchr(filename, '.')) != NULL)
				*p = '\0';
			strcat(filename, suffix2);
			if (rename(argv[1], filename) < 0)
				fprintf(stdout, "rename [%s] --> [%s] error!\n", argv[1], filename);
		}
		exit(0);
	}

	strcpy(filename, newname);	/* nflag == 1 */
	q = &filename[strlen(filename)];
	for (; --argc; ++argv) {
		p = number2;
		d = getlen(number);
		if (d < width) {
			d = width - d;
			while (d--)
				*p++ = '0';
		}
		i2a(number, p);
		strcpy(q, number2);
		strcat(q, suffix2);
		if (rename(argv[1], filename) < 0) {
			fprintf(stdout, "rename [%s] --> [%s] error!\n", argv[1], filename);
			continue;
		}
		++number;
	}
	exit(0);
}

int
getlen(int n)		/* n >= 0 */
{
	int i = 0;

	do {
		++i;
		n /= 10;
	} while (n);
	return i;
}

char *
i2a(int n, char *s)
{
	char *p = s + getlen(n);

	*p = '\0';
	do {
		*(--p) = n % 10 + '0';
		n /= 10;
	} while (n);
	return s;
}

void
help(void)
{
	fprintf(stdout,
"usage: %s -e suffix file...\n"
"       %s -n newname [-e suffix] [-s start number] [-w number width] file...\n",
	PROGNAME, PROGNAME);
	exit(1);
}
