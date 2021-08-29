from django.shortcuts import render, redirect
from django.contrib import messages
from accounts.models import RegisteredUser
from django.contrib.auth.models import auth

import cv2
import pytesseract
import numpy as np
from django.core.files.storage import FileSystemStorage

def login(request):

    if request.method=='POST':
        username = request.POST['username']
        pswrd = request.POST['password']
        return redirect('home')
        
        #user = auth.authenticate(username=username, password=pswrd)

        #if user is not None:
        #    auth.login(request, user)
        #    return redirect('home', {'user': user})

        #else:
        #    messages.error(request, '*Invalid Username/NIC or Password')
        #    return redirect('login')

    else:
        return render(request, 'login.html')
    

def register(request):

    if request.method=='POST':
        nic = request.POST['nic']
        img_nic = request.FILES['nicimg']
        filestr = img_nic.read()
        npimg = np.fromstring(filestr, np.uint8)
        img = cv2.imdecode(npimg, cv2.IMREAD_UNCHANGED)

        fs = FileSystemStorage()
        name = fs.save(str(img_nic), img_nic)
        url = fs.url(name)

        #img = cv2.imread("nic.jpg")
        gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
        gray = cv2.medianBlur(gray,5)
        th, threshed = cv2.threshold(img,127,255,cv2.THRESH_TRUNC)
        result = pytesseract.image_to_string((threshed),lang="eng")
        for word in result.split("\n"):
            for lst in word.split(" "):
                if lst.startswith("19",0,2) or lst.startswith("20",0,2): 
                    if (lst==nic):
                        request.session['nic'] = nic
                        return redirect('confirm')
                    else:
                        messages.error(request, "*Couldn't verify your identity")
                        return redirect('register')

    else:
        return render(request, 'register.html')


def home(request):

    return render(request, 'home.html')


def confirm(request):

    if request.method=='POST':

        nic = request.session.get['nic']
        contact_number = request.POST('contact')
        email = request.POST('email')
        username = request.POST('username')
        pswrd = request.POST('password1')

        user = RegisteredUser.objects.create_user(nic=nic, username=username, password=pswrd, email=email, contact_number=contact_number)
        user.save()
        return redirect('login')
    
    else:
        return render(request, 'confirm.html')

