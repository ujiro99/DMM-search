# Reference:
# https://affiliate.dmm.com/api/reference

module.exports =

  # DMM api url
  URL: "http://affiliate-api.dmm.com/"

  # parameter define
  PARAMS:
    API_ID:       name: "api_id",       optional: false
    AFFILIATE_ID: name: "affiliate_id", optional: false
    OPERATION:    name: "operation",    optional: false
    VERSION:      name: "version",      optional: false
    TIMESTAMP:    name: "timestamp",    optional: false
    SITE:         name: "site",         optional: false
    SERVICE:      name: "service",      optional: true
    FLOOR:        name: "floor",        optional: true
    HITS:         name: "hits",         optional: true
    OFFSET:       name: "offset",       optional: true
    SORT:         name: "sort",         optional: true
    KEYWORD:      name: "keyword",      optional: true

  # initial parameter
  param:
    api_id:       "CbypEuL7JxVm6Q0dF72Y"
    affiliate_id: "asamples-990"
    operation:    "ItemList"
    version:      "2.00"
    site:         "DMM.com"    #18禁は DMM.co.jp
