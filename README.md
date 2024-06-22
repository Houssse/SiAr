# SiAr

## Описание

SiAr - это проект для размещения и управления статьями, созданный для демонстрации навыков и размещения в резюме. Проект находится в стадии доработки.

## Доступ к приложению

Проект размещен на [Render](https://siar.onrender.com).

Для просмотра функционала можно использовать готового пользователя, который создается с помощью seed:

- Email: user@user.com
- Пароль: 123456

Или вы можете зарегистрировать нового пользователя.

## Локальная установка

### Предварительные требования

Перед началом работы убедитесь, что у вас установлены следующие зависимости:

- Ruby 3.3.0
- Rails 7.1.3
- База данных (PostgreSQL/MySQL/SQLite - выберите подходящую для вас)
- Node.js и Yarn

### Установка

Следуйте этим шагам для установки проекта локально:

1. Клонируйте репозиторий:
    ```sh
    git clone git@github.com:Houssse/SiAr.git
    ```
2. Перейдите в папку проекта:
    ```sh
    cd SiAr
    ```
3. Установите зависимости:
    ```sh
    bundle install
    ```
4. Установите зависимости JavaScript:
    ```sh
    yarn install
    ```
5. Настройте базу данных:
    ```sh
    rails db:create
    rails db:migrate
    rails db:seed
    ```
6. Запустите сервер:
    ```sh
    bin/dev
    ```

Перейдите по адресу `http://localhost:3000` в вашем браузере для доступа к приложению.

## Использование

Для доступа к функционалу используйте учетные данные готового пользователя или зарегистрируйте нового пользователя.

## Тестирование

Для запуска тестов выполните следующие шаги:

1. Установите зависимости для тестирования:
    ```sh
    bundle install
    ```
2. Запустите тесты:
    ```sh
    bundle exec rspec
    ```

## Используемые библиотеки и гемы

Проект использует следующие библиотеки и гемы:

- Devise (~> 4.9)
- Faker (~> 3.4)
- Database Cleaner
- Factory Bot Rails
- RSpec Rails

Проект также использует JavaScript с esbuild и CSS с Bootstrap.

## Лицензия

Этот проект лицензирован под [MIT License](LICENSE).
