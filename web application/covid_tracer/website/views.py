from django.shortcuts import render
from .models import Statistic

def index(request):

    stats = Statistic.objects.order_by('update_timestamp')
    stat = stats.reverse()[0]
    prev = stats.reverse()[1]

    #print(request.META['HTTP_USER_AGENT'])
   
    return render(request, "index.html", {'stat': stat, 'stats': stats})
