INSTALLDIR ?= /tmp/debapp

all: install

clean:
	-rm -fr heroku-buildpack-go heroku-buildpack-nodejs heroku-buildpack-python

heroku-buildpack-go:
	git clone --depth=1 git@github.com:heroku/heroku-buildpack-go.git
	sed -i 's/ln -/#ln -/' heroku-buildpack-go/bin/compile

heroku-buildpack-nodejs:
	git clone --depth=1 git@github.com:heroku/heroku-buildpack-nodejs.git

heroku-buildpack-python:
	git clone --depth=1 git@github.com:heroku/heroku-buildpack-python.git

install: heroku-buildpack-go heroku-buildpack-nodejs
	install -d ${INSTALLDIR}
	mv heroku-buildpack-* ${INSTALLDIR}/
	install *.sh ${INSTALLDIR}

