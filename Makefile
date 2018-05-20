all:
	fakeroot -u mkdir getnewip
	fakeroot -u cp -r --no-preserve=ownership DEBIAN etc usr getnewip
	dpkg-deb --build getnewip
	fakeroot -u rm -r getnewip

clean:
	fakeroot -u rm -r getnewip*

install:
	apt install ./getnewip.deb
