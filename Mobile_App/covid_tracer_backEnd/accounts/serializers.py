from rest_framework import serializers
from accounts.models import LocalCommunity, CustomAccountManager, RegisteredUser, Profile, TraceLocation


class LocalCommunitySerializer(serializers.ModelSerializer):
    class Meta:
        model = LocalCommunity
        fields = ('nic', 'full_name', 'sex', 'address')

class CustomAccountManagerSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomAccountManager
        fields = ()

class RegisteredUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = RegisteredUser
        fields = ('nic', 'username', 'contact_number', 'joined_date')

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ('user', 'otp', 'is_verified')

class TraceLocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = TraceLocation
        fields = ('location', 'percentage')




