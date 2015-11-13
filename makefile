.PHONY: clean all check npminstall build upload

all: | clean npminstall build

clean:
	\rm -rf dist django_uswds.egg-info build
	\rm -rf django-uswds/static/django-uswds/uswds

check:
	check-manifest

build:
	python setup.py bdist_wheel

npminstall:
	npm install && mv node_modules/us-web-design-standards/dist django-uswds/static/django-uswds/uswds && rm -rf node_modules && rm -rf django-uswds/static/django-uswds/uswds/_scss django-uswds/static/django-uswds/uswds/zip

upload: | clean npminstall
	\python setup.py bdist_wheel upload -r python-local-repo
