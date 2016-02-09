'use strict'

express = require 'express'
bodyParser = require 'body-parser'

app = express()

app.set 'port', process.env.PORT or 5000
app.set 'token', process.env.ZENDESK_TOKEN or 'token'
app.set 'redirect', process.env.REDIRECT or false
app.set 'origin', process.env.ORIGIN or "*"

app.use bodyParser.urlencoded(extended: true)
app.use bodyParser.json()

app.get '/', (req, res) ->
  res.status(200).send 'OK'

app.post '/', (req, res) ->

  res.header "Access-Control-Allow-Origin", app.get("origin")

  name = req.body.name
  email = req.body.email
  message = req.body.comment

  if name and email and message



    res.status(200).send "OK"

  else
    res.status(500).send "There are some fields were missed ヽ(^ᴗ^)丿"



app.listen app.get('port'), ->
  console.log 'Node app is running on port', app.get('port')
