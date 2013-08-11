#= require jquery.socialbutton-1.9.1.min

FIX_START = 225
url = 'http://dmm-search.herokuapp.com/search'

$ ->

  ###
   ready event
  ###
  $(document).ready ->
    addSocialButton()


  ###
   scroll event
  ###
  $(window).scroll ->
    scrollTop = $(window).scrollTop()
    scrollBottom = scrollTop + $(window).height()
    if scrollBottom - $('#social_box').height() > FIX_START
      if scrollBottom < document.height
        $('#social_box').addClass 'fixed'
    else
      if scrollTop >= 0
        $('#social_box').removeClass 'fixed'


  ###
   add SocialButtons
  ###
  addSocialButton = () ->
    if $(window).width() > 767
      addSocialButtonPCandTablet()
    else
      addSocialButtonMobile()


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
