window.pSocialBar = ->

  FIX_START = 69
  MIN_WIDTH = 767
  URL = 'http://dmm-search.herokuapp.com/search'

  _this = null

  Polymer('p-social-bar', {

    scroller: {}
    ready: () ->
      _this = this
      $(window).on('resize', this.fixPosition)

    ###
     don't pile search form and social box
    ###
    fixPosition: () ->
      scrollTop = $(this.scroller).scrollTop()
      scrollBottom = scrollTop + $(window).height()

      # out of document area
      if scrollTop < 0 or scrollBottom > $(document).height()
        return

      remain = scrollBottom - $(_this.$.socialBox).height()
      if remain > FIX_START
        $(_this.$.socialBox).addClass 'fixed'
      else
        $(_this.$.socialBox).removeClass 'fixed'

    ###
     click event of go top
    ###
    gotoTop: () ->
      $(this.scroller).animate({ scrollTop: 0 }, 'slow','swing')
      return false

  })
