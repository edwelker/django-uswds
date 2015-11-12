'''
Override Django's default templates for the 404, 500, 400, and 403
error pages, so they can point to versions inside this app.
'''

from django.views.defaults import page_not_found as std_page_not_found
from django.views.defaults import server_error as std_server_error
from django.views.defaults import bad_request as std_bad_request
from django.views.defaults import permission_denied as std_permission_denied


def page_not_found(request):
    return std_page_not_found(
        request,
        template_name='django-uswds/404.html')


def server_error(request):
    return std_server_error(request, template_name='django-uswds/500.html')


def bad_request(request):
    return std_bad_request(request, template_name='django-uswds/400.html')


def permission_denied(request):
    return std_permission_denied(
        request,
        template_name='django-uswds/403.html')
