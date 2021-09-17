from django.db import models
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin, BaseUserManager
from django.core.validators import RegexValidator


class LocalCommunity(models.Model):
    nic = models.CharField(primary_key=True, max_length=12)
    full_name = models.CharField(max_length=100, blank=True, null=True)
    sex = models.CharField(max_length=1, blank=True, null=True)
    address = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'LocalCommunity'


class CustomAccountManager(BaseUserManager):

    def create_user(self, nic, username, password, contact_number, **other_fields):

        if not nic:
            raise ValueError('NIC is a required field')
        if not contact_number:
            raise ValueError('Provide your contact number')

        user = self.model(nic=nic, username=username, contact_number=contact_number, **other_fields)
        user.set_password(password)
        user.save()
        return user

    def create_superuser(self, nic, username, password, contact_number, **other_fields):

        other_fields.setdefault('is_superuser', True)
        return self.create_user(nic, username, password, contact_number, **other_fields)


class RegisteredUser(AbstractBaseUser, PermissionsMixin):

    nic = models.OneToOneField(LocalCommunity, on_delete=models.CASCADE)
    username = models.CharField(primary_key=True, max_length=30, default=nic)
    #password is by default there
    #email = models.EmailField(max_length=50, null=True, blank=True)
    contact_number = models.CharField(max_length=9, null=True, blank=True)
    joined_date = models.DateTimeField(auto_now_add=True)

    objects = CustomAccountManager()

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['nic', 'contact_number']
    

    def __str__(self) -> str:
        return self.username



class Profile(models.Model):

    user = models.OneToOneField(RegisteredUser, on_delete=models.CASCADE)
    otp = models.CharField(max_length=6, null=True, blank=True)
    is_verified = models.BooleanField(default=False)