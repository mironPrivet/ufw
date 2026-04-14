#!/bin/bash

# Проверка root
if [[ $EUID -ne 0 ]]; then
   echo "Запусти скрипт от root (sudo)"
   exit 1
fi

# Установка ufw
apt update
apt install -y ufw

# Сброс и базовая настройка
ufw disable
echo "y" | ufw reset

ufw default deny incoming

# Открываем стандартные порты
ufw allow 443
ufw allow 80

# Запрос порта у пользователя
read -p "Введите порт, который нужно открыть для указанных IP: " PORT
read -p "Введите порт Remnanode: " PORTNODE

# Список IP
IPS=(
"91.132.161.30"
"144.31.19.92"
"45.144.53.103"
"144.31.19.92"
"84.252.100.196"
"109.122.198.201"
"144.31.1.81"
"85.192.48.30"
"194.87.29.44"
"109.248.168.200"
"31.25.29.175"
)

# Добавление правил для каждого IP
for IP in "${IPS[@]}"
do
    ufw allow from $IP to any port $PORT
done
ufw allow from 91.132.160.245 to any port $PORTNODE

# Включение ufw
ufw enable

echo "Готово! UFW настроен."
