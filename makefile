.PHONY: clean all check npminstall build upload

# get the version, strip after last -, remove front 'v', convert '-' to 'a'
# v1.0.0-5-g1305532 => 1.0.0a5
# VERSION=$$(git describe --always --tags | cut -f1,2 -d'-' | cut -f2 -d'v' | sed -e 's/-/.post/')
VIRTUALENV=virtualenv
PYTHON=$$(which python2)
PROJECT=django-uswds
# USWDS=0.13.3

all: | clean npminstall build

clean:
	\rm -rf dist django_uswds.egg-info build
	\rm -rf django_uswds/static/django_uswds/uswds
	git clean -d -x -f -e .tox

check:
	check-manifest

build:
	python setup.py bdist_wheel

npminstall:
	test -d django_uswds/static/django_uswds || mkdir -p django_uswds/static/django_uswds
	npm install && mv node_modules/uswds/dist django_uswds/static/django_uswds/uswds && rm -rf node_modules && rm -rf django_uswds/static/django_uswds/uswds/_scss django_uswds/static/django_uswds/uswds/zip

upload: | venv githubinstall
# get the git version number, clean it, pass it as env var to setup.py
	VERSION=$(VERSION) ./venv/bin/python setup.py bdist_wheel -d wheelhouse/
	$(VIRTUALENV) twine-env
	. twine-env/bin/activate
	twine-env/bin/pip install "twine==1.5.0+ncbi.1"
	PYPI_REPOSITORY=https://anonymous:@artifactory.ncbi.nlm.nih.gov/artifactory/api/pypi/python-local-repo twine-env/bin/twine upload wheelhouse/*.whl
	curl -X POST -H 'Content-type: application/json' --data "{\"text\": \"Version $(VERSION) of $(PROJECT) has been released to <https://artifactory.ncbi.nlm.nih.gov/artifactory/webapp/#/artifacts/browse/tree/General/python-local-repo/$(PROJECT)/$(VERSION)|artifactory>.\", \"channel\": \"@eddie\", \"username\": \"teamcity\", \"icon_emoji\": \":pumpkin:\"}" https://hooks.slack.com/services/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

githubinstall:
	rm -rf django_uswds/static/django_uswds uswds-*.zip
	mkdir -p django_uswds/static/django_uswds
	wget https://github.com/18F/web-design-standards/releases/download/v$(VERSION)/uswds-$(VERSION).zip && unzip uswds-$(VERSION).zip && mv uswds-$(VERSION) django_uswds/static/django_uswds/uswds

venv:
	test -d venv || $(VIRTUALENV) venv -p $(PYTHON) # Can't do source, no subshells
	./venv/bin/pip install -U wheel pip pathlib # For 3.5

getversions: | clean venv
	./venv/bin/pip install feedparser gitpython
	./venv/bin/python update.py

createversions: | getversions
	while read P; do VERSION=$$P make upload && git tag -a $$P -m "$$P"; done<versions.txt
