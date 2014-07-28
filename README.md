redmine-ws
==========

Redmine WS expone un ws rest para devolver los proyectos de N instancias redmine que se configuran en config/redmine-ws.yml donde **name** va a ser parte de la url de la siguiente forma:

```
http://HOST:PORT/NAME/projects
```


Prerequisites
=============

```sh
$ sudo apt-get install ruby1.9.1 ruby1.9.1-dev -y

$ gem install sinatra
$ gem install thin
$ gem install wrest
```

Ejecución
=========

```sh
$ ruby projects.rb
```

Port 8080 aún todavía no configurable.


