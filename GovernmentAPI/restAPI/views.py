from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser
from django.http.response import JsonResponse

from restAPI.models import Under_Quarantine, Infect, Recovered, Death
from restAPI.serializers import Under_QuarantineSerializer, InfectSerializer, RecoveredSerializer, DeathSerializer


# Create your views here.

@csrf_exempt
def Under_QuarantineApi(request):

    if request.method=='GET':
        under_quarantine = Under_Quarantine.objects.all()
        under_quarantine_serializer = Under_QuarantineSerializer(under_quarantine,many=True)
        return JsonResponse(under_quarantine_serializer.data,safe=False)

@csrf_exempt
def InfectApi(request):

    if request.method=='GET':
        infect = Infect.objects.all()
        infect_serializer = InfectSerializer(infect,many=True)
        return JsonResponse(infect_serializer.data,safe=False)

