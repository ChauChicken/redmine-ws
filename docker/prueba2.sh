count=0
for i in $(set | grep '^R_' | sed -E -e "s/^R_([^[0-9]]*)([0-9]+)=(.*)$/\2 \1 \3/" | sort | awk 'BEGIN{FS=" "} {a[$1]=a[$1] sprintf("%s%s%s ", $2, "=", $3)}END{for (i in a) printf("%s \n", a[i])}')
do 
   ## Por cada grupo
   vars=($(echo $i | tr " " "\n"))
   for j in ${vars[@]}
   ## Por cada variable
   do 
      ##### Acá cambiar por switch
      key_value=($(echo "$j" | tr '=' "\n"))
      echo ${key_value[0]} ${key_value[1]}
   done
   count=$(expr $count + 1)
   echo "Fin $count"
done

