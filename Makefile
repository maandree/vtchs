.POSIX:

CONFIGFILE = config.mk
include $(CONFIGFILE)

all: vtchs

vtchs: vtchs.o
	$(CC) -o $@ vtchs.o $(LDFLAGS)

.c.o:
	$(CC) -c -o $@ $< $(CPPFLAGS) $(CFLAGS)

install: vtchs
	mkdir -p -- "$(DESTDIR)$(PREFIX)/bin"
	mkdir -p -- "$(DESTDIR)$(MANPREFIX)/man1"
	cp -- vtchs "$(DESTDIR)$(PREFIX)/bin/"
	cp -- vtchs.1 "$(DESTDIR)$(MANPREFIX)/man1/"

uninstall:
	-rm -f -- "$(DESTDIR)$(PREFIX)/bin/vtchs"
	-rm -f -- "$(DESTDIR)$(MANPREFIX)/man1/vtchs.1"

clean:
	-rm -f -- vtchs *.o

.SUFFIXES:
.SUFFIXES: .o .c

.PHONY: all install uninstall clean
