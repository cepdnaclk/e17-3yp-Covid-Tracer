from django.contrib import admin
from .models import RegisteredUser, LocalCommunity, Profile

# Register your models here.
admin.site.register(RegisteredUser)
admin.site.register(LocalCommunity)
admin.site.register(Profile)