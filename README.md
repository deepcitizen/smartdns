# SmartDNS
Легко получите DNS сервер, позволяющий проксировать запросы для определенных доменов с поддержкой DoT (DNS Over TLS)

## Подготовка
Вам потребуется сервер на linux (ubuntu) и установленный docker. Подробнее об установке докера:
https://support.netfoundry.io/hc/en-us/articles/360057865692-Installing-Docker-and-docker-compose-for-Ubuntu-20-04

Так же для работы DoT вам необходимо зарегистрировать свой домен, направленный на ваш сервер

## Клонирование реозитория
Склонируйте этот репозиторий
```bash
git clone git@github.com:deepcitizen/smartdns.git
```

Настройте файлы `dnsmasq.conf` для своего использования. 
В них указываются домены, которые будут проксироваться сервером

## Получения SSL сертификата
Для получения SSL сертификата выполните следующие команды:
```bash
cd smartdns
./create-certificate.sh
```

При выполнении команды необходимо будет указать домен вашего сервера и email. 
На этот домен будет выпущен сертификат Let's Encrypt

## Запуск
Переопределите переменные окружения, указанные в .env.sample.

```bash
cp .env.sample .env
# Укажите IP адрес своего сервера в переменной окружения `IP`
# Укажите домен своего сервера в переменной окружения `SERVER_DOMAIN` (тот же самый, который был использован при выпуске сертификата)

docker-compose up --build -d
```

Enjoy!

***Внимание! После внесения очередных изменений в файл `dnsmasq.conf` необходимо пересобрать проект***
```bash
docker-compose up --build -d
```

### Возможные проблемы и решения
Если docker не стартует, возможно у вас занят 53 порт. Для его освобождения можно выполнить команду

```bash
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved
```

## Использование
Для использования DNS сервера можно указать IP адрес сервера в роутере/системе, либо ваш домен (при использовании DoT)