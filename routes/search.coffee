
###
 GET search page.
###

exports.index = (req, res) ->
  res.render('search', { title: 'DmmApiSample' })

