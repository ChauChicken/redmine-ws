#!/bin/bash

#### PARA PROBAR - DESCOMENTAR PARA PRUEBAS
#REDMINE_NAME1=redmine
#REDMINE_PROTOCOL1=http
#REDMINE_HOST1=172.17.0.4
#REDMINE_PORT1=80

#REDMINE_NAME2=redmine-cloud
#REDMINE_PROTOCOL2=http
#REDMINE_HOST2=172.17.0.5
#REDMINE_PORT2=80


#Set separartor to '\n'
OLD_IFS=$IFS
IFS=$'\n'

CONFIGS=("NAME" "PROTOCOL" "HOST" "PORT" "SERVICE" "KEY" "SARHACODE")

### Defauts
REDMINE_NAME_DEFAULT="" #No default - error if no set
REDMINE_PROTOCOL_DEFAULT="http"
REDMINE_HOST_DEFAULT="localhost"
REDMINE_PORT_DEFAULT=80
REDMINE_SERVICE_DEFAULT="/projects.xml"
REDMINE_KEY_DEFAULT="7f12daf3ec712263b74db4a3788bc8ae6b58ef31"
REDMINE_SARHACODE_DEFAULT="A0FHE00000"

#  name: 'redmine'
#  protocol: 'https'
#  host: 'redmine.afip.gob.ar'
#  port: 443
#  service: '/projects.xml'
#  key: '7f12daf3ec712263b74db4a3788bc8ae6b58ef31'
#  sarhaCode: 'A0FHE00000'


VARIABLES_PREFIX=REDMINE

DIR_WS=/ws
FILE_CONFIG="$DIR_WS/config/redmine-ws.yml"
#Elimino la configuración anterior de existir
rm -f $FILE_CONFIG

variables_numbers=$(set | grep "^${VARIABLES_PREFIX}_[^0-9]\+[0-9]\+=" | sed -E -e "s/^${VARIABLES_PREFIX}_([^0-9]+)([0-9]+)=(.*)$/\2/" | sort -u)
if [ "X${variables_numbers}" == "X" ]
then
   echo "Debe definir al menos una varible REDMINE_NAME(N)"
   exit 3
fi

for i in $(set | grep "^${VARIABLES_PREFIX}_[^0-9]\+[0-9]\+=" | sed -E -e "s/^${VARIABLES_PREFIX}_([^0-9]+)([0-9]+)=(.*)$/\2/" | sort -u)
do 
   ## Por cada numero
   echo "-" >> $FILE_CONFIG 
   for j in $(echo ${CONFIGS[@]} | tr ' ' '\n')
   do 
      ## Por cada variable
      var="${VARIABLES_PREFIX}_$j$i"
      case $j in
          "NAME" )
              if [ "X" == "X${!var}" ]
              then
                 echo "ERROR - name es obligatorio..."
                 echo "Chequee la existencia en los parametros de REDMINE_NAME(N)"
                 exit 2
              fi
              echo "  name: '${!var}'" >> $FILE_CONFIG
              name_exists=1
              ;;
          "PROTOCOL" )
              echo "  protocol: '${!var:-${REDMINE_PROTOCOL_DEFAULT}}'" >> $FILE_CONFIG 
              ;;
          "HOST" )
              echo "  host: '${!var:-${REDMINE_HOST_DEFAULT}}'" >> $FILE_CONFIG 
              ;;
          "PORT" )
              echo "  port: ${!var:-${REDMINE_PORT_DEFAULT}}" >> $FILE_CONFIG 
              ;;
          "SERVICE" )
              echo "  service: '${!var:-${REDMINE_SERVICE_DEFAULT}}'" >> $FILE_CONFIG 
              ;;
          "KEY" )
              echo "  key: '${!var:-${REDMINE_KEY_DEFAULT}}'" >> $FILE_CONFIG 
              ;;
          "SARHACODE" )
              echo "  sarhaCode: '${!var:-${REDMINE_SARHACODE_DEFAULT}}'" >> $FILE_CONFIG 
              ;;
      esac
   done
done

echo "Archivo de configuración $FILE_CONFIG generado exitosamente."

#Reset separator
IFS=$OLD_IFS
