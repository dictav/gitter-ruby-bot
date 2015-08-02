# Gitter Bot

You'll need an oAuth token from [developer.gitter.im](https://developer.gitter.im), a [User ID](https://developer.gitter.im/docs/user-resource) and a [Room ID](https://developer.gitter.im/docs/rooms-resource).

## Install

```
$ bundle install
```

## Usage

```
$ TOKEN=<token> ROOM_ID=<room_id> BOT_ID=<bot_id> REDIS_URL=<redis_url> ruby bot.rb
```

or use foreman

```
$ edit .env
$ foreman start
```

```
# .env
TOKEN=<token>
ROOM_ID=<room_id>
BOT_ID=<bot_id>
REDIS_URL=<redis_url>
```
