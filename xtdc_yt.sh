#!/bin/bash
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
#2022_06_24_20_15_58

#############################################
#Script para baixar chats de lives do Youtube
#
#Requisitos:
#
#xclip
#pip3
#chat_downloader
#############################################

#Pega a área de transferência
url=$(xclip -selection c -o)


#Checa se é uma url válida
if  [[ $url != http* ]];
then
zenity --error --text "Url do Youtube inválida"
else


#Preparação
cd "$HOME/CHATS" || return
chatdata=$(date +%Y%m%d_%H%M)
mkdir "$chatdata"
chmod 777 -R "$chatdata"
cd "$chatdata" || return


#Separa a id do vídeo
ide=${url#*=}


#Pega o título do vídeo e filtra
titulo=$(wget -qO- "$url" | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)(?: - youtube)?\s*<\/title/si')

titulo=$(echo "$titulo" | tr ' ' '_' | iconv -t 'ascii//TRANSLIT')

titulo=${titulo//[^[:alnum:]]/}_"$ide"


#Chat
chat_downloader "$url" --message_groups "messages superchat" --output "$titulo".json 2>&1 | tee "$titulo".txt

zenity --info --text "Chat baixado"


#Verifica se há o replay ou apaga
if grep -q "Video does not have a chat replay" "$titulo.txt"; then
rm -rf "$titulo.txt"
rmdir /"$HOME"/CHATS/"$chatdata" 
zenity --info --text "Vídeo sem chat"
fi

#Limpa emotes
arquivo="$titulo.json"
if [[ -f "$arquivo" ]]; then
zenity --info --text "Limpando emotes"
while
read -r A B;
do
sed -i "s/${A}/${B}/g" "$titulo".txt;
sed -i "s/${A}/${B}/g" "$titulo".json;
done<<EOF
:alien: 👽
:ambulance: 🚑
:angry_face: 😠
:astonished_face: 😲
:baby: 👶
:baby_bottle: 🍼
:backhand_index_pointing_left: 👈
:backhand_index_pointing_right: 👉
:balloon: 🎈
:battery: 🔋
:beaming_face_with_smiling_eyes: 😁
:beer_mug: 🍺
:bell: 🔔
:beverage_box: 🧃
:blue_heart: 💙
:bomb: 💣
:bouquet: 💐
:boxing_glove: 🥊
:boy: 👦
:brain: 🧠
:buffering: ⌛
:bus: 🚌
:call_me_hand: 🤙
:camera: 📷
:castle: 🏰
:cat_with_tears_of_joy: 😹
:chicken: 🐔
:cigarette: 🚬
:clap: 👏
:clapping_hands: 👏
:clipboard: 📋
:clown_face: 🤡
:coffin: ⚰
:cold_face: 🥶
:collision: 💥
:confused_face: 😕
:construction: 🚧
:cookie: 🍪
:cow: 🐂
:cow: 🐄
:crab: 🦀
:dashing_away: 💨
:deciduous_tree: 🌳
:disappointed_face: 😞
:disguised_face: 🥸
:dog: 🐕
:dog2: ✖️
:dog2: 🐕
:dothefive: 5️⃣
:dothefive: 5️⃣
:double_exclamation_mark: ‼
:double_exclamation_mark: ‼
:drooling_face: 🤤
:earth_africa: 🌍
:earth_americas: 🌎
:eggplant: 🍆
:elbowcough: 💪
:exclamation_question_mark: ⁉
:exploding_head: 🤯
:expressionless_face: 😑
:eye: 👁
:eyes: 👀
:face_blowing_a_kiss: 😘
:face_savoring_food: 😋
:face_screaming_in_fear: 😱
:face_vomiting: 🤮
:face_with_hand_over_mouth: 🤭
:face_with_monocle: 🧐
:face_with_open_mouth: 😮
:face_without_mouth: 😶
:face_with_raised_eyebrow: 🤨
:face_with_rolling_eyes: 🙄
:face_with_spiral_eyes: 😵‍💫
:face_with_tears_of_joy: 😂
:face_with_tongue: 😛
:fire: 🔥
:fish: 🐟
:flexed_biceps: 💪
:flushed_face: 😳
:folded_hands: 🙏
:frog: 🐸
:full_moon_face: 🌝
:garlic: 🧄
:ghost: 👻
:glass_of_milk: 🥛
:globe_showing_americas: 🌎
:globe_showing_asia_australia: 🌏
:globe_showing_europe_africa: 🌍
:goat: 🐐
:goodvibes: ✌️
:grimacing_face: 😬
:grinning_face: 😀
:grinning_face_with_big_eyes: 😃
:grinning_face_with_smiling_eyes: ✖️
:grinning_face_with_smiling_eyes: 😁
:grinning_face_with_sweat: 😅
:grinning_squinting_face: 😆
:handshake: 🤝
:hand_with_fingers_splayed: 🖐
:heart_on_fire: ❤‍🔥
:herb: 🌿
:hibiscus: 🌺
:horse: 🐎
:house_with_garden: 🏡
:hugging_face: 🤗
:hushed_face: 😯
:hydrate: 💩
:kiss: 💋
:kissing_face_with_closed_eyes: 😚
:knocked_out_face: 😵
:left_facing_fist: 🤛
:leopard: 🐆
:lollipop: 🍭
:loudly_crying_face: 😭
:loudspeaker: 📢
:lying_face: 🤥
:magnifying_glass_tilted_right: 🔎
:man_facepalming: 🤦‍♂
:man_shrugging: 🤷‍♂
:man_swimming: 🏊‍♂
:man_zombie: 🧟‍♂
:microphone: 🎤
:middle_finger: 🖕
:money_mouth_face: 🤑
:money_with_wings: 💸
:mouth: 👄
:movie_camera: 🎥
:multiply: ✖️
:musical_note: 🎵
:musical_notes: 🎶
:musical_score: 🎼
:national_park: 🏞
:nerd_face: 🤓
:neutral_face: 😐
:night_with_stars: 🌃
:office_building: 🏢
:oncoming_fist: 👊
:oops: 🤭
:oops: ✖️
:open_hands: 👐
:ox: 🐂
:partying_face: ✖️
:partying_face: 💩
:pear: 🍐
:pensive_face: 😔
:person_facepalming: 🤦
:person_fencing: 🤺
:person_gesturing_ok: 🙆
:person_raising_hand: 🙋
:person_running: 🏃
:person_shrugging: 🤷
:person_swimming: 🏊
:person_taking_bath: 🛀
:petri_dish: 🧫
:pig: 🐷
:pile_of_poo: 💩
:pill: 💊
:pizza: 🍕
:point_left: 👈
:point_right: 👉
:poodle: 🐩
:popcorn: 🍿
:potato: 🥔
:pouting_face: 😡
:prohibited: 🚫
:purple_heart: 💜
:racehorse: 🐎
:radio: 📻
:raised_fist: ✊
:raised_hand: ✋
:raising_hands: 🙌
:red_exclamation_mark: ❗
:red_heart: ❤
:red_question_mark: ❓
:relieved_face: 😌
:revolving_hearts: 💞
:right_facing_fist: 🤜
:robot: 🤖
:rolling_on_the_floor_laughing: 🤣
:rose: 🌹
:sad_but_relieved_face: 😥
:sailboat: ⛵
:scissors: ✂
:scroll: 📜
:see_no_evil_monkey: 🙈
:selfie: 🤳
:sheaf_of_rice: 🌾
:shushing_face: 🤫
:sign_of_the_horns: 🤘
:skull: 💀
:sleeping_face: 😴
:sleepy_face: 😪
:slightly_frowning_face: 🙁
:slightly_smiling_face: 🙂
:small_airplane: 🛩
:smiling_cat_with_heart_eyes: 😻
:smiling_face_with_halo: 😇
:smiling_face_with_heart_eyes: 😍
:smiling_face_with_horns: 😈
:smiling_face_with_smiling_eyes: 😊
:smiling_face_with_sunglasses: 😎
:smiling_face_with_tear: 💩
:smirking_face: 😏
:snake: 🐍
:sneezing_face: 🤧
:soccer_ball: ⚽
:socialdist: ✖️
:softball: ⚽
:sparkles: ✨
:sparkling_heart: 💖
:speaking_head: 🗣
:speak_no_evil_monkey: 🙊
:spouting_whale: 🐳
:squinting_face_with_tongue: 😝
:squinting_face_with_tongue: 😝
:star_struck: 🤩
:sun: ☀
:sweat_droplets: 💦
:syringe: 💉
:tangerine: 🍊
:test_tube: 🧪
:thermometer: 🌡
:thinking_face: 🤔
:thought_balloon: 💭
:thumbs_up: 👍
:toilet: 🚽
:triangular_ruler: 📐
:trident_emblem: 🔱
:tulip: 🌷
:turtle: 🐢
:two_hearts: 💕
:unamused_face: 😒
:upside_down_face: 🙃
:v: ✌
:victory_hand: ✌
:warning: ⚠
:washhands: 💩
:water_pistol: 🔫
:water_wave: 🌊
:waving_hand: 👋
:weary_cat: 🙀
:weary_face: 😩
:white_exclamation_mark: ❕
:winking_face: 😉
:winking_face_with_tongue: 😜
:woman_cartwheeling: 🤸‍♀️
:woman_dancing: 💃
:woman_in_lotus_position: 🧘‍♀
:woman_raising_hand: 🙋‍♀
:womans_sandal: 👡
:woozy_face: 💩
:yougotthis: 💩
:yt: ▶️
:zany_face: 🤪
:zzz: 😴
EOF
fi

zenity --info --text "ACABOU"

fi
#FIM DO SCRIPT


#Converter o arquivo .json para xls no site
 
#https://www.convertcsv.com/json-to-csv.htm
