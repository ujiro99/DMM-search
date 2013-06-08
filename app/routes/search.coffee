dmm    = require('../models/dmm')
status = require('http-status')

module.exports =

  ###
   GET search page.
  ###
  get : (req, res, next) ->
    res.render 'search',
      title: 'DmmApiSample'


  ###
   POST query.
  ###
  post: (req, res, next) ->

    params = req.body.search
    console.log params

    dmm.search params, (error, result) ->
      if error
        res.send status.INTERNAL_SERVER_ERROR
        return

      items = result.items?.item or []
      res.send items
