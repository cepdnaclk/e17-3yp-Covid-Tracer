from django.urls import path
from . import views

urlpatterns = [
    path('login', views.login, name='login'),
    path('register', views.register, name='register'),
    path('confirm', views.confirm, name='confirm'),
    path('home', views.home, name='home'),
]