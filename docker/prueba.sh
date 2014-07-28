#### PARA PROBAR - DESCOMENTAR PARA PRUEBAS
REDMINE_NAME1=redmine
REDMINE_PROTOCOL1=http
REDMINE_HOST1=172.17.0.4
REDMINE_PORT1=80

REDMINE_NAME1=redmine-cloud
REDMINE_PROTOCOL1=http
REDMINE_HOST1=172.17.0.5
REDMINE_PORT1=80

#Set separartor to '\n'
OLD_IFS=$IFS
IFS=$'\n'

### Defauts
REDMINE_NAME_DEFAULT="" #No default - error if no set
REDMINE_PROTOCOL_DEFAULT="http"
REDMINE_HOST_DEFAULT="localhost"
REDMINE_PORT_DEFAULT=80
REDMINE_SERVICE_DEFAULT="/projects.xml"

VARIABLES_PREFIX=REDMINE

CMD_SEARCH_VARIABLES='set | grep "^${VARIABLES_PREFIX}" | sed -E -e "s/^${VARIABLES_PREFIX}([^[0-9]]*)([0-9]+)=(.*)$/\2 \1 \3/" | sort'
PIVOT_NUMBER=$($CMD_SEARCH_VARIABLES | head -1 | cut -d' ' -f1)

if [ -n $PIVOT_NUMBER ]
then
   echo "No se seteo ninguna variable ${VARIABLES_PREFIX}_"
   #Reset separator
   IFS=$OLD_IFS
   exit 1
fi
for vars in $($CMD_SEARCH_VARIABLES)
do
  read -a arr <<<$vars
  while [ PIVOT_NUMBER -eq $arr[0] ]
  do
    
  done
done
  



#Reset separator
IFS=$OLD_IFS
