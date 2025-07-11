**ShiftApp**

Реализовано 2 экрана:

**1. Экран "Регистрация"**
На экране находится 6 основных элементов:

**_- Два TextField для ввода имени и фамилии_**

Для того, что бы заполнить поля корректно необходимо что бы:
   - Имя и фамилия содержали только буквы;
   - Имя и фамилия содержали больше двух букв.
     
Если пользователь не выполнил эти условия, рамка поля окрашивается в красный цвет, если поля заполнены верно рамка становится фиолетовой.

**_- UIDatePicker для ввода даты рождения_**

Выставлено ограничение по возрасту: зарегистрироваться может только пользователь старше 18 лет(2007 г. р.).

**_- Два TextField для ввода пароля и его подтверждения_**

Для того, что бы корректно заполнить поле "Пароль" нужно что бы:
   - Была хотя бы одна буква верхнего регистра;
   - Была хотя бы одна буква нижнего регистра;
   - Была хотя бы одна цифра;
   - Пароль содержал не менее 8 символов.
     
Все условия прописаны под полем "Пароль", когда пользователь выполняет условие, оно окрашивается в фиолетовый цвет. Пароль считается корректно заполненным, когда все условия окрасятся в фиолетовый цвет.
Поле "Подтвердите пароль" заполнено правильно, когда пароль введенный в поле "Пароль" полностью совпадает с паролем введенным в поле "Подтвердите пароль". Если пароль совпадает, появляется фраза: "Пароль совпадает", если нет - "Пароль не совпадает".

В полях "Пароль" и "Подтвердите пароль" также реализованы rightView в виде "глаза", которые позволяют просмотреть пароль и его скрыть.

**_- UIButton «Зарегистрироваться»_**

Кнопка недоступна для нажатия, пока все поля не будут заполнены в соответствии с условиями. Реализовано сохранение сессии: если пользователь единожды прошел регистрацию, то следующий запуск приложения начинется с главного экрана.

Если все данные валидны, то пользователь переходит на «Главный экран» приложения.

**2. «Главный экран»**

На экране 2 элемента:

**_- UITableView со списком элементов_**

При заходе на экран отправляется запрос на сервер для получения элементов таблицы. Во время загрузки на экране отображается Activity Indicator. В ячейке таблицы отображается картинка товара, название, стоимость и рейтинг.

**_- UIButton «Приветствие»_**

По нажатию на кнопку появляется модальное окно, в котором находится приветствие пользователя с указанием имени, которое было введено им на экране регистрации(имя пользователя кэшируется в локальное хранилище UserDefaults).

**Архитектура:** MVVM + Router + Assembly

**UI:** UIKit, AutoLayout

**Сетевой слой:** URLSession, сервисы, самописный HttpClient для работы с API

**Минимальная версия iOS:** 15.0

**Тесты:** Логика ViewModel'ей покрыта Unit-тестами

<img src="https://github.com/user-attachments/assets/cb076e0e-0596-416d-9d83-69b1e2849c68" width="230">
<img src="https://github.com/user-attachments/assets/e69f9da4-c680-4b41-8dc8-8a69314ed89e" width="230">
<img src="https://github.com/user-attachments/assets/199324c7-6808-4d50-a395-b5f9719e8db3" width="230">
<img src="https://github.com/user-attachments/assets/137d6056-9253-4671-b42d-034bf956f511" width="230">
