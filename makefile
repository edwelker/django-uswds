.PHONY: clean all check npminstall build upload

# get the version, strip after last -, remove front 'v', convert '-' to 'a'
# v1.0.0-5-g1305532 => 1.0.0a5
VERSION=$$(git describe --always --tags | cut -f1,2 -d'-' | cut -f2 -d'v' | sed -e 's/-/.post/')
VIRTUALENV=virtualenv

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
	npm install && mv node_modules/uswds/dist django_uswds/static/django_uswds/uswds && rm -rf node_modules && rm -rf django_uswds/static/django_uswds/uswds/_scss django_uswds/static/django_uswds/uswds/zip

upload: | clean npminstall
# get the git version number, clean it, pass it as env var to setup.py
	VERSION=$(VERSION) ./venv/bin/python setup.py bdist_wheel -d wheelhouse/
	$(VIRTUALENV) twine-env
	. twine-env/bin/activate
	twine-env/bin/pip install "twine==1.5.0+ncbi.1"
	PYPI_REPOSITORY=https://anonymous:@artifactory.ncbi.nlm.nih.gov/artifactory/api/pypi/python-local-repo twine-env/bin/twine upload wheelhouse/*.whl
