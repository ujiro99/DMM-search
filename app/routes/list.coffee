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

    dmm.search params, (error, result) ->
      if error
        res.send status.INTERNAL_SERVER_ERROR
        return

      items = result.items?.item or []
      res.render 'list',
        title: 'DmmApiSample'
        items: items
