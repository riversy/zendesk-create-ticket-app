# Zendesk Ticket Creator

Simple app for [Heroku](https://www.heroku.com/) that get form submits from the web and create new ticket on [Zendesk](https://www.zendesk.com/) via it's API.

## Usage

Clone the repo and create Heroku app as usual. Add following environment variables with Zendesk access credentials.

- **ORIGIN** - might be "\*" or your domain
- **ZENDESK_TOKEN** - API token
- **ZENDESK_USERNAME** - email of your Zendesk user
- **ZENDESK_DOMAIN** - domain for your company's helpdesk. *company.zendesk.com* for example. 

You may define these variables in the Heroku app settings.
