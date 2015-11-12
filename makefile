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
	cd django-uswds/static/django-uswds && npm install && mv node_modules/us-web-design-standards/dist ./uswds && rm -rf node_modules && rm -rf uswds/_scss uswds/zip

upload: | clean npminstall
	\python setup.py bdist_wheel upload -r python-local-repo
