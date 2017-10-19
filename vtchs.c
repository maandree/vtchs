/* See LICENSE file for copyright and license details. */
#include <linux/vt.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stropts.h>
#include <unistd.h>

#define VT(OP, ARG) vt(OP, ARG, #OP)

static char *argv0;

static void
vt(int op, void *arg, const char *opstr)
{
	if (ioctl(STDIN_FILENO, op, arg) == -1) {
		fprintf(stderr, "%s: ioctl <stdin> %s: %s\n", argv0, opstr, strerror(errno));
		exit(1);
	}
}

int
main(int argc, char *argv[])
{
	struct vt_event e;
	struct vt_stat s;

	argv0 = *argv++, argc--;
	if (argc != (*argv && !strcmp(*argv, "=="))) {
		fprintf(stderr, "usage: %s\n", argv0);
		exit(1);
	}

	VT(VT_GETSTATE, &s);
	printf("%u\n", s.v_active);

	e.event = VT_EVENT_SWITCH;
	for (;;) {
		VT(VT_WAITEVENT, &e);
		printf("%u\n", e.newev);
	}

	return 0;
}
