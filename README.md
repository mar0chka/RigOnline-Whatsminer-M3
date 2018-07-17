Скрипт для сбора и передачи данных с асика Whatsminer M3 на сервер [rigonline.ru](https://rigonline.ru/)
Инструкция по установке:
1. Регистрируемся на сайте [rigonline.ru](https://rigonline.ru/), записываем регистрационный e-mail и секретный ключ из профиля
2. Заходим в асик по SSH. Подойдет любой клиент, например Putty.
3. скачиваем скрипт в каталог /data:
```bash
cd /data
wget https://raw.githubusercontent.com/mar0chka/RigOnline-Whatsminer-M3/master/RigOnline.sh --no-check-certificate
chmod +x RigOnline.sh
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

6. Если все работает, прописываем скрипт в автозагрузку, для этого нужно отредактировать файл /etc/rc.local и вписать путь к скрипту перед строкой exit 0.
```bash
vi /etc/rc.local
```
Редактируем аналогично файлу RigOnline.sh
в итоге должно получится
```bash
# Put your custom commands here that should be executed once
# the system init finished. By default this file does nothing.
/data/RigOnline.sh &
exit 0
```
Важно чтобы после пути к скрипту через пробел стоял символ &.
Жмем Esc и прописываем `:wq`

7. Перезагружаем асик
```bash
reboot
```

8. После этого все должно работать, на сайте [rigonline.ru](https://rigonline.ru/) в настройках рига для удобства указываем понятное имя и повышем лимит по температуре до 90.

