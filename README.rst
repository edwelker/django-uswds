====
NCBI Standard Template
====

NCBI Standard template is the NCBI Standards approved header and footer, incorporated into a HTML5 base Django template.


Quick start
-----------

1. ``pip install ncbi-stdtemplate==3.0.0.b1`` to install the package.

2.  Install 'ncbibasetempalte' and 'compressor' to settings.INSTALLED_APPS

    ``INSTALLED_APPS += ('ncbibasetemplate',
                         'compressor',
                        )``

3. Set your settings.STATIC_ROOT

    May I suggest "project_directory/static"?

    Add ``import os
          here = lambda *x: os.path.join(os.path.abspath(os.path.dirname(__file__)), *x)``

    to your settings.py, and you can place the directory relative to settings.py.

    See https://docs.djangoproject.com/en/1.8/howto/static-files/#deployment for more information.

4. Add your application name and url to settings.py (or settings/base.py)

    ``NCBI_APP_NAME='myapp'
      NCBI_APP_URL='/'``

   Optionally, add links to your advanced search and/or help.

    ``NCBI_ADVANCEDSEARCH_URL='/advanced_search'
      NCBI_HELP_URL='/helpurl'``

5. Add the tempalte context processor tuple to settings
   (this passes the vars in #3 to the template)

    ``TEMPLATE_CONTEXT_PROCESSORS=("ncbibasetemplate.context_processors.ncbi_app",)``

6. Extend the base template:

    ``{% extends 'ncbibasetemplate/index.html' %}``

7. Fill out the following blocks (all are optional):

    pagetitle
    extra_head_content
    content
    extra_foot_content

    Additionally, you can refer to your NCBI_APP_NAME and NCBI_APP_URL variables:

    ``<a href="{{NCBI_APP_URL}}">{{ NCBI_APP_NAME }}</a>``

8. To comply with the page title standards, define your pagetile as:

    ``{% block pagetitle%}Home - {{block.super}}{% endblock %}``

  to match the pattern "PageName - App - NCBI"
