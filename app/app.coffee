###
 Module dependencies
###
express = require("express")
http    = require("http")
path    = require("path")
assets  = require("connect-assets")
index   = require("./routes")
search  = require("./routes/search")


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
  app.use express.favicon("#{rootDir}/public/favicon.ico", maxAge: 2592000000)
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static("#{rootDir}/public")
  app.use assets(src: 'app/assets', buildDir: 'app/builtAssets')

app.configure "production", ->
  app.use (err, req, res, next) ->
    console.error(err.stack)
    res.status(500)
    res.render('500', {title: "エラーが発生しました。"})
  app.locals.production = true

app.configure "development", ->
  console.log 'This is development mode.'
  app.use express.errorHandler()
  app.locals.production = false


###
 route
###
app.get  "/",          index.get
app.get  "/search",    search.get
app.get  "/search18",  search.getR18
app.post "/search",    search.post


###
 start
###
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

