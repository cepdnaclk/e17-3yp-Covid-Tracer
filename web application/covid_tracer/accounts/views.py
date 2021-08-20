from django.shortcuts import render, redirect
from django.contrib import messages


def login(request):

    if request.method=='POST':
        user = request.POST['username']
        pswrd = request.POST['password']
    else:
        return render(request, 'login.html')

def register(request):

    if request.method=='POST':
        user = request.POST['username']
        pswrd = request.POST['password']
    else:
        return render(request, 'register.html')