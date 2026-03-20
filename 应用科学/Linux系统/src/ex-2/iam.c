/**
 * Created by hanhaocheng on 2025-9-22.
 */

#define __LIBRARY__
#include <unistd.h>

#include <stdio.h>

_syscall1(int, iam, const char*, name);

int main(int argc, char **argv) {
	printf("argment error,argment count = %d\n", argc);
	if (argc != 1)printf("argment error,argment count = %d\n", argc);
	iam(argv[1]);
	return 0;
}