all:
	mkdir getnewip
	sudo cp -r --no-preserve=ownership DEBIAN etc usr getnewip
	dpkg-deb --build getnewip
	sudo rm -r getnewip

clean:
	sudo rm -r getnewip*

install:
	sudo apt install ./getnewip.deb
