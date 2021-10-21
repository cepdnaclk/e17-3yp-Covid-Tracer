from django.urls import path
from . import views

urlpatterns = [
    path('login', views.login, name='login'),
    path('register', views.register, name='register'),
    path('confirm', views.confirm, name='confirm'),
    path('otp', views.otp, name='otp'),
    path('home', views.home, name='home'),
    path('trace', views.trace, name='trace'),
    path('myaccount', views.myaccount, name='myaccount'),
    path('resetpassword', views.resetpassword, name='resetpassword'),
    path('forgotpassword', views.forgotpassword, name='forgotpassword'),
    path('logout', views.logout, name='logout'),
    path('search', views.search, name='search'),
    path('load', views.load_more, name='load'),


]