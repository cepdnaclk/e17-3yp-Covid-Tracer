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
        
        user = auth.authenticate(username=username, password=pswrd)

        if user is not None:
            auth.login(request, user)
            return render(request, 'home.html', {'user': user})

        else:
            messages.error(request, '*Invalid Username/NIC or Password')
            return redirect('login')

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
        pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'
        result = pytesseract.image_to_string((threshed),lang="eng")
        for word in result.split("\n"):
            for lst in word.split(" "):
                print(lst)
                if lst.startswith("19",0,2) or lst.startswith("20",0,2): 
                    print(lst)
                    print(nic)
                    if (lst==nic):  
                        request.session['nic'] = nic
                        return redirect('confirm')
                    else:
                        messages.error(request, "*Couldn't verify your identity")
                        return redirect('register')
                    
    else:
        return render(request, 'register.html')



def confirm(request):

    if request.method=='POST':

        nic = request.session['nic']
        contact_number = request.POST['contact']
        email = request.POST['email']
        username = request.POST['username']
        pswrd = request.POST['password1']

        user = RegisteredUser.objects.create_user(nic=nic, username=username, password=pswrd, email=email, contact_number=contact_number)
        user.save()
        return redirect('login')
    
    else:
        return render(request, 'confirm.html')



def home(request):
    return render(request, 'home.html')

def trace(request):
    return render(request, 'trace.html')

def logout(request):
    return render(request, '/')
