# Generated by Django 3.2.6 on 2021-09-01 18:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='registereduser',
            name='nic',
            field=models.CharField(max_length=15),
        ),
        migrations.AlterField(
            model_name='registereduser',
            name='username',
            field=models.CharField(default=models.CharField(max_length=15), max_length=30, primary_key=True, serialize=False),
        ),
    ]
