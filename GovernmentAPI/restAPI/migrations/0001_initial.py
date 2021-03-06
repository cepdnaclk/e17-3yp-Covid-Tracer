# Generated by Django 3.2.6 on 2021-08-29 14:30

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Death',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('NIC', models.CharField(max_length=20)),
                ('Tested_Date', models.CharField(max_length=20)),
                ('Reported_Date', models.CharField(max_length=20)),
                ('Variant', models.CharField(max_length=20)),
                ('Died_Date', models.CharField(max_length=20)),
            ],
        ),
        migrations.CreateModel(
            name='Infect',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('NIC', models.CharField(max_length=20)),
                ('Tested_Date', models.CharField(max_length=20)),
                ('Reported_Date', models.CharField(max_length=20)),
                ('Variant', models.CharField(max_length=20)),
            ],
        ),
        migrations.CreateModel(
            name='Recovered',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('NIC', models.CharField(max_length=20)),
                ('Tested_Date', models.CharField(max_length=20)),
                ('Reported_Date', models.CharField(max_length=20)),
                ('Variant', models.CharField(max_length=20)),
                ('Recovered_Date', models.CharField(max_length=20)),
            ],
        ),
        migrations.CreateModel(
            name='Under_Quarantine',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('NIC', models.CharField(max_length=20)),
                ('Started_Date', models.CharField(max_length=20)),
                ('Contact', models.CharField(max_length=20)),
            ],
        ),
    ]
