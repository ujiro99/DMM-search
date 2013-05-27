dmm  = require('../models/dmm')
util = require('../util')


###
 GET search page.
###
exports.index = (req, res) ->

  params =
    service: "rental"
    floor: "ppr_cd"
    keyword: "やくしまるえつこ"

  dmm.search params, (error, response, body) ->
    if error or res.statusCode isnt 200
      console.log err
      res.send 500
      return

    data = util.xml2json body
    console.log body.toString()
    console.log data

    if data.response.result.errors
      console.log data.response.result.errors
      res.send 500
      return

    items = data.response.result.items?.item or []
    res.render 'search',
      title: 'DmmApiSample'
      items: items

