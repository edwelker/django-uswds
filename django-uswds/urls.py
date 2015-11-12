from django.conf.urls import patterns, url
from . import views

urlpatterns = patterns('',
    url(r'404$', views.page_not_found, name="404"),
    url(r'500$', views.server_error, name="500"),
    url(r'400$', views.bad_request, name="400"),
    url(r'403$', views.permission_denied, name="403"),
)
