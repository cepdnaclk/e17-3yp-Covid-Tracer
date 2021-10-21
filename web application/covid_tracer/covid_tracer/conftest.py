from django.apps import apps

@pytest.fixture(autouse=True, scope='session')

def __make_unmanaged_managed():
  
    unmanaged_models = [m for m in apps.get_models() if not m._meta.managed]
    for m in unmanaged_models:
        m._meta.managed = True