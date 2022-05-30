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
cat subdominios_filtrados | httpx -silent | tee -a subdominios_resolvidos
clear
for i in $(cat subdominios_resolvidos);do
    echo $i | httpx -silent -td -nc | grep -F '[' | awk '!($1="")' | tr -d '[]' | sed 's/ /_/g' | sed 's/,/\n/g' | sed 's/^_//g' > tecnologias
    echo $i | httpx -silent -server -nc | grep -F '[' | awk '!($1="")' | tr -d '[]' | sed 's/ /_/g' | sed 's/,/\n/g' | sed 's/^_//g' | sed -r '/^\s*$/d' > server
    echo '######'
    echo $i
    cat tecnologias
    cat server
done