Если при создании .onion домена средствами ISPmanager возникает такая ошибка:

******************* [warn] Permissions on directory /var/www/{ISP_USER}/data/www/{YOU_DOMAIN_NAME}.onion/ are too permissive.

******************* [warn] Failed to parse/validate config: Failed to configure rendezvous options. See logs for details.

******************* [err] Reading config failed--see warnings above. For usage, try -h.

******************* [warn] Restart failed (config error?). Exiting.

Эта ошибка возникает в следствии того, что ISPmanager при содании директории дает ей права 0755, а Tor считает эти права завышенными и прекращает свою работу.

Решение проблемы:
- Перед запуском Tor изменить права на дерикторию домена: 0700
- Установить группу и пользователя к директории домена: debian-tor:{ISP_USER}
- Запустить тор: service tor start
- Изменить права на дерикторию домена: 0755 (для того, чтобы веб-сервер имел доступ к файлам, иначе в браузере вы убидете ошибку 403)

Для решения этой пробелемы в автоматическом режиме мы написали небольшой shell-скрипт "fix_permission_tor_isp.sh"

Установка:
$ wget -P /usr/local/bin/ https://raw.githubusercontent.com/Quareal/fix_permission_tor_isp/master/fix_permission_tor_isp.sh
$ chmod +x /usr/local/bin/fix_permission_tor_isp.sh
Добавить в планировщик ISPmanager на выполнение раз в минуту:
* * * * * /usr/local/bin/fix_permission_tor_isp.sh
