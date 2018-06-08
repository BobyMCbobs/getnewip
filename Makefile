PREFIX ?= /usr
COMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions

all: help

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(COMPLETIONDIR)
	@cp -p getnewip $(DESTDIR)$(PREFIX)/bin
	@cp -p getnewip.completion $(DESTDIR)$(COMPLETIONDIR)/getnewip
	@cp -r -p etc $(DESTDIR)/etc
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/getnewip
	@chmod 755 $(DESTDIR)$(COMPLETIONDIR)/getnewip

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/getnewip
	@rm -rf $(DESTDIR)$(COMPLETIONDIR)/getnewip

deb:
	@mkdir build
	@make DESTDIR=build install
	@fakeroot -u cp -p -r support/debian build/DEBIAN
	@fakeroot -u chown -R root:root build
	@dpkg-deb --build build
	@mv build.deb getnewip.deb

clean:	
	@fakeroot -u rm -r build getnewip.deb

help:
	@echo "Read 'README.md' for info on building."
