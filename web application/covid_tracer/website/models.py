from django.db import models


class Statistic(models.Model):
    new_deaths = models.IntegerField()
    new_cases = models.IntegerField()
    cumulative_deaths = models.IntegerField()
    cumulative_cases = models.IntegerField()
    update_timestamp = models.DateTimeField(primary_key=True)

    class Meta:
        managed = False
        db_table = 'GovernmentUpdates'