from django.urls import path
from . import views

urlpatterns = [
    path('login', views.login, name='login'),
    path('register', views.register, name='register'),
    path('confirm', views.confirm, name='confirm'),
    path('otp', views.otp, name='otp'),
    path('home', views.home, name='home'),
    path('trace', views.trace, name='trace'),
    path('logout', views.logout, name='logout'),

]