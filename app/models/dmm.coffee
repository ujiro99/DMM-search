request  = require("request")
util     = require('../util')
check    = require('validator').check
define   = require("../define")
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

  # encode
  param.TIMESTAMP.value = encodeURIComponent util.getTimestamp()
  optionalParams.keyword = ecl.EscapeEUCJP optionalParams.keyword

  # build query
  query = define.URL + '?'
  for k, v of param
    query += v.name + '=' + v.value + '&' if not v.optional
  for k, v of optionalParams
    query += k + '=' + v  + '&' if v?
  query = query.slice(0, -1)

  return query


# if error exists, rise an exception
checkParam = (key, value) ->
  check(key, "使用可能なパラメータ").isIn(validKeys)
  paramValidator[key](value)


# execute
exports.search = (params, callback) ->
  uri = buildQuery params
  console.log "Request: GET #{uri}"
  request
    uri: uri
    encoding: null
  , callback

