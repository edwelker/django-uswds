# NCBI Standard Template

The [United States Web Design Standards releases](https://github.com/18F/web-design-standards/releases), incorporated into a HTML5 base Django template.


## Quick start

1. ``pip install django_uswds`` to install the package.

2.  Install 'ncbibasetempalte' and 'compressor' to settings.INSTALLED_APPS

    ``INSTALLED_APPS += ('django_uswds',
                         'compressor',
                        )``

3. Set your settings.STATIC_ROOT

    May I suggest "<project_directory>/static"?

    Add ``import os
          here = lambda *x: os.path.join(os.path.abspath(os.path.dirname(__file__)), *x)``

    to your settings.py, and you can place the directory relative to settings.py.

    See [the Django documentation on deployment](https://docs.djangoproject.com/en/1.8/howto/static-files/#deployment) for more information.

4. Extend the base template:

    ``{% extends 'django_uswds/base.html' %}``

5. Fill out the following blocks (all are optional):

    pagetitle
    
    extra_head_content
    
    content
    
    extra_foot_content
