# ZSSN - Zombie Survival Social Network

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

## About the current test
You need to develop a RESTful API that stores survivors from a zombie apocalypse and allow
them to find the closest survivor from their location.
- Create new survivors - name, gender and current location (latitude/ longitude)
- Retrieve a survivor - survivor id required
- Update a survivor
- Retrieve closest survivor from a survivor - survivor id required, you can use
only latitude or longitude to calculate it. This is to help a survivor to identify who is
closer.
- Mark survivor as infected - A survivor is marked infected when at least 3 others
survivors report that it is infected.

## Result of Lean Inception
For the development of the API, I used the Chaos and Order mechanism, where Chaos would be all that came to my mind about the problem and Order would be the [Documentation](https://drive.google.com/file/d/1x5L1VwF8CyDEJHvxHmZ9LrDpUVBIKt1g/view?usp=sharing) creation process

## Install
### Docker
Make sure you have Docker and Docker-Compose installed on your machine!

Inside the project directory:

Run to copy `.env` with:
```
cp .env.docker.sample .env
```

Run to build the docker image:
```
docker-compose up --build
```

Install the gems
```
docker-compose run --rm app bundle install
```

Creating and migrating database:
```
docker-compose run --rm app bundle exec rails db:create db:migrate
```

Go up the application:
```
docker-compose up -d
```


Run tests Rspec with:
```
docker-compose run --rm app bundle exec rspec spec
```

### Ruby on Rails
Given that you have the Ruby(3.0.2), Rails(7.0.2.3) and DB PostgreSQL versions installed:
Inside the project directory:
Run to copy `.env`, and configure your PostgreSQL credentials!
```
cp .env.sample .env
```

Install the gems
```
bundle install
```

Creating and migrating database:
```
rails db:create
rails db:migrate
```

Go up the application:
```
rails s
```


Run tests Rspec with:
```
bundle exec rspec spec
```

## Who to use
After go up API, now with the domain localhost http://localhost:3000 you will have access to the root_path API.

[Click here](https://github.com/padualima/zssn-maxihost-api/blob/main/vendor/zssn-api.postman_collection.json) to get the collection of requests made in Postman, download and import!

[Use this](https://github.com/padualima/zssn-maxihost-api/blob/main/vendor/suport_location.rb) to help you get nearest locations!

## License

MIT

**Free Software, Hell Yeah!**
