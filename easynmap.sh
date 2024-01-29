#!/bin/bash

nocolor='\033[0m'
red='\033[0;31m'
cyan='\033[1;36m'

if [ $(id -u) -ne 0 ]; then
	echo -e "${red}You have to be root!${nocolor}"
exit

fi

test -f /usr/bin/nmap

if [ "$(echo $?)" == "0" ]; then
	clear
read -p "Introduce the IP: " ip

	while true; do
	echo -e  "\n1) Quick scan"
	echo "2) Normal scan"
	echo "3) Stealth scan (May take longer)"
	echo "4) Service scan"
	echo "5) Quit"
	read -p "Select an option: " option
	case $option in

1)
clear && echo "Scanning..." && nmap -p- --open --min-rate 5000 -T5 -sS -Pn -n -v $ip > quickscan.txt && echo -e "${cyan}Report saved in file quickscan.txt${nocolor}"
exit
;;
2)
clear && echo "Scanning..." && nmap -p- --open $ip > normalscan.txt && echo -e "${cyan}Report saved in file normalscan.txt${nocolor}"
exit
;;
3)
clear && echo "Scanning..." && nmap -p- -T2 -sS -Pn -f $ip > stealthscan.txt && echo -e "${cyan}Report saved in file stealthscan.txt${nocolor}"
exit
;;
4)
clear && echo "Scanning..." && nmap -sV -sC $ip > servicescan.txt && echo -e "${cyan}Report saved in file servicescan.txt${nocolor}"
exit
;;
5)
break
;;
*)
echo -e "Invalid parameter"
;;
esac
done

else
echo -e "\n[!] You have to install dependencies" && apt update >/dev/null && apt install nmap -y >/dev/null && echo -e "\nDependencies installed"
fi

