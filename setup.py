import os
from setuptools import setup
from pathlib import Path

path = Path()

with (path / "README.md").open() as readme:
    README = readme.read()



setup(
    name='django-uswds',
    version=os.environ.get('VERSION', ''),
    packages=['django_uswds'],
    install_requires=['django_compressor>=1.4'],
    include_package_data=True,
    license='Public Domain',
    description='Django application incorporating the U.S. web-design-standards \
        package and HTML5 base page templates.',
    long_description=README,
    url='http://www.ncbi.nlm.nih.gov/',
    author='Edward Welker',
    author_email='welkere@ncbi.nlm.nih.gov',
    classifiers=[
        'Environment :: Web Environment',
        'Framework :: Django',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: Public Domain',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Topic :: Internet :: WWW/HTTP',
        'Topic :: Internet :: WWW/HTTP :: Dynamic Content',
    ],
    keywords='python django NCBI web standards web-design-standards US us-web-design-standards 18f'
)
