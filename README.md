# Elixirbnb

**To install and run locally:**

`mix deps.get` to install
`cd assets && npm install` to install front-end packages

`mix ecto create` to create the database
`mix ecto migrate` to add or update the tables

create a file called `.env` in the root directory of the project
in that file add your sendgrid API key

```
export SENDGRID_API_KEY="api key goes here"
```

`mix phx.server` to run the server.
