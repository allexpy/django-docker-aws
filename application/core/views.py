from django.conf import settings
from django.shortcuts import render


def test(request):
    print(settings.BASE_DIR)
    print(settings.ROOT_DIR)
    print(settings.APPS_DIR)
    return render(request, 'core/test.html', {})
