request  = require('request')
status   = require('http-status')
check    = require('validator').check
util     = require('../util')
define   = require('../define')
ecl      = require('../lib/ecl')
param    = define.param

# param validator
validateService = (value) ->
  check(value).len(0, 20)

validateFloor = (value) ->
  check(value).len(0, 20)

validateHits = (value) ->
  check(value).isInt().min(1).max(100)

validateOffset = (value) ->
  check(value).isInt().min(1)

validateSort = (value) ->
  check(value).len(0, 20)

validateKeyword = (value) ->
  check(value).len(0, 100)


# optional parameter
paramValidator =
  service: validateService
  floor:   validateFloor
  hits:    validateHits
  offset:  validateOffset
  sort:    validateSort
  keyword: validateKeyword

# parameter key list
validKeys = []
for key of paramValidator then validKeys.push key


# query
buildQuery = (optionalParams) ->

  # validate
  for k, v of optionalParams
    checkParam(k, v) if v?

  # merge
  for k, v of optionalParams
    console.log "  #{k} : #{v}"
    param[k] = v if v?

  # encode
  param.timestamp = encodeURIComponent util.getTimestamp()
  param.keyword = ecl.EscapeEUCJP param.keyword

  # build query
  query = define.URL + '?'
  for k, v of param
    query += k + '=' + v + '&' if v?
  query = query.slice(0, -1)

  return query


# if error exists, rise an exception
checkParam = (key, value) ->
  check(key, "使用可能なパラメータ").isIn(validKeys)
  paramValidator[key](value)


# called when received search results
onReceiveResponse = (callback) ->
  (error, response, body) ->
    if error
      callback(error, null)
      return

    if response.statusCode isnt status.OK
      error = new Error('http status error')
      callback(error, null)
      return

    parseResponse(body, callback)


# parse search results
parseResponse = (xml, callback) ->
  data = util.xml2json xml

  if data.response.result.errors
    error = data.response.result.errors
    callback(error, data.response.result)
    return

  callback(null, data.response.result)


# execute
exports.search = (params, callback) ->
  try
    uri = buildQuery params
  catch e
    callback(e, null)
  console.log "Request: GET #{uri}"
  request
    uri: uri
    encoding: null
  , onReceiveResponse(callback)

