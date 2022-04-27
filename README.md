# ZSSN - Zombie Survival Social Network

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

## About the current test
Você precisa desenvolver uma API RESTful que armazene sobreviventes de um apocalipse zumbi
e permita que eles encontrem o sobrevivente mais próximo de sua localização.

- Criar novos sobreviventes - nome, sexo e localização atual (latitude/longitude)
- Recuperar um sobrevivente - ID de sobrevivente necessário
- Atualização para sobrevivente
- Recupere o sobrevivente mais próximo de um sobrevivente -
  id de sobrevivente necessário, você pode usar apenas latitude ou longitude para calculá-lo. Isto é para ajudar um sobrevivente a identificar quem é mais próximo.
- Marcar sobrevivente como infectado -
  Um sobrevivente é marcado como infectado quando pelo menos 3 outros sobreviventes relatam que está infectado.outros sobreviventes relatam que está infectado.

## Result of Lean Inception
For the development of the API, I used the Chaos and Order mechanism, where Chaos would be all that came to my mind about the problem and Order would be the [Documentation](https://drive.google.com/file/d/1x5L1VwF8CyDEJHvxHmZ9LrDpUVBIKt1g/view?usp=sharing) creation process

[Click here](https://drive.google.com/file/d/1x5L1VwF8CyDEJHvxHmZ9LrDpUVBIKt1g/view?usp=sharing) to get the collection of requests made in Postman, download and import!

## Install
### Docker
Make sure you have Docker and Docker-Compose installed on your machine!
Inside the project directory, copy `.env` with:
```sh
cp .env.docker.sample .env
```
Run to build the docker image:
```sh
docker-compose build
```

Creating and migrating database:
```sh
docker-compose run --rm app bundle exec rails db:create db:migrate
```
Go up the application:
```
docker-compose up -d
```
### Ruby on Rails
Given that you have the Ruby(3.0.2), Rails(7.0.2.3) and DB PostgreSQL versions installed:
Copy `.env` and configure your PostgreSQL credentials!
```sh
cp .env.sample .env
```

Creating and migrating database:
```sh
rails db:create
rails db:migrate
```

Go up the application:
```
rails s
```


## License

MIT

**Free Software, Hell Yeah!**
