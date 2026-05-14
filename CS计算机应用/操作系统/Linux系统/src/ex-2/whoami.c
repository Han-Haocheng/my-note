/**
* Created by hanhaocheng on 2025-9-22.
 */

#define __LIBRARY__
#include <unistd.h>

#include <stdio.h>

_syscall2(int, whoami, char*, name, unsigned int, size);

int main(int argc, char **argv) {
	const int name_size = 23;
	char name[23] = "test";
	whoami(name, name_size);
	printf("%s\n", name);
	return 0;
}