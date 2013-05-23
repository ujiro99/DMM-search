request = require("request")


getTimestamp = ->

  d = new Date()
  year  = d.getFullYear()
  month = d.getMonth() + 1
  day   = d.getDate()
  hour  = if d.getHours()   < 10 then '0' + d.getHours()   else d.getHours()
  min   = if d.getMinutes() < 10 then '0' + d.getMinutes() else d.getMinutes()
  sec   = if d.getSeconds() < 10 then '0' + d.getSeconds() else d.getSeconds()

  timestamp = "#{year}-#{month}-#{day} #{hour}:#{min}:#{sec}"


api_id = "CbypEuL7JxVm6Q0dF72Y"
aff_id = "asamples-990"
time = encodeURIComponent getTimestamp()
url = "http://affiliate-api.dmm.com/"
param =  "api_id=#{api_id}&affiliate_id=#{aff_id}&operation=ItemList&version=2.00&timestamp=#{time}&site=DMM.co.jp&keyword=%B5%F0%C6%FD"
req = url + '?' + param


exports.search = (callback) ->
  request
    uri: req
    encoding: null
  , callback

