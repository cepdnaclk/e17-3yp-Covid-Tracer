from django.shortcuts import render, redirect
from django.contrib import messages
from accounts.models import RegisteredUser
from django.contrib.auth.models import auth


def login(request):

    if request.method=='POST':
        username = request.POST['username']
        pswrd = request.POST['password']

        user = auth.authenticate(username=username, password=pswrd)

        if user is not None:
            auth.login(request, user)
            return redirect('home')

        else:
            messages.error(request, '*Invalid Username/NIC or Password')
            return redirect('login')

    else:
        return render(request, 'login.html')


def register(request):

    if request.method=='POST':
        user = request.POST['username']
        pswrd = request.POST['password']
    else:
        return render(request, 'register.html')


def home(request):

    return render(request, 'home.html')