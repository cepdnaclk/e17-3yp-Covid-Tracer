from rest_framework import serializers
from restAPI.models import Under_Quarantine, Infect, Recovered, Death

class Under_QuarantineSerializer(serializers.ModelSerializer):
    class Meta:
        model = Under_Quarantine
        fields = ('NIC', 'Started_Date', 'Contact')

class InfectSerializer(serializers.ModelSerializer):
    class Meta:
        model = Infect
        fields = ('NIC', 'Tested_Date', 'Reported_Date', 'Variant')

class RecoveredSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recovered
        fields = ('NIC', 'Tested_Date', 'Reported_Date', 'Variant', 'Recovered_Date')

class DeathSerializer(serializers.ModelSerializer):
    class Meta:
        model = Death
        fields = ('NIC', 'Tested_Date', 'Reported_Date', 'Variant', 'Died_Date')
        