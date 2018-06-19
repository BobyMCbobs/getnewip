PREFIX ?= /usr
COMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions

all: help

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(COMPLETIONDIR)
	@cp -p getnewip $(DESTDIR)$(PREFIX)/bin
	@cp -p getnewip.completion $(DESTDIR)$(COMPLETIONDIR)/getnewip
	@cp -r -p etc/. $(DESTDIR)/etc
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/getnewip
	@chmod 755 $(DESTDIR)$(COMPLETIONDIR)/getnewip
	@mkdir $(DESTDIR)/etc/getnewip/units

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/getnewip
	@rm -rf $(DESTDIR)$(COMPLETIONDIR)/getnewip
	@rm -rf $(DESTDIR)/etc/systemd/system/getnewip.service

deb:
	@mkdir build
	@make DESTDIR=build install
	@cp -p -r support/debian build/DEBIAN
	@sudo chown -R root:root build
	@dpkg-deb --build build
	@sudo chown -R $$(whoami):$$(whoami) build
	@mv build.deb getnewip.deb

clean:
	@rm -r build getnewip.deb

help:
	@echo "Read 'README.md' for info on building."
