{Iconv}  = require "iconv"
iconvUtf8 = new Iconv('EUC-JP', 'UTF-8//TRANSLIT//IGNORE')
iconvEucJp = new Iconv('UTF-8//TRANSLIT//IGNORE', 'EUC-JP')

###
 レスポンスボディをEUC-JPからUTF-8へ変換したのち、XMLをJSONへ変換する
###
exports.xml2json = (body) ->
  body = iconvUtf8.convert(body).toString()
  JSON.parse(require('xml2json').toJson(body))

###
 文字列ををUTF-8からEUC-JPへ変換する
###
exports.toEucJp = (str) ->
  iconvEucJp.convert(str)
