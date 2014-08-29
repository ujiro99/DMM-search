#= require options

window.searchResult = () ->

  GET_NUM = 30
  MIN_OFFSET = 1
  MIN_WIDTH = 767
  CREDIT = "<a href='https://affiliate.dmm.com/api/'><img src='http://pics.dmm.com/af/web_service/com_135_17.gif' width='135' height='17' alt='WEB SERVICE BY DMM.com' /></a>"
  CREDIT_R18 = "<a href='https://affiliate.dmm.com/api/'><img src='http://pics.dmm.com/af/web_service/r18_135_17.gif' width='135' height='17' alt='WEB SERVICE BY DMM.R18' /></a>"
  
  _this = null
  _masonry = null
  
  currentOption = {}
  lastQuery = {}
  requestEnable = true
  req = null

  
  ###
   if enter key clicked on keyword form, start searching.
  ###
  focusNextForm = (e) ->
    if e.keyCode == 13  # enter key
      id = e.target.id
      if id is 'keyword'
        $(_this.$.searchButton).focus()

  ###
   change select options of #service and #floor
  ###
  changeOption = () ->
    isR18 = _this.site is "DMM.co.jp"
    if isR18
      currentOption = options18
      $('.dmm-credit').html(CREDIT_R18)
    else
      currentOption = options
      $('.dmm-credit').html(CREDIT)
    _this.$.service.items = currentOption.getOptions()
    changeFloor()


  ###
   change select options of #floor
  ###
  changeFloor = () ->
    selected = _this.$.service.selected
    if selected is 0 then selected = ''
    newOption = currentOption.getChildrenByValue(selected)
    if newOption?
      this.$.floor.items = newOption.getOptions()

  ###
   submit search query
  ###
  submit = (e) ->
    e.preventDefault()
    lastQuery = getFormData()
    lastQuery.offset = MIN_OFFSET
    lastQuery.hits = GET_NUM
    request()


  ###
   request to server
  ###
  request = () ->
    requestEnable = false
    $(_this.$.loading).show()
    req = $.ajax
      type: "POST"
      url: "/search"
      data: search: lastQuery
      success: requestSuccess


  ###
   received response, then render result
  ###
  requestSuccess = (msg) ->
    req = null
    $(_this.$.loading).hide()
    renderResult(msg)


  ###
   cancel request
  ###
  requestCancel = () ->
    requestEnable = true
    if req isnt null
      req.abort()
      req = null
    $(_this.$.loading).hide()


  ###
   get data from search form
  ###
  getFormData = () ->
    data =
      site:    _this.site
      service: _this.$.service.selected
      floor:   _this.$.floor.selected
      keyword: _this.$.keyword.value


  ###
   render received data
  ###
  renderResult = (items) ->
    if items.length > 0
      elems = []
      elements = document.createDocumentFragment()
      for item in items
        el = document.createElement("p-item")
        el.item = item
        elements.appendChild(el)
        elems.push el
      imagesLoaded elements, () ->
        _this.$.itemContainer.appendChild this.elements[0]
        _masonry.appended elems
        _masonry.layout()
        requestEnable = true
      lastQuery.offset += GET_NUM
    else
      requestEnable = false
      $(_this.$.loadComplete).show()


  Polymer('search-result', {

    ###
      on polymer ready evnet fired, start initialize.
    ###
    ready: () ->
      _this = this
      _masonry = new Masonry(this.$.itemContainer, {itemSelector: "p-item", columnWidth: 164, transitionDuration: 0})

      $(window).on('keydown', focusNextForm)

      changeOption()


    ###
     click event of go top
    ###
    gotoTop: () ->
      $('html,body').animate({ scrollTop: $($(this).attr("href")).offset().top }, 'slow','swing')
      return false


    ###
     start search
    ###
    startSearch: (e) ->
      if not requestEnable
        requestCancel()
      for i in _masonry.items
        _masonry.remove(_masonry.items[0].element)
      _masonry.layout()
      $(_this.$.loadComplete).hide()
      submit(e)


    ###
     change select options of #floor
    ###
    changeFloor: changeFloor


    ###
     request item data if space remained
    ###
    requestNextItem: (e, detail, sender) ->
      heightRemain = detail.target.scrollHeight - detail.target.scrollTop
      if requestEnable and heightRemain <= screen.availHeight * 2
        if lastQuery.hasOwnProperty('site')
          request()
          console.info 'request: ' + heightRemain

  })
