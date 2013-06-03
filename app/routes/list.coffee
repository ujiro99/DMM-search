dmm    = require('../models/dmm')
util   = require('../util')
status = require('http-status')


module.exports =

  ###
   POST query to search page.
  ###
  post: (req, res, next) ->

    params = req.body.search
    console.log params

    try
      dmm.search params, (error, response, body) ->
        if error or res.statusCode isnt status.OK
          console.log err
          res.send status.INTERNAL_SERVER_ERROR
          return

        data = util.xml2json body
        console.log data

        if data.response.result.errors
          console.log data.response.result.errors
          res.send status.INTERNAL_SERVER_ERROR
          return

        items = data.response.result.items?.item or []
        res.render 'list',
          title: 'DmmApiSample'
          items: items
    catch e
      console.log e
      res.send status.BAD_REQUEST
