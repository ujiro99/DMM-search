dmm = require('../dmm')
{Iconv}  = require "iconv"
iconv = new Iconv('EUC-JP', 'UTF-8//TRANSLIT//IGNORE')

###
 レスポンスボディをEUC-JPからUTF-8へ変換したのち、XMLをJSONへ変換する
###
xml2json = (body) ->
  body = body = iconv.convert(body).toString()
  JSON.parse(require('xml2json').toJson(body))


###
 GET search page.
###

exports.index = (req, res) ->

  dmm.search (error, response, body) ->
    if error or res.statusCode isnt 200
      console.log err
      return

    data = xml2json body
    items = data.response.result.items.item

    res.render 'search',
      title: 'DmmApiSample'
      items: items

