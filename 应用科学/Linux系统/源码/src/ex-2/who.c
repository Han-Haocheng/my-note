/**
 * Created by hanhaocheng on 2025/8/31.
 */

#include <errno.h>
#include <unistd.h>
#include <kernel.h>
#include <asm/segment.h>
#include <string.h>

#define SYS_NAME_MAX 23

char SYS_NAME_STR[SYS_NAME_MAX];

int sys_iam(const char *name) {
	printk("iam begin");
	/*if (name == NULL) {
		errno = EINVAL;
		return -1;
	}

	int i = 0, j = 0;
	while (i < SYS_NAME_MAX) {
		if (name[i] == '\0') break;
		++i;
	}

	if (i == SYS_NAME_MAX && name[i] != '\0') {
		errno = EINVAL;
		return -1;
	}

	while (j <= i) {
		SYS_NAME_STR[j] = get_fs_byte(name + j);
		++j;
	}*/
	printk("iam end");
	return 0;
}

int sys_whoami(char *name, unsigned int size) {
	printk("iam begin");
	return 0;

	if (name == NULL) {
		errno = EINVAL;
		return -1;
	}
	int i = 0, j = 0;

	while (i < SYS_NAME_MAX) {
		if (SYS_NAME_STR[i] == '\0') break;
		++i;
	}
	if (i > size) {
		errno = EINVAL;
		return -1;
	}

	while (j <= i) {
		name[j] = get_fs_byte(SYS_NAME_STR + j);
		++j;
	}
	return i;
}