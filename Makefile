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
	@rm -rf $(DESTDIR)/etc/getnewip

prep-deb:
	@mkdir -p build/getnewip
	@cp -p -r support/debian build/getnewip/debian
	@mkdir build/getnewip/debian/getnewip
	@make DESTDIR=build/getnewip/debian/getnewip install

deb-pkg: prep-deb
	@cd build/getnewip/debian && debuild -b

deb-src: prep-deb
	@cd build/getnewip/debian && debuild -S

build-zip:
	@mkdir -p build/getnewip
	@make DESTDIR=build/getnewip install
	@cd build/getnewip && zip -r ../getnewip.zip .

clean:
	@rm -r build

help:
	@echo "Read 'README.md' for info on building."
