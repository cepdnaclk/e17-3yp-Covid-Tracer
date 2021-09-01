from django.contrib import admin
from .models import Under_Quarantine, Infect, Recovered, Death

# Register your models here.

admin.site.register(Under_Quarantine)
admin.site.register(Infect)
admin.site.register(Recovered)
admin.site.register(Death)
