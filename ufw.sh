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
ufw allow 9998

# Запрос порта у пользователя
read -p "Введите порт, который нужно открыть для указанных IP: " PORT

# Список IP
IPS=(
"193.233.112.49"
"95.85.235.188"
"95.85.233.39"
"94.103.1.58"
"51.250.24.4"
"95.85.240.220"
"81.90.21.41"
"217.60.7.245"
"178.236.252.27"
"84.252.101.80"
"84.201.137.87"

)

# Добавление правил для каждого IP
for IP in "${IPS[@]}"
do
    ufw allow from $IP to any port $PORT
done


# Включение ufw
ufw enable

echo "Готово! UFW настроен."
