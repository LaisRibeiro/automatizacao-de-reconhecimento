#!/bin/bash

# $dominio é o dominio
# $2 é o nome do arquivo que sera criado

# simpletax.ca

dominio=$1

flag=$2

rm subdominio 2>/dev/null

case $flag in
    "-silent")
        echo "Iniciando processo"
        rm -r $1 2>/dev/null
        mkdir $1
        cd $1
	    assetfinder $dominio &> subdominio
        subfinder -silent -d $dominio 2>/dev/null &> subdominio
        findomain-linux -t $dominio -q &> subdominio
        clear
        echo "Filtrando Subdominios"
        cat subdominio | uniq -u 1> subdominios_filtrados
        clear
        echo "Resolvendo subdominios"
        clear
        echo "Subdominios 200 OK, verifique no arquivo subdominios_filtrados"
        cat subdominios_filtrados | httpx -silent -mc 200 | tee -a subdominios_resolvidos | sort -u 1> subdominios_resolvidos
        cat subdominios_resolvidos
        gowitness file -f subdominios_resolvidos
            cat subdominios_resolvidos | httpx -silent -ip | awk '{print $2}' | tr -d '[]' &>ips
            for i in $(cat ips)
            do
                for x in $(cat subdominios_resolvidos)
                do
                    echo "Começando Portscan:"
                    echo $x
                    rm nmap_scan 2>/dev/null
                    nmap -sSV -p80,443 --open -Pn $i 1>>nmap_scan
                    echo "Resultados:"
                    cat nmap_scan | grep "open"
                done
            done
        
	    ;;

        *)
        rm $1 &>/dev/null
        mkdir $1
        cd $1
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
            cat subdominios_filtrados | httpx -silent -mc 200 | tee -a subdominios_resolvidos | sort -u 1> subdominios_resolvidos
            cat subdominios_resolvidos
            echo "\nGowitness"
            gowitness file -f subdominios_resolvidos
            cat subdominios_resolvidos | httpx -silent -ip | awk '{print $2}' | tr -d '[]' &>ips
            for i in $(cat ips)
            do
                for x in $(cat subdominios_resolvidos)
                do
                    echo "Começando Portscan:"
                    echo $x
                    rm nmap_scan 2>/dev/null
                    nmap -sSV -p80,443 --open -Pn $i 1>>nmap_scan
                    echo "Resultados:"
                    cat nmap_scan | grep "open"
                done
            done
	        ;;
    
        esac
