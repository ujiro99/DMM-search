dmm    = require('../models/dmm')
status = require('http-status')


module.exports =

  ###
   POST query from search page.
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
