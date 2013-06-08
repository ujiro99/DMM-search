check    = require('validator').check
util     = require('../util')
define   = require('../define')
ecl      = require('../lib/ecl')

class DmmParam

  @param = define.param

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

  # if error exists, rise an exception
  checkParam = (key, value) ->
    check(key, "使用可能なパラメータ").isIn(validKeys)
    paramValidator[key](value)


  ###
   build query
  ###
  @buildQuery: (optionalParams) ->

    # validate
    for k, v of optionalParams
      checkParam(k, v) if v?

    # merge
    param = {}
    for k, v of @param then param[k] = v
    for k, v of optionalParams then param[k] = v if v?

    # encode
    param.timestamp = encodeURIComponent util.getTimestamp()
    param.keyword = ecl.EscapeEUCJP param.keyword

    # build
    query = define.URL + '?'
    for k, v of param
      if( v? && v.length isnt 0 )
        query += k + '=' + v + '&'
    query = query.slice(0, -1)

    return query


module.exports = DmmParam
