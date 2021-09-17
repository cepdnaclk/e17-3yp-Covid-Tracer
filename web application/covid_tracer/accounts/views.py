from django.shortcuts import render, redirect
from django.contrib import messages
from accounts.models import LocalCommunity, RegisteredUser, Profile
from django.contrib.auth.models import auth

import cv2
import pytesseract
import numpy as np
from django.core.files.storage import FileSystemStorage

import random
from django.core.cache import cache


def login(request):

    if request.method=='POST':

        username = request.POST['username']
        pswrd = request.POST['password']
        user = auth.authenticate(username=username, password=pswrd)

        if user is not None:

            #check if phone is verified
            profile = Profile.objects.filter(user=user)
            if not profile.is_verified:
                request.session['profile'] = profile
                contact_number = user.contact_number
                send_otp(contact_number, otp)
                return redirect('otp')

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
        check_nic = RegisteredUser.objects.filter(nic=LocalCommunity.objects.get(nic=nic))
        if check_nic:
            messages.error(request, "*NIC already exists")
            return redirect('register')

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

        nicid = request.session['nic']
        nic = LocalCommunity.objects.get(nic=nicid)
        contact_number = request.POST['contact']
        username = request.POST['username']
        pswrd = request.POST['password1']

        user = RegisteredUser.objects.create_user(nic=nic, username=username, password=pswrd, contact_number=contact_number)
        user.save()

        otp = str(random.randint(100000, 999999))
        profile = Profile(user=user, otp=otp)
        profile.save()
        request.session['profile'] = profile
        send_otp(contact_number, otp)
        return redirect('otp')
    
    else:
        return render(request, 'confirm.html')


def send_otp(mobile, otp):

    if (cache.get(mobile)):
        return False, cache.ttl(mobile)

    try:
        cache.set(mobile, otp, timeout=60)
        return True, 0
    except Exception as e:
        print(e)


def otp(request):

    if request.method == 'POST':
        
        profile = request.session['profile']
        otp = request.POST['otp']
        if otp == profile.otp:
            profile.is_verified = True
            profile.save(['is_verified'])
            return redirect('login')

        else:
            messages.error(request, "*Invalid OTP")
            return redirect('otp')

    else:
        return render(request, 'otp.html')


def trace(request):
    return render(request, 'trace.html')

def logout(request):
    return render(request, '/')
