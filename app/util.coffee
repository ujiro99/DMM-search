{Iconv}  = require "iconv"
iconvUtf8 = new Iconv('EUC-JP', 'UTF-8//TRANSLIT//IGNORE')


###
 XMLをEUC-JPからUTF-8へ変換したのち、JSONへ変換する
###
exports.xml2json = (xml) ->
  xml = iconvUtf8.convert(xml).toString()
  JSON.parse(require('xml2json').toJson(xml))


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
