from django.db import models

# Create your models here.

class Under_Quarantine(models.Model):
    NIC = models.CharField(max_length=20)
    Started_Date = models.CharField(max_length=20)
    Contact = models.CharField(max_length=20)
    #more to be inserted

    def __str__(self):
        return self.NIC


class Infect(models.Model):
    NIC = models.CharField(max_length=20)
    Tested_Date = models.CharField(max_length=20)
    Reported_Date = models.CharField(max_length=20)
    Variant = models.CharField(max_length=20)
    #more to be inserted

    def __str__(self):
        return self.NIC


class Recovered(models.Model):
    NIC = models.CharField(max_length=20)
    Tested_Date = models.CharField(max_length=20)
    Reported_Date = models.CharField(max_length=20)
    Variant = models.CharField(max_length=20)
    Recovered_Date = models.CharField(max_length=20)
    #more to be inserted

    def __str__(self):
        return self.NIC


class Death(models.Model):
    NIC = models.CharField(max_length=20)
    Tested_Date = models.CharField(max_length=20)
    Reported_Date = models.CharField(max_length=20)
    Variant = models.CharField(max_length=20)
    Died_Date = models.CharField(max_length=20)
    #more to be inserted

    def __str__(self):
        return self.NIC
        
