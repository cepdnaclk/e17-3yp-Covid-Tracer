from django.contrib import admin
from .models import RegisteredUser, LocalCommunity

# Register your models here.
admin.site.register(RegisteredUser)
admin.site.register(LocalCommunity)