from django.conf.urls import url
from restAPI import views

urlpatterns = [
    url(r'^under_quarantine$',views.Under_QuarantineApi),
    url(r'^infect$',views.InfectApi)
]