# mezzanine
Tampere Hacklab's Mezzanine CMS (aka web pages)

### Getting started with local environment

Clone the repo and initialize virtualenv
```
git clone https://github.com/TampereHacklab/mezzanine.git
cd mezzanine/trehacklab
virtualenv -p python3 virtualenv
source virtualenv/bin/activate
pip install -r requirements.txt
```

Copy basic settings to `trehacklab/trehacklab/local_settings.py`

```
DEBUG = True
SECRET_KEY = "asdfasdfsecretasdfasdf"
ALLOWED_HOSTS = ['127.0.0.1']

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": "dev.db",
    }
}
```

Populate db and start the server
```
python manage.py createdb
python manage.py runserver
```
Development server should start at http://127.0.0.1:8000/