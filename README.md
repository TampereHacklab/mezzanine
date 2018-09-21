# mezzanine
Tampere Hacklab's Mezzanine CMS (aka web pages)

## Docker ##

```
git clone https://github.com/TampereHacklab/mezzanine.git
cd mezzanine
(Copy settings template to `trehacklab/trehacklab/local_settings.py`, described below)
docker image build -t mezzanine:latest .
docker run -d -p 8000:8000 --name mezzanine mezzanine:latest
```

### To run in your dev environment (empty database) ###

```
docker exec -it mezzanine bash -c "source virtualenv/bin/activate && cd trehacklab && python3 manage.py createdb && python3 manage.py runserver 0.0.0.0:8000"
```

### To run in existing environment (hacklab's database) ###

TODO

### Getting started with local environment

Clone the repo and initialize virtualenv
```
git clone https://github.com/TampereHacklab/mezzanine.git
cd mezzanine/trehacklab
virtualenv -p python3 virtualenv
source virtualenv/bin/activate
pip3 install -r requirements.txt
```

Copy settings template to `trehacklab/trehacklab/local_settings.py`:

```
DEBUG = True
SECRET_KEY = "asdfasdfsecretasdfasdf"
ALLOWED_HOSTS = ['*']

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": "dev.db",
    }
}
```

Populate db and start the server
```
python3 manage.py createdb
python3 manage.py runserver
```
Development server should start at http://127.0.0.1:8000/

### Modifying templates

Collect the html templates:

```
python3 manage.py collecttemplates
```

This will create templates directory, which contains the editable
default templates. You can modify them to affect the page
layouts. Only modified templates should be included in git.
If a template is missing, the default one from Mezzanine is
used.


### Style sheets

File trehacklab/static/css/trehacklab.css contains our customizations
to the default css file. It's included last so it overrides any other
templates. Put your customizations there.

