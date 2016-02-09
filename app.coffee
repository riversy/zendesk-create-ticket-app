'use strict'

express = require 'express'
bodyParser = require 'body-parser'
zendesk = require 'node-zendesk'




app = express()

# Init variables
app.set 'port', process.env.PORT or 5000
app.set 'username', process.env.ZENDESK_USERNAME or 'username'
app.set 'domain', process.env.ZENDESK_DOMAIN or 'user.zendesk.com'
app.set 'token', process.env.ZENDESK_TOKEN or 'token'
app.set 'origin', process.env.ORIGIN or "*"

# Init Zendesk Client
client = zendesk.createClient
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
  subject = req.body.subject
  comment = req.body.comment

  if name and email and comment

    ticket =
      name: name
      email: email
      subject: subject
      comment:
        body: comment

    console.log subject

    client.tickets.create ticket, (err, req, result) ->

      console.log result

      if err
        res.status(500).send err
      else
        res.status(200).send "OK"

  else
    res.status(500).send "There are some fields were missed ヽ(^ᴗ^)丿"



app.listen app.get('port'), ->
  console.log 'Node app is running on port', app.get('port')
