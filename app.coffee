'use strict'

fs = require 'fs'
express = require 'express'
bodyParser = require 'body-parser'
zendesk = require 'node-zendesk'
app = express()

# Init variables
try
  fs.accessSync('./local.env.coffee', fs.R_OK)
  local = require('./local.env.coffee')
catch e
  local = {}

app.set 'port', process.env.PORT or 5000
app.set 'username', process.env.ZENDESK_USERNAME or local.username or 'username'
app.set 'domain', process.env.ZENDESK_DOMAIN or local.domain or 'user.zendesk.com'
app.set 'token', process.env.ZENDESK_TOKEN or local.token or 'token'
app.set 'origin', process.env.ORIGIN or local.origin or "*"

# Init Zendesk Client
client = zendesk.createClient
  username:  app.get('username')
  token:     app.get('token')
  remoteUri: "https://#{app.get('domain')}/api/v2"

console.log
  username:  app.get('username')
  token:     app.get('token')
  remoteUri: "https://#{app.get('domain')}/api/v2"

# Handle POST submits
app.use bodyParser.urlencoded(extended: true)
app.use bodyParser.json()

# Status response
app.get '/', (req, res) ->
  res.status(200).send 'OK'

# Submit response
app.post '/', (req, res) ->

  res.header "Access-Control-Allow-Origin", app.get("origin")

  name = req.body.name
  email = req.body.email
  comment = req.body.comment

  if name and email and comment

    submit =
      ticket:
        subject: "New message from #{name}"
        comment:
          body: comment
          uploads: []
        requester:
          name: name
          email: email

    client.tickets.create submit, (err) ->
      if err
        res.status(500).send err
      else
        res.status(200).send "OK"

  else
    res.status(500).send "There are some fields were missed ヽ(^ᴗ^)丿"

app.listen app.get('port'), ->
  console.log 'Node app is running on port', app.get('port')
