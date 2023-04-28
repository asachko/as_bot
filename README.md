### Telebot
Bot reference: t.me/asachko_bot

## Installation instructions
1. checkout sources from repo
2. set up TELE_TOKEN env variable with Telegram token
3. build project: go build -ldflags "-X="github.com/asachko/telebot/cmd.appVersion=v1.0.2
4. run: ./telebot start
5. enjoy

## Commands example
/start hello