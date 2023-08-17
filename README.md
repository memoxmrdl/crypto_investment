# Crypto Investment

## Requerimientos

- Ruby 3.2.2
- Rails 7.0.7
- Redis
- PostgreSQL

## Bundle

Para instalar las gemas es necesario ejecutar lo siguiente:

    bundle install

## Base de datos

Para crear la base de datos es necesario ejecutar lo siguiente:

    bin/rails db:create

Ejecutar las migraciones:

    bin/rails db:migrate

## Variables de entorno

La APP necesita obtener información desde la API de [CoinMarketCap](https://coinmarketcap.com/api/documentation/v1) para registrar todas las criptomonedas disponibles.
Es necesario copiar el archivo `bin/env.example` para eso ejecuta lo siguiente:

    cp bin/env.example bin/env

## Levantar servicios

Para levantar el servidor de Rails es necesario primero definir las variables de entorno del archivo `bin/env`, para eso ejecuta lo siguiente:

    source bin/env

Después de esto ahora si procedemos a levantar los servicios con:

    bin/dev

Ahora click al siguiente enlace para acceder al servidor: [http://localhost:3005/](http://localhost:3005)

## Pruebas

Para ejecutar las pruebas es necesario ejecutar lo siguiente:

    bin/rails test

## CI

Para ejecutar el CI (ejecuta pruebas, linter, brakeman y bundle-audit) es necesario ejecutar lo siguiente:

    bin/ci
