all: munin-plugins-civicboom.deb

VERSION := $(shell git describe)

munin-plugins-civicboom.deb: control Makefile
	rm -rf fs-mpc
	mkdir -p fs-mpc/DEBIAN/
	cp control fs-mpc/DEBIAN/control
	sed -i s/VERSION/${VERSION}/ fs-mpc/DEBIAN/control
	mkdir -p fs-mpc/usr/share/munin/plugins
	cp civicboom_* fs-mpc/usr/share/munin/plugins
	fakeroot dpkg -b fs-mpc munin-plugins-civicboom_${VERSION}_all.deb
	ln -sf munin-plugins-civicboom_${VERSION}_all.deb munin-plugins-civicboom.deb

clean:
	rm -rf fs-* *.deb
