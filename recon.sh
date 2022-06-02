#!/bin/bash

# $dominio é o dominio
# $2 é o nome do arquivo que sera criado

# simpletax.ca

dominio=$1

rm subdominio
assetfinder $dominio | tee -a subdominio
subfinder -silent -d $dominio 2>/dev/null | tee -a subdominio
findomain-linux -t $dominio -q | tee -a subdominio
clear
echo "Filtrando Subdominios"
cat subdominio | uniq -u > subdominios_filtrados
clear
echo "Resolvendo subdominios"
clear
echo "Subdominios 200 OK"
cat subdominios_filtrados | httpx -silent -mc 200 | tee -a subdominios_resolvidos
gowitness file -f subdominios_resolvidos

done
