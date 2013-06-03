# Reference:
# https://affiliate.dmm.com/api/reference

module.exports =

  # DMM api url
  URL : "http://affiliate-api.dmm.com/"

  # parameter keys
  param:

    # mandatory
    API_ID       : name: "api_id",       optional: false, value: "CbypEuL7JxVm6Q0dF72Y"
    AFFILIATE_ID : name: "affiliate_id", optional: false, value: "asamples-990"
    OPERATION    : name: "operation",    optional: false, value: "ItemList"
    VERSION      : name: "version",      optional: false, value: "2.00"
    TIMESTAMP    : name: "timestamp",    optional: false, value: ""
    SITE         : name: "site",         optional: false, value: "DMM.com" #18禁は DMM.co.jp

    # optional
    SERVICE : name: "service", optional: true
    FLOOR   : name: "floor",   optional: true
    HITS    : name: "hits",    optional: true
    OFFSET  : name: "offset",  optional: true
    SORT    : name: "sort",    optional: true
    KEYWORD : name: "keyword", optional: true

