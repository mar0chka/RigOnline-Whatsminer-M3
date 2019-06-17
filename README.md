Скрипт для сбора и передачи данных с асика Whatsminer M3 на сервер [rigonline.ru](https://rigonline.ru/)
Инструкция по установке:
1. Регистрируемся на сайте [rigonline.ru](https://rigonline.ru/), записываем регистрационный e-mail и секретный ключ из профиля
2. Заходим в асик по SSH. Подойдет любой клиент, например Putty.
3. скачиваем скрипт в каталог /etc/init.d:
```bash
cd /etc/init.d
wget https://raw.githubusercontent.com/mar0chka/RigOnline-Whatsminer-M3/master/RigOnline.sh --no-check-certificate
chmod u+x RigOnline.sh
```
4. Вставляем в скрипт регистрационные данные с сайта [rigonline.ru](https://rigonline.ru/)

```bash
vi RigOnline.sh
```
Чтобы начать вносить правки в файл, жмем Insert,
далее вписываем номер рига от 1 до 150, e-mail и секретный ключ.
После того как отредактировали файл, жмем Esc и прописываем команду на закрытие и сохранение файла
`:wq`

5. Пробуем запустить скрипт:
```bash
./RigOnline.sh
```
Скрипт после 30 секунд ожидания должен начать отправлять данные на сервер, так же асик должен появится на сайте.

6. Если все работает жмем ctrl+C и прописываем скрипт в автозагрузку.
```bash
ln -sf /etc/init.d/RigOnline.sh /etc/rc.d/S99rigonline.sh
```

7. Перезагружаем асик
```bash
reboot
```

8. После этого все должно работать, на сайте [rigonline.ru](https://rigonline.ru/) в настройках рига для удобства указываем понятное имя и повышем лимит по температуре до 90.

