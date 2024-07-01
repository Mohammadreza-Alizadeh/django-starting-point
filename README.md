## Manual use

install cookiecutter

```
pip install cookiecutter
```

setup the project

```
cookiecutter https://github.com/Mohammadreza-Alizadeh/django-starting-point.git
```

this will create you a bluprint of an almost deploy-ready project for you alongside of a README file wich shows you how to setup docker containers and setting **.env** file

## Easy setup

I also wrote a simple bash script that helps you to setup this template automatically.

notice that you must have **python** and **docker** installed on your machin.

---

after downloading django-easy-setup.sh you have to give it permission to execute. to do so just use :

```
chmod +x ./django-easy-setup.sh
```

now just simply run the bash file

```
bash ./django-easy-setup.sh
```

or

```
sh .django-easy-setup.sh
```

## worth mentioning

I mostly used [this repo](https://github.com/amirbahador-hub/django_style_guide/) provided by lovely bahador and did some changes to meet my needs. also added automatation bash script by myself which probably is not very neat and reusable ( I am still new to bash :) )
