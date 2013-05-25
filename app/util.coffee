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


###
 タイムスタンプを生成する
###
exports.getTimestamp = ->

  d = new Date()
  year  = d.getFullYear()
  month = d.getMonth() + 1
  day   = d.getDate()
  hour  = if d.getHours()   < 10 then '0' + d.getHours()   else d.getHours()
  min   = if d.getMinutes() < 10 then '0' + d.getMinutes() else d.getMinutes()
  sec   = if d.getSeconds() < 10 then '0' + d.getSeconds() else d.getSeconds()

  timestamp = "#{year}-#{month}-#{day} #{hour}:#{min}:#{sec}"
