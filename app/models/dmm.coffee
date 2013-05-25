request = require("request")
util = require('../util')


# params
api_id  = "CbypEuL7JxVm6Q0dF72Y"
aff_id  = "asamples-990"
time    = encodeURIComponent util.getTimestamp()
url     = "http://affiliate-api.dmm.com/"
keyword = "%B5%F0%C6%FD"


# query
param =  "api_id=#{api_id}&affiliate_id=#{aff_id}&operation=ItemList&version=2.00&timestamp=#{time}&site=DMM.co.jp&keyword=#{keyword}"
req = url + '?' + param


# execute
exports.search = (callback) ->
  request
    uri: req
    encoding: null
  , callback

