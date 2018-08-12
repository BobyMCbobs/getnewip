PREFIX ?= /usr
COMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions

all: help

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(COMPLETIONDIR)
	@mkdir -p $(DESTDIR)/etc/getnewip
	@cp -p getnewip $(DESTDIR)$(PREFIX)/bin
	@cp -p getnewip.completion $(DESTDIR)$(COMPLETIONDIR)/getnewip
	@cp getnewip-blank.conf $(DESTDIR)/etc/getnewip
	@cp getnewip-settings.conf $(DESTDIR)/etc/getnewip
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/getnewip
	@chmod 755 $(DESTDIR)$(COMPLETIONDIR)/getnewip
	@mkdir $(DESTDIR)/etc/getnewip/units
	@if [ -z $(NOSYSTEMD) ]; then \
	mkdir -p $(DESTDIR)/usr/lib/systemd/system; \
	cp getnewip.service $(DESTDIR)/usr/lib/systemd/system; fi;

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/getnewip
	@rm -rf $(DESTDIR)$(COMPLETIONDIR)/getnewip
	@rm -rf $(DESTDIR)/etc/getnewip
	@if [ -z $(NOSYSTEMD) ]; then \
	rm -rf $(DESTDIR)/usr/lib/systemd/system/getnewip.service; fi;

prep-deb:
	@mkdir -p build/getnewip
	@cp -p -r support/debian build/getnewip/debian
	@mkdir build/getnewip/debian/getnewip
	@make DESTDIR=build/getnewip/debian/getnewip install
	@if [ ! -z $(NOSYSTEMD) ]; then \
	rm build/getnewip/debian/postinst; \
	rm build/getnewip/debian/prerm; fi;

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
