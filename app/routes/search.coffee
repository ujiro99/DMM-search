dmm    = require('dmm')
status = require('http-status')

module.exports =

  ###
   GET search page.
  ###
  get: (req, res, next) ->
    res.render 'search',
      version: require('../../package.json').version
      title: 'DMM search'
      site: 'DMM.com'


  ###
   GET R18 search page.
  ###
  getR18: (req, res, next) ->
    res.render 'search',
      version: require('../../package.json').version
      title: 'DMM search'
      site: 'DMM.co.jp'


  ###
   POST query.
  ###
  post: (req, res, next) ->

    params = req.body.search
    params.api_id = "CbypEuL7JxVm6Q0dF72Y"
    params.affiliate_id =  "asamples-990"

    console.log params

    dmm.search params, (error, result) ->
      if error
        res.send status.INTERNAL_SERVER_ERROR
        return

      items = result.items?.item or []
      res.send items
