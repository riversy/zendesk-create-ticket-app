'use strict'

express = require 'express'
bodyParser = require 'body-parser'

app = express()

app.set 'port', process.env.PORT or 5000
app.set 'token', process.env.ZENDESK_TOKEN or 'token'
app.set 'redirect', process.env.REDIRECT or false

app.use bodyParser.urlencoded(extended: true)
app.use bodyParser.json()

app.get '/', (req, res) ->
  res.status(200).send 'OK'

app.post '/', (req, res) ->

  console.log app.get 'token'
  console.log app.get 'redirect'

  res.status(200).json req.body


app.listen app.get('port'), ->
  console.log 'Node app is running on port', app.get('port')
