###
 Module dependencies
###
express = require("express")
http    = require("http")
path    = require("path")
index   = require("./routes")
search  = require("./routes/search")
list    = require("./routes/list")


###
 init
###
rootDir = __dirname.substring(0, __dirname.lastIndexOf("/"))


###
 config
###
app = express()
app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", "#{rootDir}/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser("your secret here")
  app.use express.session()
  app.use app.router
  app.use express.static("#{rootDir}/public")

app.configure "development", ->
  app.use express.errorHandler()


###
 route
###
app.get  "/",          index.get
app.get  "/search",    search.get
app.post "/list",      list.post


###
 start
###
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

