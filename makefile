.PHONY: clean all check npminstall build upload

# get the version, strip after last -, remove front 'v', convert '-' to 'a'
# v1.0.0-5-g1305532 => 1.0.0a5
VERSION=$$(git describe --always --tags | cut -f1,2 -d'-' | cut -f2 -d'v' | sed -e 's/-/.post/')

all: | clean npminstall build

clean:
	\rm -rf dist django_uswds.egg-info build
	\rm -rf django_uswds/static/django_uswds/uswds

check:
	check-manifest

build:
	python setup.py bdist_wheel

npminstall:
	test -d django_uswds/static/django_uswds || mkdir -p django_uswds/static/django_uswds
	npm install && mv node_modules/us-web-design-standards/dist django_uswds/static/django_uswds/uswds && rm -rf node_modules && rm -rf django_uswds/static/django_uswds/uswds/_scss django_uswds/static/django_uswds/uswds/zip

upload: | clean npminstall
	VERSION=$(VERSION) python setup.py bdist_wheel upload -r python-local-repo
