#= require jquery.socialbutton-1.9.1.min

FIX_START = 235
MIN_WIDTH = 767
url = 'http://dmm-search.herokuapp.com/search'

$ ->

  ###
   ready event
  ###
  $(document).ready ->
    if $(window).width() > MIN_WIDTH
      addSocialButtonPCandTablet()
      fixSocialBoxPosition()
      $(window).scroll fixSocialBoxPosition
    else
      $('#social_box').insertAfter('#header-hr')
      addSocialButtonMobile()


  ###
   don't pile search form and social box
  ###
  fixSocialBoxPosition = () ->
    scrollTop = $(window).scrollTop()
    scrollBottom = scrollTop + $(window).height()

    # out of document area
    if scrollTop < 0 or scrollBottom > document.height
      return

    if scrollBottom - $('#social_box').height() > FIX_START
      $('#social_box').addClass 'fixed'
    else
      $('#social_box').removeClass 'fixed'


  ###
   add SocialButtons for PC and Tablet
  ###
  addSocialButtonPCandTablet = () ->
    $('#twitter').socialbutton('twitter',
      button : 'vertical'
      text   : 'DMMで検索！ | DMM search'
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


  ###
   add SocialButtons for Mobile
  ###
  addSocialButtonMobile = () ->
    $('#twitter').socialbutton('twitter',
      button : 'horizontal'
      text   : 'DMMで検索！ | DMM search'
      url    : url)

    $('#facebook').socialbutton('facebook_like',
      button : 'button_count'
      url    : url)

    $('#google').socialbutton('google_plusone',
      button : 'medium'
      url    : url
      parsetags: 'explicit'
      count  : true)

    $('#hatena').socialbutton('hatena',
      button : 'standard'
      url    : url
      title  : 'DMM search')
