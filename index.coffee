express = require 'express'
app = express()

http = require 'http'
path = require 'path'
fs = require 'fs'

#app config
app.set 'port', (process.env.PORT)



###================================================================================================
Routs
================================================================================================###

#routs to access the app

###
app.get '/', (req, res)  ->  
  console.log "requesting series homepage"
  res.redirect '/index.html'
  return

###




# server = app.listen app.get('port'), ->
console.log "Attempting to start server at #{app.get('port')}"
server = http.createServer(app).listen app.get('port'), ->
  ##
  address = server.address()
  console.log "Node app is running at ", address
  if process.platform is 'darwin'
    powHost = "windows.tvseries"
    powFile = path.resolve process.env['HOME'], ".pow/#{powHost}"
    fs.writeFile powFile, address.port, (err) =>
      return console.error err if err
      console.log "Hosted on: #{powHost}.dev"
      unhost = ->
        try
          fs.unlinkSync powFile
          console.log "Unhosted from: #{powHost}.dev"
        catch e
          return console.error err if err
        return
      process.on 'SIGINT', -> unhost(); process.exit(); return
      process.on 'exit', (code) -> unhost(); return
  ##
  return

app.use express.static __dirname + '/public'




























