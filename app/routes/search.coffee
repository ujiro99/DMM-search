
module.exports =

  ###
   GET search page.
  ###
  get : (req, res, next) ->
    res.render 'search',
      title: 'DmmApiSample'

