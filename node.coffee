App= require 'express'

{config}= require './package.json'

app= App()

app.use App.logger('dev')
app.use '/', App.static('./app/browser')

app.listen config.port, ->
    console.info 'Listening on port %d', config.port
