#!/bin/bash

# $dominio é o dominio
# $2 é o nome do arquivo que sera criado

# simpletax.ca

dominio=$1

rm subdominio

echo -ne "Acompanhar andamento do script via terminal? (S/N)"
read -n1 -s escolha

case $escolha in

    "S" || "s")
    echo "Iniciando processo"
		assetfinder $dominio | -a subdominio
        subfinder -silent -d $dominio 2>/dev/null | -a subdominio
        findomain-linux -t $dominio -q | -a subdominio
        clear
        echo "Filtrando Subdominios"
        cat subdominio | uniq -u > subdominios_filtrados
        clear
        echo "Resolvendo subdominios"
        clear
        echo "Subdominios 200 OK, verifique no arquivo subdominios_filtrados"
        cat subdominios_filtrados | httpx -silent -mc 200 | -a subdominios_resolvidos
        gowitness file -f subdominios_resolvidos

        done
	;;

    "N" || "n")
        echo "Iniciando processo"
		assetfinder $dominio | tee -a subdominio
        subfinder -silent -d $dominio 2>/dev/null | tee -a subdominio
        findomain-linux -t $dominio -q | tee -a subdominio
        clear
        echo "Filtrando Subdominios"
        cat subdominio | uniq -u > subdominios_filtrados
        clear
        echo "Resolvendo subdominios"
        clear
        echo "Subdominios 200 OK, verifique no arquivo subdominios_filtrados"
        cat subdominios_filtrados | httpx -silent -mc 200 | tee -a subdominios_resolvidos
        gowitness file -f subdominios_resolvidos

        done
	;;

