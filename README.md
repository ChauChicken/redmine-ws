redmine-ws
==========

{{toc}}

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

Copie y configuré ws/config/redmine-ws.yml basandose en redmine-ws.yml.example.

Ejemplo:

```yml
-
  name: 'alias-instancia-redmine1'
  protocol: 'protocol-instancia-redmine1'
  host: 'host-instancia-redmine1'
  port: port-instancia-redmine1
  service: '/path/to/service1'
  key: 'keyredmine1'
  sarhaCode: 'codigo-sarha-redmine1'
-
  name: 'alias-instancia-redmine2'
  protocol: 'protocol-instancia-redmine2'
  host: 'host-instancia-redmine2'
  port: port-instancia-redmine2
  service: '/path/to/service2'
  key: 'keyredmine2'
  sarhaCode: 'codigo-sarha-redmine2'
...
...
...
-
  name: 'alias-instancia-redmineN'
  protocol: 'protocol-instancia-redmineN'
  host: 'host-instancia-redmineN'
  port: port-instancia-redmineN
  service: '/path/to/serviceN'
  key: 'keyredmineN'
  sarhaCode: 'codigo-sarha-redmineN'
```

**IMPORTANTE:** name es obligatorio. Los demás parametros tienen los siguientes defaults (OJO - Solo en configuración a nivel docker. De otra forma debe configurarlos):

```
REDMINE_PROTOCOL_DEFAULT="http"
REDMINE_HOST_DEFAULT="localhost"
REDMINE_PORT_DEFAULT=80
REDMINE_SERVICE_DEFAULT="/projects.xml"
REDMINE_KEY_DEFAULT="7f12daf3ec712263b74db4a3788bc8ae6b58ef33"
REDMINE_SARHACODE_DEFAULT="A0FHE00000"
```


```sh
$ cd ws
$ ruby projects.rb
```

Port 8080.


Docker
======

## Descarga de la imagen

```sh
$ docker pull docker-registry.afip.gob.ar/dearin/redmine-ws:1.0.0
```

## Construcción de la imagen
```sh
$ docker build --tag 'docker-registry.afip.gob.ar/dearin/redmine-ws:1.0.1' .
$ docker push docker-registry.afip.gob.ar/dearin/redmine-ws
```

## Ejecución de la images

### Parámetros

El ws está diseñado para escuchar N instancias de redmine con lo cual necesita como parámetro **obligatorio** el alias(name) de la/s instancia/s de redmine a ser consultadas.

#### Parámetros soportados

**REDMINE_NAMEN**=Alias de la instancia de redmine
**REDMINE_PROTOCOLN**=Protocolo a ser utilizado para la api rest de esa instancia de redmine. Default: "http"
**REDMINE_HOSTN**=Host de esa instancia de redmine. Default: "localhost"
**REDMINE_PORTN**=Puerto que escucha esa instancia de redmine. Default: 80
**REDMINE_SERVICEN**=Path del servicio a ejecutar en esa instancia de redmine (por ahora simplimente soporta projects.xml). Default: "/projects.xml"
**REDMINE_KEYN**=Clave de la API Rest de esa instancia de redmine. Default: "7897564561231244897efa"
**REDMINE_SARHACODEN**=Código shara de esa instancia de redmine. Default: "A0FHE00000"

Donde N corresponde a un número ficticio de orden de la instancia de redmine a configurar. Ej: 1, 2, 3, ..., 5342, etc.

### Lanzando la imagen

```sh
$ docker run -d \
             -p 8080:8080 \
             -e "REDMINE_NAME1=redmine-dearin" \
             -e "REDMINE_PROTOCOL1=https" \
             -e "REDMINE_HOST1=redmine.afip.gob.ar" \
             -e "REDMINE_PORT1=443" \
             -e "REDMINE_SERVICE1=/projects.xml" \
             -e "REDMINE_SHARACODE1=A0FHE00000" \
             -e "REDMINE_KEY1=7f12daf3ec712263b74db4a3788bc8ae6b58ef32" \
             -e "REDMINE_NAME2=redmine-dit" \
             -e "REDMINE_PROTOCOL2=https" \
             -e "REDMINE_HOST2=redminedit.afip.gob.ar" \
             -e "REDMINE_PORT2=443" \
             -e "REDMINE_SERVICE2=/projects.xml" \
             -e "REDMINE_SHARACODE2=A0FHG00000" \
             -e "REDMINE_KEY2=8f12daf3ec712263b74db4a3788bc8ae6b58ef32" \
             --name redmine-ws docker-registry.afip.gob.ar/dearin/redmine-ws:1.0.0
```

#### Lanzando la imagen con link a otro/s container/s de redmine

```sh
$ docker run -d \
             -p 8000:8080 \
             --link redmine:redmine-dearin \
             --link redmine-dit:redmine-dit \
             -e "REDMINE_NAME1=redmine-dearin" \
             -e "REDMINE_PROTOCOL1=http" \
             -e "REDMINE_HOST1=redmine-dearin" \
             -e "REDMINE_PORT1=80" \
             -e "REDMINE_SERVICE1=/projects.xml" \
             -e "REDMINE_SHARACODE1=A0FHE00000" \
             -e "REDMINE_KEY1=7f12daf3ec712263b74db4a3788bc8ae6b58ef32" \
             -e "REDMINE_NAME2=redmine-dit" \
             -e "REDMINE_PROTOCOL2=http" \
             -e "REDMINE_HOST2=redmine-dit" \
             -e "REDMINE_PORT2=80" \
             -e "REDMINE_SERVICE2=/projects.xml" \
             -e "REDMINE_SHARACODE2=A0FHG00000" \
             -e "REDMINE_KEY2=8f12daf3ec712263b74db4a3788bc8ae6b58ef32" \
             --name redmine-ws docker-registry.afip.gob.ar/dearin/redmine-ws:1.0.0
```


