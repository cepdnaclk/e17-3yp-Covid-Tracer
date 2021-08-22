from django.shortcuts import render
from .models import Cumulative_Data

def index(request):
    return render(request, "index.html")