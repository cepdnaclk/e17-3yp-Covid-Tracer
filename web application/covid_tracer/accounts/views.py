from django.shortcuts import render, redirect
from django.contrib import messages
from accounts.models import LocalCommunity, RegisteredUser, Profile
from django.contrib.auth.models import User, auth

import cv2
import pytesseract
import numpy as np
from django.core.files.storage import FileSystemStorage

import random
from django.core.cache import cache
import json


def login(request):

    if request.method=='POST':
        """
        status, secs = throttle(request)
        if status:
            messages.error(request, 'Maximum Rate Exceeded. Wait for '+str(secs)+'s')
            return redirect('login')
        """
        username = request.POST['username']
        pswrd = request.POST['password']
        user = auth.authenticate(username=username, password=pswrd)

        if user is not None:

            auth.login(request, user)
            
            #check if phone is verified
            profile = Profile.objects.get(user=user)
            if not profile.is_verified:
                return redirect('otp')
            
            else:               
                return render(request, 'home.html', {'user': user})

        else:
            messages.error(request, 'Invalid Username/NIC or Password')
            return redirect('login')

    else:
        return render(request, 'login.html')
    
    

def register(request):

    if request.method=='POST':

        status, secs = throttle(request)
        if status:
            messages.error(request, 'Maximum Rate Exceeded. Wait for '+str(secs)+'s')
            return redirect('register')

        else:

            nic = request.POST['nic']
            try:
                nic2 = LocalCommunity.objects.get(nic=nic)
            except:
                lc = LocalCommunity(nic=nic)
                lc.save()

            try:
                RegisteredUser.objects.get(nic=LocalCommunity.objects.get(nic=nic2))
                messages.error(request, "User already exists")
                return redirect('register')
            except:
                pass
                

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

        try:
            user = RegisteredUser.objects.create_user(nic=nic, username=username, password=pswrd, contact_number=contact_number)
            user.save()
        except:
            messages.error(request, "Username Exists")
            return redirect('confirm')

        profile = Profile(user=user, otp=otp)
        profile.save()
        auth.login(request, user)
        return redirect('otp')
            
    else:
        return render(request, 'confirm.html')


def send_otp(user):

    profile = Profile.objects.get(user=user)
    mobile = user.contact_number

    if cache.get(mobile):
        total_calls = cache.get(mobile)
        if total_calls>2:
            return False, cache.ttl(mobile)
        else:
            otp = str(random.randint(100000, 999999))
            profile.otp = otp
            profile.save()
            cache.set(mobile, total_calls+1)
            return True, 0

    otp = str(random.randint(100000, 999999))
    profile.otp = otp
    profile.save()
    cache.set(mobile, 1, timeout=60)
    return True, 0

"""
    if (cache.get(mobile)):
        return False, cache.ttl(mobile)
    
    otp = str(random.randint(100000, 999999))
    profile.otp = otp
    profile.save()

    try:
        cache.set(mobile, otp, timeout=60)
        return True, 0
    except Exception as e:
        print(e)
"""


def otp(request):
    
    if request.method == 'POST':

        status, secs = throttle(request)
        if status:
            messages.error(request, 'Maximum Rate Exceeded. Wait for '+str(secs)+'s')
            return redirect('otp')
        
        user = request.user
        profile = Profile.objects.get(user=user)
        otp = request.POST['otp']
        if otp == profile.otp:
            profile.is_verified = True
            profile.save()
            return render(request, 'home.html', {'user': user})

        else:
            messages.error(request, "Invalid OTP")
            return redirect('otp')

    else:
        user = request.user
        status, secs = send_otp(user)
        if not status:
            messages.error(request, 'Try again in '+str(secs)+'s')
        
        messages.success(request, 'OTP sent successfully')
        return render(request, 'otp.html')


def throttle(request):

    forwarded = request.META.get('HTTP_X_FORWARDED_FOR')
    if forwarded:
        ip = forwarded.split(',')[-1].strip()
    else:
        ip = request.META.get('REMOTE_ADDR')

    if cache.get(ip):
        total_calls = cache.get(ip)
        if total_calls>5:
            return True, cache.ttl(ip)
        else:
            cache.set(ip, total_calls+1)
            return False, 0
    
    cache.set(ip, 1, timeout=60)
    return False, 0


def home(request) :
    return render(request, 'home.html')


def trace(request):
    return render(request, 'trace.html')

def logout(request):
    auth.logout(request)
    return redirect('login')
