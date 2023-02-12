#!/bin/bash
#
#######################
#    ^...^  `^...^´   #
#   / o,o \ / O,O \   #
#   |):::(| |):::(|   #
# ====" "=====" "==== #
#         TdC         #
#      1998-2022      #
#######################
# Toca das Corujas
# Códigos Binários, Funções de Onda e Teoria do Orbital Molecular Inc.
# Unidade Barão Geraldo CX


xtdc_colors(){
#Código de cores para mensagens no terminal
#Ex: printf "${bred}${obla} TEXTO ${NC}${NC}""%s\n" 

NC='\e[0m'  
#regular colors #bold            #underline       #background    #high intensity  #boldhighint      #highintensityback
bla='\e[0;30m'; bbla='\e[1;30m'; ubla='\e[4;30m'; obla='\e[40m'; ibla='\e[0;90m'; bibla='\e[1;90m'; oibla='\e[0;100m';
red='\e[0;31m'; bred='\e[1;31m'; ured='\e[4;31m'; ored='\e[41m'; ired='\e[0;91m'; bired='\e[1;91m'; oired='\e[0;101m';
gre='\e[0;32m'; bgre='\e[1;32m'; ugre='\e[4;32m'; ogre='\e[42m'; igre='\e[0;92m'; bigre='\e[1;92m'; oigre='\e[0;102m';
yel='\e[0;33m'; byel='\e[1;33m'; uyel='\e[4;33m'; oyel='\e[43m'; iyel='\e[0;93m'; biyel='\e[1;93m'; oiyel='\e[0;103m';
blu='\e[0;34m'; bblu='\e[1;34m'; ublu='\e[4;34m'; oblu='\e[44m'; iblu='\e[0;94m'; biblu='\e[1;94m'; oiblu='\e[0;104m';
pur='\e[0;35m'; bpur='\e[1;35m'; upur='\e[4;35m'; opur='\e[45m'; ipur='\e[0;95m'; bipur='\e[1;95m'; oipur='\e[0;105m';
cya='\e[0;36m'; bcya='\e[1;36m'; ucya='\e[4;36m'; ocya='\e[46m'; icya='\e[0;96m'; bicya='\e[1;96m'; oicya='\e[0;106m';
whi='\e[0;37m'; bwhi='\e[1;37m'; uwhi='\e[4;37m'; owhi='\e[47m'; iwhi='\e[0;97m'; biwhi='\e[1;97m'; oiwhi='\e[0;107m';
}


xtdc_funcs(){
#Lista funções de um script

clear
xtdc_colors
vari=$(sed -nr '/\(\)/p' "${BASH_SOURCE[0]}" | sed 's/...$//')
last=$(date -r "${BASH_SOURCE[0]}" "+%Y_%m_%d_%H_%M_%S")
printf "${bbla}${ocya}LISTA DE FUNÇÕES${NC}${NC} ${bgre}XTDC 2020${NC} ${biblu}${owhi}ATUALIZADA EM${NC}${NC} ${bwhi}${ored}$last${NC}${NC}""%s\n"
printf "${bred}${obla}${vari[@]}${NC}${NC}""%s\n" 
}


xtdc_printa(){
#Tira um print e uma área da tela e salva com data no nome

agora=$(date +%Y_%m_%d_%H_%M_%S)
xfce4-screenshooter -rc
arquivo=$(ls /tmp -Art | tail -n 1)
mv /tmp/"$arquivo" "$HOME/Imagens"/captura_de_tela_"$agora".png
}


maisvol(){
#Aumenta o volume de um vídeo

ffmpeg -i $1 -af volume="$2" -vcodec copy alto_"$1"
}


maisveloc(){
#Aumenta a velocidade de um vídeo

ffmpeg -i $1 -filter_complex "[0:v]setpts=0.625*PTS[v];[0:a]atempo=1.6[a]" -map "[v]" -map "[a]" rapido_$1
}


yt_printa(){
#Tira um print de um vídeo do Youtube
#$1 = id do vídeo
#$2 = tempo em segundos
#$3 = nome do arquivo

ffmpeg -ss "$2" -i $(youtube-dl -f 22 --get-url "https://www.youtube.com/watch?v=""$1") -vframes 1 -q:v 2 "$1"_"$2"_"$3".png; 
}


ytcut(){
#$1 = url do vídeo
#$2 = começo em segundos
#$3 = fim em segundos
#$4 = nome do arquivo

ffmpeg -ss "$2" -to "$3" -i $(youtube-dl -f best --get-url "$1") -c:v copy -c:a copy "$4".mp4
}


xtdc_yt(){
: '
Script para baixar chats de lives do Youtube
Requisitos:
xclip
pip3
chat_downloader
'

#PREPARAÇÃO
chatdata=$(date +%Y%m%d_%H%M)
mkdir "$chatdata"
chmod 777 -R "$chatdata"
cd "$chatdata"

#Pega a área de transferência
url=`xclip -selection c -o`

#Separa a id do vídeo
ide=${url#*=}

#Pega o título do vídeo e filtra
titulo=$(wget -qO- $url | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)(?: - youtube)?\s*<\/title/si')
titulo=$(echo "$titulo" | tr ' ' '_' | iconv -t 'ascii//TRANSLIT')
titulo=${titulo//[^[:alnum:]]/}_"$ide"

#Baixa o chat
chat_downloader $url --message_groups "messages superchat" --output $titulo.json 2>&1 | tee $titulo.txt

#Verifica se há o replay ou apaga o .txt
if grep -q "Video does not have a chat replay" "$titulo.txt"; then
rm -rf "$titulo.txt"
rmdir "$chatdata"
fi
}


loop_lista(){
lista=(
um
dois
tres
)
for item in "${lista[@]}"
do
echo "$item"
done
}


xtdc_gred(){
#Baixa arquivos do GOOGLE DRIVE com suas url reduzidas no BIT.DO
#$1 = url
#$2 = nome do arquivo
aberto=$(curl -sIL "$1" 2>&1 | awk '/^Location/ {print $2}' | tail -n1);
reduzido=$(echo "$aberto" | cut -d'/' -f 6)
#curl -L -o "$2" "https://drive.google.com/uc?export=download&id=""$reduzido"
wget --no-check-certificate "https://docs.google.com/uc?export=download&id=""$reduzido" -O "$2"
}




#zgrep 'install ' /var/log/dpkg.log* | sort | cut -f1,2,4 -d' ' >> datas.txt


