#= require jquery.socialbutton-1.9.1.min

url = 'http://dmm-search.herokuapp.com/search'

$ ->

  $('#twitter').socialbutton('twitter',
    button : 'vertical'
    text   : 'DMMで検索!'
    url    : url)

  $('#facebook').socialbutton('facebook_like',
    button : 'box_count'
    url    : url).height(67)

  $('#google').socialbutton('google_plusone',
    button : 'tall'
    url    : url
    parsetags: 'explicit'
    count  : true)

  $('#hatena').socialbutton('hatena',
    button : 'vertical'
    url    : url
    title  : 'DMM search')
