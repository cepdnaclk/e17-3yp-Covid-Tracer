from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser
from django.http.response import JsonResponse

from accounts.models import LocalCommunity, RegisteredUser, Profile, TraceLocation
from accounts.serializers import LocalCommunitySerializer, CustomAccountManagerSerializer, RegisteredUserSerializer, ProfileSerializer, TraceLocationSerializer

"""
@csrf_exempt
def Under_QuarantineApi(request):

    if request.method=='GET':
        under_quarantine = Under_Quarantine.objects.all()
        under_quarantine_serializer = Under_QuarantineSerializer(under_quarantine,many=True)
        return JsonResponse(under_quarantine_serializer.data,safe=False)
"""

@csrf_exempt
def login(request):
    if request.method=='POST':
        #status, secs = throttle(request)
        username = request.POST['username']
        pswrd = request.POST['password']
        return render(request)

@csrf_exempt
def register(request):
    if request.method=='POST':
        
        status, secs = throttle(request)

@csrf_exempt
def confirm(request):
    if request.method=='POST':
        
        status, secs = throttle(request)

@csrf_exempt
def send_otp(user):
    if request.method=='POST':
        
        status, secs = throttle(request)

@csrf_exempt
def otp(request):
    if request.method=='POST':
        
        status, secs = throttle(request)
"""
@csrf_exempt
def throttle(request):
    if request.method=='POST':
        
        status, secs = throttle(request)
"""
@csrf_exempt
def home(request):
    if request.method=='POST':
        
        status, secs = throttle(request)

@csrf_exempt
def trace(request):
    if request.method=='POST':
        
        status, secs = throttle(request)

@csrf_exempt
def logout(request):
    if request.method=='POST':
        
        status, secs = throttle(request)

@csrf_exempt
def calc(request):
    if request.method=='POST':
        
        status, secs = throttle(request)