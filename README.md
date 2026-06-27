# DevGate Shared Services

Docker-инфраструктура для общих сервисов DevGate — обратного прокси и брокера сообщений.

## Состав

| Сервис    | Описание                                      |
|-----------|-----------------------------------------------|
| **gateway** | Nginx reverse proxy для маршрутизации к микросервисам |
| **broker**  | RabbitMQ 4 с Management UI                    |

## Требования

- Docker
- Docker Compose (v2)
- Внешняя сеть `app_network`: `docker network create app_network`

## Быстрый старт

```bash
# Запустить все сервисы
make all

# Остановить все сервисы
make down-all
```

## Makefile

| Цель       | Действие                          |
|------------|-----------------------------------|
| `all`      | Запускает все compose-стэки       |
| `down-all` | Останавливает все compose-стэки   |
| `gateway`  | Запускает только gateway (Nginx)  |
| `broker`   | Запускает только broker (RabbitMQ)|

Все сервисы запускаются с `restart: unless-stopped`.

## Gateway (Nginx)

Проксирует запросы к микросервисам по доменным именам:

- `api.devgate.users.local` → `user-service:8081`
- `api.devgate.audit.local` → `audit-service:8082`

Для локального тестирования добавьте в `/etc/hosts`:

```
127.0.0.1 api.devgate.users.local
127.0.0.1 api.devgate.audit.local
```

## Broker (RabbitMQ)

- **AMQP**: `localhost:5672`
- **Management UI**: `http://localhost:15672`

## Сеть

Все сервисы подключаются к внешней сети Docker `app_network` для взаимодействия с другими контейнерами DevGate.
