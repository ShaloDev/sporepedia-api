# Sporepedia

![Ruby Version](https://img.shields.io/badge/Ruby-%3E%3D%203.1.2-red.svg)
![Rails Version](https://img.shields.io/badge/Rails-%3E%3D%207.0.8-red.svg)

A small web app, that scraps creatures from [Spore API](http://www.spore.com/comm/developer/) with custom XML parser.
## Installation

1. Clone the repository:

```
git clone https://github.com/ShaloDev/sporepedia-api.git
cd sporepedia-api
```

2. Install bootstrap dependencies:

```
rails css:install:bootstrap
```

3. Set up docker:

```
docker compose build
docker compose up
```

4. Set up database:

```
docker compose run web rails db:create
docker compose run web rails db:migrate
```

5. Access the application in your web browser at http://localhost:3000.
