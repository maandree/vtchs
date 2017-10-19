.POSIX:

CONFIGFILE = config.mk
include $(CONFIGFILE)

all: vtchs

.o:
	$(CC) -o $@ $^ $(LDFLAGS)

.c.o:
	$(CC) -c -o $@ $< $(CPPFLAGS) $(CFLAGS)

install: vtchs
	mkdir -p -- "$(DESTDIR)$(PREFIX)/bin"
	mkdir -p -- "$(DESTDIR)$(MANPREFIX)/man1"
	mkdir -p -- "$(DESTDIR)$(PREFIX)/share/licenses/vtchs"
	cp vtchs -- "$(DESTDIR)$(PREFIX)/bin/"
	cp vtchs.1 -- "$(DESTDIR)$(MANPREFIX)/man1/"
	cp LICENSE -- "$(DESTDIR)$(PREFIX)/share/licenses/vtchs/"

uninstall:
	-rm -f -- "$(DESTDIR)$(PREFIX)/bin/vtchs"
	-rm -f -- "$(DESTDIR)$(MANPREFIX)/man1/vtchs.1"
	-rm -rf -- "$(DESTDIR)$(PREFIX)/share/licenses/vtchs"

clean:
	-rm -f - vtchs *o

.SUFFIXES: .o .c.o

.PHONY: all install uninstall clean
