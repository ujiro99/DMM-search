dmm = require('../models/dmm')
util = require('../util')


###
 GET search page.
###
exports.index = (req, res) ->

  dmm.search (error, response, body) ->
    if error or res.statusCode isnt 200
      console.log err
      return

    data = util.xml2json body
    items = data.response.result.items.item

    res.render 'search',
      title: 'DmmApiSample'
      items: items

